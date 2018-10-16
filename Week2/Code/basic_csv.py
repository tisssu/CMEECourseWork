""" This script demonstrate the usage of csv package on how to handle cvs files,
Author Wang YuHeng (yuheng.wang18@imperial.ac.uk)"""


import csv

# Read a file containing 
# 'Species','Infraorder','Family','Distribution','Body mass male (Kg)'
f = open('../Data/testcsv.csv','r')

csvread = csv.reader(f)
temp = []
for row in csvread:
    temp.append(tuple(row))
    print(row)
    print("The species is", row[0])

f.close()

# write a file containing only species name and Body mass
f = open('../data/testcsv.csv','r')
g = open('../data/bodymass.csv','w')

csvread = csv.reader(f)
csvwrite = csv.writer(g)
for row in csvread:
    print(row)
    csvwrite.writerow([row[0], row[4]])

f.close()
g.close()
