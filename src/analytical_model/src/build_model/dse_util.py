import itertools
import yaml

def elaborate_dse(dse_option):
    dse_keys = [k for k, v in dse_option.items()]
    dse_options = [v for k, v in dse_option.items()]
    dse_space = itertools.product(*dse_options)
    return dse_keys, dse_space


def update_design_point(ir_f_name, design_demension, design_point):
    ir_f = open(ir_f_name, 'r')
    ir = yaml.load(ir_f)
    ir_f.close()
    for dimension in design_demension:
        ir[dimension] = design_point[design_demension.index(dimension)]
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
