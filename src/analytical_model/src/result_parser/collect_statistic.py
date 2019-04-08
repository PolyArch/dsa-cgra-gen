#!/usr/local/bin/python3

import csv
import yaml
from parse_util import find_all_files, find_all_dirs
import syn_result_parser
from syn_result_parser import *
import datetime
import time

# Verilog File Directory
VL_Dir = "/home/sihao/ss-cgra-gen/verilog-output/"
# Verilog Source Code
Reports_dir = "/home/sihao/ss-cgra-gen/syn/Reports/"
# Output Statistic File Name
Output_Dir = "/home/sihao/ss-cgra-gen/src/analytical_model/resource/"
Output_File = "Cgra_DesignSpace"
# Statistic Structure File
statistic_desc = '/home/sihao/ss-cgra-gen/src/analytical_model/src/result_parser/synthesize_statistic.yaml'


def get_statistic():
    # Get All Report Directory
    all_report_dir = [dir for dir in find_all_dirs(Reports_dir) if ".v" in dir]

    # Read needed feature describe file
    with open(statistic_desc, 'r') as syn_sta_f:
        syn_statistic = yaml.load(syn_sta_f)["synthesize_report_feature"]
        target_features = [[k, v] for k, v in syn_statistic.items()]

    all_results = []
    # Traversal All Configuration Directory
    for report_dir in all_report_dir:
        config = parse_dir_name(report_dir)
        syn_result_dir = Reports_dir + report_dir + "/"
        result_group = {}
        for sta in target_features:
            parserName = "parse_" + sta[0].replace(".", "_")
            syn_reports = find_all_files(syn_result_dir)
            target_report = [f for f in syn_reports if sta[0] in f]
            if target_report:
                report_file_name = target_report[0]
                sub_parser = getattr(syn_result_parser, parserName)
                result = sub_parser(syn_result_dir + report_file_name, sta)
                result_group[sta[0]] = result
        all_results.append((config, result_group))

    # Print All Dictionary
    one_level_dict = []
    for oneResult in all_results:
        temp_oneResult = {}
        config, feature_group = oneResult
        for k, v in config.items():
            temp_oneResult[k] = v
        for g_name, g_feature in feature_group.items():
            for gk, gv in g_feature.items():
                temp_oneResult[g_name + "-" + gk] = gv
        one_level_dict.append(temp_oneResult)

    # Output as CSV
    ts = time.time()
    st = datetime.datetime.fromtimestamp(ts).strftime('_%Y%m%d_%H%M%S')
    output_filename = Output_Dir + Output_File + st + ".csv"
    with open(output_filename, 'w') as f:  # Just use 'w' mode in 3.x
        head = one_level_dict[0].keys()
        w = csv.DictWriter(f, head)
        w.writeheader()
        for oneDataPoint in one_level_dict:
            w.writerow(oneDataPoint)
    # Finished
    print("Statistic Collected!")
    return one_level_dict
