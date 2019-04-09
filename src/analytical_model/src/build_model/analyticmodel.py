#!/usr/local/bin/python3

import sys
import datetime
import time
import csv
sys.path.insert(0, '/home/sihao/ss-cgra-gen/src/analytical_model/src/result_parser')
from collect_statistic import get_statistic
from parse_util import find_all_files, find_all_dirs
from dse_util import extract_IR_from_verilog, extract_sta_from_IR



# Set Directory
home_dir = "/home/sihao/ss-cgra-gen/"
IR_dir = home_dir + "IR/"
DC_dir = home_dir + "syn/"
VL_dir = home_dir + "verilog-output/"
Rep_dir = DC_dir + "Reports/"
Output_Dir = "/home/sihao/ss-cgra-gen/src/analytical_model/resource/"

# Parameter
output_whole_designspace = True
limit_num = -1
target_designs = ["Dedicated_PE", "Router"]

# Get Statistic
db = get_statistic(output_whole_designspace, limit_num)

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
all_designFiles = db_syn.keys()
all_vl_file = find_all_files(VL_dir)
for vl_file in all_vl_file:
    vl_filename = vl_file.split(".")[0]
    if limit_num > 0:
        if len(db_ir) >= limit_num:
            break
    print("Read Verilog File - Finished: " + str(len(db_ir)) + ", Total: " + str(len(all_vl_file)) + "\n")
    if vl_filename in all_designFiles:
        ir = extract_IR_from_verilog(VL_dir + vl_file)
        ir_statistic = extract_sta_from_IR(ir)
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

print("Model Built!")
