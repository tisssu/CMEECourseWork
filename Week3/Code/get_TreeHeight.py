#!/user/bin/env python3

""" This scdript is to get external file, calculating the tree height and output it into external file,
Author Wang YuHeng (yuheng.wang18@imperial.ac.uk) """

# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

import math
import sys
import csv
import os.path
import os

# define the function to calculating the tree height
def TreeHeight(degrees, distance):
    """ calculate tree height """
    radians = degrees * math.pi / 180
    height = distance * math.tan(radians)
    print("Tree height is:", height)
    return height

# get the system argument
args = sys.argv[1:]

# read the csv table
MyData = []
with open(args[0],"r") as f:
    readcsv = csv.reader(f)
    for line in readcsv:
        MyData.append(line)

# calculate the height
MyData[0].append("Tree.Height.m")
for i in range(1,len(MyData)):
    MyData[i].append(TreeHeight(float(MyData[i][2]),float(MyData[i][1])))

with open("../Results/"+os.path.splitext(os.path.basename(args[0]))[0]+"_treeheights_py.csv","w") as g:
    csvwrite = csv.writer(g)
    for line in MyData:
        csvwrite.writerow(line)

