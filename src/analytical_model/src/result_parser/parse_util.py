from os import listdir
from os.path import isfile, join, isdir


def find_all_dirs(dir):
    return [f for f in listdir(dir) if isdir(join(dir, f))]


def find_all_files(dir):
    return [f for f in listdir(dir) if isfile(join(dir, f))]
