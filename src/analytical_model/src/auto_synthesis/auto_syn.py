import subprocess
from os import listdir
from os.path import isfile, join
from subprocess import DEVNULL
import time

# Verilog File Directory
verilog_file_dir = "/home/sihao/ss-cgra-gen/verilog-output/"
verilog_files = [f for f in listdir(verilog_file_dir) if isfile(join(verilog_file_dir, f)) and f.endswith(".v")]

# Design Compiler Setup
dc_dir = "/home/sihao/ss-cgra-gen/syn/dc_script/"

# Running Setting
isAll = True

# Period
periods_to_test = [0.4,0.6,0.8,1.0,1.2,1.4,1.6]

# Parallelism
parallel = 4
design_per_list = []
processes = []
finished_num = 0
has_run_num = 0

if isAll:
    for verilog_file in verilog_files:
        design_name = verilog_file.split(".")[0]
        for per in periods_to_test:
            design_per_list.append((design_name, per))
else:
    design_per_list = [
    #("mergesortTop",0.4),
    #("mergesortTop",0.5),
    #("mergesortTop",0.6),
    #("mergesortTop",0.7),
    #("mergesortTop",0.8),
    ("fibTop",0.4),
    ("fibTop",0.5),
    ("fibTop",0.6),
    ("fibTop",0.7),
    ("fibTop",0.8),
    ("covarianceTop",0.4)
    ]

total_run_num = design_per_list.__len__()

def check_finished():
    global finished_num
    for process in processes:
        process.poll()
        n, p = design_per_list[finished_num]
        if process.returncode == 0:  # process end
            finished_num += 1
            print("Design : " + str(n) + ", Period : " + str(p) + " is finished, total finished : " + str(finished_num))
            processes.remove(process)
            process.terminate()
            process.kill()

        elif process.returncode != 0 and process.returncode is not None:
            finished_num += 1
            print("Warning : Design : " + str(n) + ", Period : " + str(p) + " end abnormally, total finished : " + str(finished_num))
            processes.remove(process)
            process.terminate()
            process.kill()


def change_design(design_n):
    common_setup = open(dc_dir + "common_setup.tcl", 'r')
    all_ori_lines = common_setup.readlines()
    common_setup.close()
    new_common_setup = open(dc_dir + "common_setup.tcl", 'w')
    for line in all_ori_lines:
        if line.startswith("set DESIGN_NAME"):
            line = "set DESIGN_NAME \"" + design_n + "\" ;#  The name of the top-level design\n"
        new_common_setup.write(line)
    new_common_setup.close()


def change_period(p):
    common_setup = open(dc_dir + "common_setup.tcl", 'r')
    all_ori_lines = common_setup.readlines()
    common_setup.close()
    new_common_setup = open(dc_dir + "common_setup.tcl", 'w')
    for line in all_ori_lines:
        if line.startswith("set Period"):
            line = "set Period " + "{:.1f}".format(p) + " ;#ns 1/Period = frequency (GHz)\n"
        new_common_setup.write(line)
    new_common_setup.close()


def change_verilog_source_dir():
    common_setup = open(dc_dir + "common_setup.tcl", 'r')
    all_ori_lines = common_setup.readlines()
    common_setup.close()
    new_common_setup = open(dc_dir + "common_setup.tcl", 'w')
    for line in all_ori_lines:
        if line.startswith("set RTL_SOURCE_DIR"):
            line = "set RTL_SOURCE_DIR \"" + verilog_file_dir + "\"\n"
        new_common_setup.write(line)
    new_common_setup.close()


change_verilog_source_dir()
while finished_num < total_run_num:
    if processes.__len__() < parallel and has_run_num < total_run_num:
        print("Having place to run new synthesizing")
        name, per = design_per_list[has_run_num]
        change_design(name)
        change_period(per)
        print("Design : " + str(name) + ", Period : " + str(per) + " run, total run : " + str(has_run_num))
        process = subprocess.Popen([dc_dir+"dc_wrapper.sh"], shell=True)
        has_run_num += 1
        processes.append(process)
    time.sleep(3)
    check_finished()
