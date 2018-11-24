#!/user/bin/env python3
"""Some functions exemplifying the use of mathematical operations,
Author Wang YuHeng (yuheng.wang18@imperial.ac.uk) """


__author__ ='Wang YuHeng (yuheng.wang18@imperial.ac.uk)'
__version__ ='0.0.1'

import sys

def foo_1(x):
    """square x"""
    return x ** 0.5 


def foo_2(x, y):
    """find the larger one in x,y"""
    if x > y:
        return x
    return y

def foo_3(x, y, z):
    """making the number inpute a increasing sequence"""
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo_4(x):
    """calculating the factorial of x"""
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo_5(x): # a recursive function
    """calculating the factorial of x recursively"""
    if x == 1:
        return 1
    return x * foo_5(x - 1)

def foo_6(x): # Calculate the factorial of x in a different way
    """Calculate the factorial of x in a different way"""
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto




def main(argv):
    """ run all the function """
    print(foo_1(4))
    print(foo_1(3))
    print(foo_2(5,3))
    print(foo_3(1, 2, 4))
    print(foo_4(4))
    print(foo_4(5))
    print(foo_5(4))
    print(foo_5(5))
    print(foo_6(4))
    print(foo_6(5))
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)

