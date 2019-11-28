#!/usr/local/bin/python3

import sys
import datetime
import time
import csv
import glob
import os
import pandas as pd
sys.path.insert(0, '/home/sihao/ss-cgra-gen/src/analytical_model/src/result_parser')
from collect_statistic import get_statistic
from parse_util import find_all_files, find_all_dirs
from dse_util import extract_IR_from_verilog, extract_sta_from_IR
from trainModel import trainRegression


# Set Directory
home_dir = "/home/sihao/ss-cgra-gen/"
hw_dir = "/home/sihao/ss-cgra-upd/"
IR_dir = home_dir + "IR/"
DC_dir = hw_dir + "syn/"
VL_dir = hw_dir + "verilog-output/"
Rep_dir = DC_dir + "Reports/"
Output_Dir = "/home/sihao/ss-cgra-gen/src/analytical_model/resource/"

# Parameter
output_write_csv = True
collect_new_data_point = True
need_trainModel = False
limit_num = -1
target_designs = ["Dedicated_PE", "Router"]
predict_target = ["mapped.area-Total cell area", "mapped.power-Total"]
design_feature = {'Dedicated_PE': {'decomposer':'Num', 'delay_fifo_depth':'Num',
                                   'num_input_ports':'Num', 'num_output_ports':'Num',
                                   'isShared':'Categorical', 'output_select_mode':'Categorical',
                                   'protocol':'Categorical', 'register_file_size':'Num',
                                   'shared_slot_size':'Num'},
                  'Router': {'back_pressure_fifo_depth':'Num', 'decomposer':'Num',
                             'num_input_ports':'Num', 'num_output_ports':'Num',
                             'isShared':'Categorical', 'protocol':'Categorical',
                             'shared_slot_size':'Num'}}

# Collect New Data
if collect_new_data_point:
    # Get Statistic
    db = get_statistic(output_write_csv, limit_num)

    # Covert to Dict
    db_syn = {}
    for record in db:
        key = record["DesignInFile"]
        record.pop("DesignInFile", None)
        designName = key.split("_Hw", 1)[0] + "_Hw"
        filename = key.split("_Hw_", 1)[1]
        value = record
        value["designName"] = designName
        db_syn[filename] = value

    # Extract IR which complete synthesized
    db_ir = {}
    all_vl_file = find_all_files(VL_dir)
    for vl_file in all_vl_file:
        vl_filename = vl_file.split(".")[0]
        if limit_num > 0:
            if len(db_ir) >= limit_num:
                break
        print("Read Verilog File - Finished: " + str(len(db_ir)) + ", Total: " + str(len(all_vl_file)) + "\n")
        if vl_filename in db_syn:
            ir, num_vl_lines = extract_IR_from_verilog(VL_dir + vl_file)
            ir_statistic = extract_sta_from_IR(ir)
            ir_statistic["num_verilog_lines"] = num_vl_lines
            db_ir[vl_filename] = ir_statistic


    # Merge IR statistic and Synthesize Statistic
    keys = db_ir.keys()
    design_list_dict = {}
    for target_design in target_designs:
        design_list_dict[target_design] = []

    for key in keys:
        temp_dict = {}
        temp_dict["DesignFileName"] = key
        target_design = [s for s in target_designs if s in key][0]
        temp_ir_sta = db_ir[key]
        temp_syn_sta = db_syn[key]
        for k, v in temp_ir_sta.items():
            temp_dict[k] = v
        for k, v in temp_syn_sta.items():
            temp_dict[k] = v
        design_list_dict[target_design].append(temp_dict)

    # Output CSV
    if output_write_csv:
        ts = time.time()
        st = datetime.datetime.fromtimestamp(ts).strftime('_DSE_%Y%m%d_%H%M%S')
        for target_design, values in design_list_dict.items():
            output_filename = Output_Dir + target_design + st + ".csv"
            with open(output_filename, 'w') as f:  # Just use 'w' mode in 3.x
                sta_head = values[0].keys()
                w = csv.DictWriter(f, sta_head)
                w.writeheader()
                for value in values:
                    w.writerow(value)

# Build Model
if need_trainModel:
    design_model = {}
    for target_design in target_designs:
        feature_field = design_feature[target_design]
        try:
            design_list_dict
        except NameError:
            design_list_dict = None
        if design_list_dict is None:
            list_of_files = [f for f in glob.glob(Output_Dir + "*") if
                             target_design in f]  # * means all if need specific format then *.csv
            latest_file = max(list_of_files, key=os.path.getctime)
            dataset = pd.read_csv(latest_file, usecols=list(feature_field.keys()) + predict_target, na_values="N/A")
        else:
            dataset = pd.DataFrame(design_list_dict[target_design])
        design_model[target_design] = trainRegression(target_design, dataset, feature_field, predict_target)

# Finished
print("Model Built!")
