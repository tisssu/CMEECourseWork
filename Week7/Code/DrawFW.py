#!/usr/bin/env python3

""" This script is to build a food web and plot it,
Author: Wang YuHeng (yuheng.wang18@imperial.ac.uk)  """

import networkx as nx
import scipy as sc
import matplotlib.pyplot as p

def GenRdmAdjList(N = 2, C = 0.5):
    """ function of build food web link in dataset 
    """
    Ids = range(N)
    ALst = []
    for i in Ids:
        if sc.random.uniform(0,1,1) < C:
            Lnk = sc.random.choice(Ids,2).tolist()
            if Lnk[0] != Lnk[1]: #avoid self (e.g., cannibalistic) loops
                ALst.append(Lnk)
    return ALst

MaxN = 30
C = 0.75 
AdjL = sc.array(GenRdmAdjList(MaxN, C))
AdjL

Sps = sc.unique(AdjL)

SizRan = ([-10,10])
Sizes = sc.random.uniform(SizRan[0],SizRan[1],MaxN)
Sizes

p.hist(Sizes)

p.hist(10 ** Sizes)

p.close("all")


f3 = p.figure()
pos = nx.circular_layout(Sps)
G = nx.Graph()
G.add_nodes_from(Sps)
G.add_edges_from(tuple(AdjL))
NodSizes = 150 * (Sizes - min(Sizes)/(max(Sizes)-min(Sizes)))

nx.draw_networkx(G, pos, node_size = NodSizes)
f3.savefig("../Results/Networks.pdf")