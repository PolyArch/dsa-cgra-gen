#!/usr/local/bin/python3

import sys
sys.path.insert(0, '/home/sihao/ss-cgra-gen/src/analytical_model/src/result_parser')
from collect_statistic import get_statistic

# Get Statistic
db = get_statistic()

print("Model Built!")
