
''' This script is to test the pdb and ipdb function by adding bug in script deliberately,
Author: Wang YuHeng (yuheng.wang18@imperial.ac.uk) '''


def createabug(x):
    """ debug """
    y = x**4
    # creat a bug
    z = 0.
    import ipdb; ipdb.set_trace()
    y = y/z
    return y

createabug(25)