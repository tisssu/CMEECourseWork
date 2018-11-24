""" This script demonstrate the use of global variable and local variable,
Author Wang YuHeng (yuheng.wang18@imperial.ac.uk)"""


## Try this first

_a_global = 10

def a_function():
    """ test local and global variable """
    _a_global = 5
    _a_local = 4
    print("Inside the function, the value is ", _a_global)
    print("Inside the function, the value is ", _a_local)
    return None

a_function()

print("Outside the function, the value is ", _a_global)


## Now try this

_a_global = 10

def a_function():
    """ test local and global variable """
    global _a_global
    _a_global = 5
    _a_local = 4
    print("Inside the function, the value is ", _a_global)
    print("Inside the function, the value is ", _a_local)
    return None

a_function()
print("Outside the function, the value is", _a_global)