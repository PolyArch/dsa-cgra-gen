import yaml
from dse_util import *
import subprocess
import time

# Set Directory
home_dir = "/home/sihao/ss-cgra-gen/"
IR_dir = home_dir + "IR/"
DC_dir = home_dir + "syn/"
VL_dir = home_dir + "verilog-output/"
Rep_dir = DC_dir + "Reports/"
target_IRs = ["processing_element.yaml","router.yaml"]

# Cgra Generator Driver
cgra_gen = "/home/sihao/ss-cgra-gen/scripts/gen_cgra.sh"

# Multi-thread parameter
parallel = 4
processes = []
finished_num = 0
has_run_num = 0

def check_finished():
    global finished_num
    for process in processes:
        process.poll()
        if process.returncode == 0:  # process end
            print("normally end")
            finished_num += 1
            processes.remove(process)
            process.terminate()
            process.kill()
        elif process.returncode != 0 and process.returncode is not None:
            print("abnormally end : kill process")
            finished_num += 1
            processes.remove(process)
            process.terminate()
            process.kill()
        else:
            print("still running")


# Read needed feature describe file
design_point_finished = 0
all_synthesized_ir = get_all_synthesized_ir(VL_dir, Rep_dir)
for target_ir_filename in target_IRs:
    with open(IR_dir + target_ir_filename, 'r') as ir_f:
        ir = yaml.load(ir_f)
    dse = ir["DSE"]
    classFullName = ir['module_type'].split(".")
    className = classFullName[-1]
    design_dimension, design_space, len_dse = elaborate_dse(dse)
    # Update the design point
    for design_point in design_space:
        ir = update_design_point(IR_dir + target_ir_filename, design_dimension, design_point)
        if not isSynthesized(ir, all_synthesized_ir):
            temp_filename = IR_dir + "temp_" + target_ir_filename
            with open(temp_filename, "w") as temp_f:
                yaml.dump(ir, temp_f, default_flow_style=False)
            result = subprocess.run([cgra_gen, temp_filename, VL_dir], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            stdout_str = str(result.stdout).split("\\n")
            generated_verilog_fileFullPath = stdout_str[-2].split("/")
            verilog_file = generated_verilog_fileFullPath[-1]
            while(len(processes) >= parallel):
                time.sleep(3)
                check_finished()
                print("Has run : " + str(has_run_num) + ", Finished : " + str(finished_num) + ", Total : " + str(
                    len_dse) + ", Processes List Len = " + str(len(processes)))
            else:
                change_design(DC_dir + "dc_script/", className)
                change_design_file(DC_dir + "dc_script/", verilog_file)
                process = subprocess.Popen([DC_dir + "dc_script/" + "dc_wrapper.sh"], shell=True)
                has_run_num += 1
                processes.append(process)
        else:
            finished_num += 1
            print("Has run : " + str(has_run_num) + ", Finished : " + str(finished_num) + ", Total : " + str(
                len_dse) + ", Processes List Len = " + str(len(processes)))
