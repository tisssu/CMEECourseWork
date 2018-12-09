#!/usr/bin/env python3

""" This script is to convert Nets.R into python,
Author: Wang YuHeng (yuheng.wang18@imperial.ac.uk)  """

import networkx as nx
import scipy as sc
import matplotlib.pyplot as p
import csv

links = []
with open("../Data/QMEE_Net_Mat_edges.csv") as f:
    next(f)
    csvread = csv.reader(f)
    for  line in csvread:
        links += line

links = sc.array(links)
links = links.reshape(6,6)
links = links.astype(sc.int32)

name =["ICL","UoR","CEH","ZSL","CEFAS","NonAc"]
ins_link = []
for i in range(6):
    for j in range(6):
        if links[i,j] != 0 :
            ins_link.append((name[i],name[j],links[i,j]))
            

nodes = []
with open("../Data/QMEE_Net_Mat_nodes.csv") as f:
    next(f)
    csvread = csv.reader(f)
    for  line in csvread:
        nodes += line

nodes = sc.array(nodes)
nodes = nodes.reshape(6,3)
size = nodes[:,2]
size = size.astype(sc.int32)
size = size * 50

color = ["r","r","g","g","g","b"]
color = sc.array(color)



f4 = p.figure()
G = nx.DiGraph()
names = sc.array(name)
G.add_nodes_from(names)
G.add_weighted_edges_from(ins_link)
nx.draw_networkx(G,node_size = size,node_color = color,edge_color = "grey")
f4.savefig("../Results/QMEE_py.svg")