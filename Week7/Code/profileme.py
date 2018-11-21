#!/user/bin/env python3
""" This script is to profile the code,
Author: YuHeng Wang (yuheng.wang18@imperial.ac.uk) """

def my_squares(iters):
    """ output i^2 in iteration """
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """ join the input string """
    out = ""
    for i in range(iters):
        out += string.join(",")
    return out 

def run_my_funcs(x,y):
    """ print results of function before """
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0


run_my_funcs(10000000,"My string")

