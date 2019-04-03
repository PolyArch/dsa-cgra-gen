import itertools


def elaborate_dse(dse_option):
    dse_keys = [k for k, v in dse_option.items()]
    dse_options = [v for k, v in dse_option.items()]
    dse_space = itertools.product(*dse_options)
    for design_point in dse_space:
        print(design_point)
    return dse_keys, dse_space


def update_design_point(ir, ir_f, design_demension, design_point):
    for dimension in design_demension:
        ir[dimension] = design_point[design_demension.index(dimension)]
    return
