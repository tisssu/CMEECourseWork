#!/user/bin/env python3
""" This script is to make the python version of vectorize.R,
Author Wang YuHeng (yuheng.wang18@imperial.ac.uk) """
# using for loop
import numpy
import time
M = numpy.random.uniform(0,1,size=[1000,1000])
def SumALLElements(M):
    """ test vectorization """
    ToT =0
    for i in range(0,M.shape[0]):
        for j in range(0,M.shape[1]):
            ToT=ToT+M[i,j]
    return ToT

#using vectorizing
numpy.sum(M)