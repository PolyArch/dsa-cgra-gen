import itertools
import yaml
import sys
sys.path.insert(0, '/home/sihao/ss-cgra-gen/src/analytical_model/src/result_parser')
from parse_util import find_all_files, find_all_dirs

def elaborate_dse(dse_option):
    dse_keys = [k for k, v in dse_option.items()]
    dse_options = [v for k, v in dse_option.items()]
    len_dse = 1
    for single_dse_option in dse_options:
        len_dse = len_dse * len(single_dse_option)
    dse_space = itertools.product(*dse_options)
    return dse_keys, dse_space, len_dse


def get_all_synthesized_ir(VL_dir, Rep_dir):
    all_report_dir = [dir for dir in find_all_dirs(Rep_dir) if ".v" in dir]
    all_vl_files = find_all_files(VL_dir)
    all_ir = []
    finished = 0
    for each_rep_dir in all_report_dir:
        filenames_in_this_dir = find_all_files(Rep_dir + each_rep_dir)
        if len(filenames_in_this_dir) == 10:
            for each_vl_file in all_vl_files:
                if each_vl_file in each_rep_dir:
                    ir, num_vl_lines = extract_IR_from_verilog(VL_dir + each_vl_file)
                    all_ir.append(ir)
        finished += 1
        print("Processing Synthesized Data Point: Finished : " + str(finished) + ", Total: " + str(len(all_report_dir)) + "\n")
    return all_ir


def isSynthesized(ir, all_synd_ir):
    return ir in all_synd_ir


def extract_sta_from_IR(ir):
    ir_sta = {}
    for k, v in ir.items():
        if k == "input_ports":
            ir_sta["num_input_ports"] = len(v)
        elif k == "output_ports":
            ir_sta["num_output_ports"] = len(v)
        elif isinstance(v, dict):
            for kk, vv in v.items():
                ir_sta[k + "-" + kk] = vv
        else:
            ir_sta[k] = v
    return ir_sta


def extract_IR_from_verilog(verilog_filename):
    start = False
    end = False
    ir_str = ""
    vl_num_of_line = 0
    with open(verilog_filename,'r') as vl_file:
        for line in vl_file.readlines():
            if "/*" in line:
                start = True
                continue
            if "*/" in line:
                end = True
            if start and not end:
                ir_str = ir_str + line
            else:
                vl_num_of_line += 1
    ir = yaml.load(ir_str)
    ir.pop("DSE", None)
    return ir, vl_num_of_line


def update_design_point(ir_f_name, design_demension, design_point):
    ir_f = open(ir_f_name, 'r')
    ir = yaml.load(ir_f)
    ir_f.close()
    for dimension in design_demension:
        ir[dimension] = design_point[design_demension.index(dimension)]
    ir.pop("DSE", None)
    return ir


def change_design(dc_dir, design_n):
    common_setup = open(dc_dir + "common_setup.tcl", 'r')
    all_ori_lines = common_setup.readlines()
    common_setup.close()
    new_common_setup = open(dc_dir + "common_setup.tcl", 'w')
    for line in all_ori_lines:
        if line.startswith("set DESIGN_NAME"):
            line = "set DESIGN_NAME \"" + design_n + "\" ;#  The name of the top-level design\n"
        new_common_setup.write(line)
    new_common_setup.close()


def change_design_file(dc_dir, design_file):
    common_setup = open(dc_dir + "common_setup.tcl", 'r')
    all_ori_lines = common_setup.readlines()
    common_setup.close()
    new_common_setup = open(dc_dir + "common_setup.tcl", 'w')
    for line in all_ori_lines:
        if line.startswith("set DESIGN_FILE_NAME"):
            line = "set DESIGN_FILE_NAME \"" + design_file + "\"\n"
        new_common_setup.write(line)
    new_common_setup.close()
