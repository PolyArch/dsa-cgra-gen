from os import listdir
from os.path import isfile, join
import subprocess
import time


target_dir = "/home/sihao/ss-stack/ss-cgra-gen/syn/rtl_source/isca_2020/vport"
dc_script_dir = "/home/sihao/ss-stack/ss-cgra-gen/syn/dc_script/"

# Multi-thread parameter
parallel = 4
processes = []
finished_num = 0
has_run_num = 0

def change_design_file(design_file):
    common_setup = open(dc_script_dir + "common_setup.tcl", 'r')
    all_ori_lines = common_setup.readlines()
    common_setup.close()
    new_common_setup = open(dc_script_dir + "common_setup.tcl", 'w')
    for line in all_ori_lines:
        if line.startswith("set DESIGN_FILE_NAME"):
            line = "set DESIGN_FILE_NAME \"" + design_file + "\"\n"
        if line.startswith("set RTL_SOURCE_FILES"):
            line = "set RTL_SOURCE_FILES \"" + design_file + "\"\n"
        new_common_setup.write(line)
    new_common_setup.close()


def check_finished():
    global finished_num
    for process, rtl_file in processes:
        process.poll()
        if process.returncode == 0:  # process end
            print(rtl_file + " normally end")
            finished_num += 1
            processes.remove((process, rtl_file))
            process.terminate()
            process.kill()
        elif process.returncode != 0 and process.returncode is not None:
            print(rtl_file + " abnormally end : kill process")
            finished_num += 1
            processes.remove((process, rtl_file))
            process.terminate()
            process.kill()
        else:
            print(rtl_file + " still running")

def find_all_files(dir):
    return [f for f in listdir(dir) if isfile(join(dir, f))]

all_rtl_src_name = find_all_files(target_dir)

for rtl_file in all_rtl_src_name:
    while (len(processes) >= parallel):
        time.sleep(3)
        check_finished()
        print("Has run : " + str(has_run_num) + ", Finished : " + str(finished_num) + ", Total : " + str(
            len(all_rtl_src_name)) + ", Processes List Len = " + str(len(processes)))
    else:
        change_design_file(rtl_file)
        process = subprocess.Popen([dc_script_dir + "dc_wrapper.sh"], shell=True)
        time.sleep(5)
        has_run_num += 1
        processes.append((process, rtl_file))


while(finished_num < len(all_rtl_src_name)):
    time.sleep(3)
    check_finished()
