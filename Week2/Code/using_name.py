
#!/usr/bin/env python3
# Filename: using_name.py

""" This script is to explain the function of __name__ =  '__main__'
Author Wang YuHeng (yuheng.wang18@imperial.ac.uk)  """

if __name__ == '__main__':
    print('This program is being run by itself')
else:
    print('I am being imported from another module')