#!/user/bin/env python3
"""Some functions exemplifying the use of mathematical operations,
Author Wang YuHeng (yuheng.wang18@imperial.ac.uk) """


__author__ ='Wang YuHeng (yuheng.wang18@imperial.ac.uk)'
__version__ ='0.0.1'

import sys

"""square x"""
def foo_1(x):
    return x ** 0.5 

"""find the larger one in x,y"""
def foo_2(x, y):
    if x > y:
        return x
    return y

"""making the number inpute a increasing sequence"""
def foo_3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

"""calculating the factorial of x"""
def foo_4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

"""calculating the factorial of x recursively"""
def foo_5(x): # a recursive function
    if x == 1:
        return 1
    return x * foo_5(x - 1)

"""Calculate the factorial of x in a different way"""
def foo_6(x): # Calculate the factorial of x in a different way
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto




def main(argv):
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

