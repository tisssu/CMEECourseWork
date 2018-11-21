#!/user/bin/env python3

""" This script profile the function which was optimized,
Author : YuHeng Wang (yuheng.wang18.imperial.ac.uk) """



def my_squares(iters):
    """ calculate i^2 """
    out = [i ** 2 for i in range(iters)]
    return out 

def my_join(iters, string):
    """ join the input string """
    out =  ""
    for i in range(iters):
        out += "," + string 
    return out 

def run_my_funcs(x,y):
    """ run function my_squares and my_join """
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0 

run_my_funcs(10000000, "My string")

