""" This script is to make python version of vectorize2.R,
Author Wang YuHeng (yuheng.wang18@imperial.ac.uk)"""

import math
import numpy
def stochrick(p0 = numpy.random.uniform(0.5,1.5,size=1000),r=1.2,K=1,sigma=0.2,numyears=100):
    N = numpy.empty((numyears,len(p0)))
    N[1,] = p0
    for pop in range(1,len(p0)):
        for yr in range(2,numyears):
            N[yr,pop] = N[yr-1,pop]*math.exp(r*(1-N[yr-1,pop]/K)+numpy.random.normal(0,sigma,1))
    return(N)

#vectorize
import math
import numpy
def stochrickvect(p0 = numpy.random.uniform(0.5,1.5,size=1000),r=1.2,K=1,sigma=0.2,numyears=100):
    N = numpy.empty((numyears,len(p0)))
    N[1,] = p0
    for yr in range(2,numyears):
        N[yr,] = N[yr-1,]*numpy.exp(r*(1-N[yr-1,]/K)+numpy.random.normal(0,sigma,1))
    return(N)

res2 = stochrickvect()