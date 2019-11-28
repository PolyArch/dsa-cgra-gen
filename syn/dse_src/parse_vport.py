from os import listdir
from os.path import isfile, join, isdir
import re
import datetime
import time
import csv

regex_float = r"[+\-]?(?:0|[1-9]\d*)(?:\.\d*)?(?:[eE][+\-]?\d+)?"
report_dir = "/home/sihao/ss-stack/ss-cgra-gen/syn/Reports/"
output_dir = report_dir

def find_all_dirs(dir):
    return [f for f in listdir(dir) if isdir(join(dir, f))]


def parse_area(rep_dir):
    with open(report_dir + rep_dir + "/VectorPort_Hw.mapped.area.rpt", 'r') as f:
        lines = f.readlines()
        for line in lines:
            if "Total cell area:" in line:
                sta_search = re.search(regex_float, line)
                if sta_search:
                    statistic = re.findall(regex_float, line)
                    return statistic[0]

def parse_power(rep_dir):
    with open(report_dir + rep_dir + "/VectorPort_Hw.mapped.power.rpt", 'r') as f:
        lines = f.readlines()
        hit_report_group = False
        hit_Total = False
        for line in lines:
            if "Power Group" in line:
                hit_report_group = True
            if hit_report_group:
                if "Total" in line:
                    sta_search = re.search(regex_float, line)
                    if sta_search:
                        statistic = re.findall(regex_float, line)
                        statistic.reverse()
                        return statistic[0]

all_reports_dir = find_all_dirs(report_dir)

all_features = []
for single_rep_dir in all_reports_dir:
    single_feature = {}
    spilt_rep_dir = single_rep_dir.split("_")
    num_input = spilt_rep_dir[5]
    num_output = spilt_rep_dir[7]
    temp = spilt_rep_dir[9]
    temp_split = temp.split(".")
    buffer = temp_split[0]
    single_feature["num_input"] = num_input
    single_feature["num_output"] = num_output
    single_feature["buffer"] = buffer
    single_feature["area"] = parse_area(single_rep_dir)
    single_feature["power"] = parse_power(single_rep_dir)
    all_features.append(single_feature)

ts = time.time()
st = datetime.datetime.fromtimestamp(ts).strftime('_%Y%m%d_%H%M%S')
output_filename = output_dir + "vport" + st + ".csv"
with open(output_filename, 'w') as f:  # Just use 'w' mode in 3.x
    head = all_features[0].keys()
    w = csv.DictWriter(f, head)
    w.writeheader()
    for oneDataPoint in all_features:
        w.writerow(oneDataPoint)