import itertools


def elaborate_dse(dse_option):
    dse_keys = [k for k, v in dse_option.items()]
    dse_options = [v for k, v in dse_option.items()]
    dse_space = itertools.product(*dse_options)
    return dse_keys, dse_space


def update_design_point(ir_f_name, design_demension, design_point):
    ir_f = open(ir_f_name, 'w')
    for dimension in design_demension:
        ir[dimension] = design_point[design_demension.index(dimension)]

    ir_f.close()
    return
