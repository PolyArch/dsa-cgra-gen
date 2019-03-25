#!/usr/local/bin/python3

import re

regex_float = r"[-+]?[0-9]*\.?[0-9]+"

def parse_mapped_area(file, sta):
    f = open(file, 'r')
    lines = f.readlines()
    feature_select = sta[1]
    keys = feature_select.keys()
    result = {}
    for line in lines:
        for key in keys:
            if feature_select[key] and key in line:
                sta_search = re.search(regex_float, line)
                if sta_search:
                    statistic = sta_search.group(0)
                    result[key] = statistic
                else:
                    result[key] = None
    return result


def parse_mapped_power(file, sta):
    f = open(file, 'r')
    lines = f.readlines()
    feature_select = sta[1]
    keys = feature_select.keys()
    result = {}
    hit_real_report = False
    hit_report_group = False
    hit_Total = False
    statistic_location = 0
    for line in lines:
        if not hit_real_report:
            if "Design        Wire Load Model            Library" in line:
                hit_real_report = True
        if not hit_report_group:
            if "Power Group" in line:
                hit_report_group = True
                statistic_location = 1
        if not hit_Total and hit_report_group:
            if "Total" in line:
                statistic_location = 0
        if hit_real_report:
            for key in keys:
                if feature_select[key] and key in line:
                    sta_search = re.search(regex_float, line)
                    if sta_search:
                        if hit_report_group:
                            statistic = re.findall(regex_float, line)
                            statistic.reverse()
                            statistic = statistic[statistic_location]
                        else:
                            statistic = re.findall(regex_float, line)[statistic_location]
                        result[key] = statistic
                    else:
                        result[key] = None
    return result


def parse_mapped_timing(file, sta):
    f = open(file, 'r')
    lines = f.readlines()
    feature_select = sta[1]
    keys = feature_select.keys()
    result = {}
    for line in lines:
        for key in keys:
            if feature_select[key] and key in line:
                sta_search = re.search(regex_float, line)
                if sta_search:
                    statistic = sta_search.group(0)
                    result[key] = statistic
                else:
                    result[key] = None
    return result


def parse_dc_config(rep_dir):
    args = rep_dir.split("_")
    config = {}
    config["designname"] = args[0]
    config["mainFeature"] = args[1]
    config["techFeature"] = args[2]
    config["techSubFeature"] = args[3]
    config["process"] = args[4]
    config["VTfeature"] = args[5]
    config["techModel"] = args[6]
    config["thresModel"] = args[7]
    config["voltage"] = args[8]
    config["temperature"] = args[9]
    config["period"] = args[10]
    return config
