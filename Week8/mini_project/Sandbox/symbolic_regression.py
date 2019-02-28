#!/usr/bin/python
""" This script is to load the csv file and do symbolic regression,
Author: YuHeng Wang (yuheng.wang18@imperial.ac.uk) """



import csv
import scipy as sc
import numpy as np 
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn.utils import check_random_state
import sklearn
from gplearn import genetic
import pickle


# load filw
with open("../Data/ParameciumIsolation.csv") as f:
    reader = csv.reader(f)
    grow_curve = []
    for item in reader:
        if reader.line_num == 1:
            continue
        grow_curve.append(item)

print(grow_curve)

#
