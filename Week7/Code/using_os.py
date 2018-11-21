#!/usr/bin/env python3

""" This is to find Dir for files in home directory using subprocess and regex,
Author Wang YuHeng (yuheng.wang18@imperial.ac.uk)   """

# Use the subprocess.os module to get a list of files and  directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

import subprocess
import re

#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for string in subdir + files:
        FilesDirsStartingWithC +=  re.findall(r'C.*',string)
  
print(FilesDirsStartingWithC)
#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:
FilesDirsStartingWithC_c = []

for (dir, subdir, files) in subprocess.os.walk(home):
    for string in subdir + files:
        FilesDirsStartingWithC_c +=  re.findall(r'[Cc].*',string)
print(FilesDirsStartingWithC_c)


#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:

DirsStartingWithC_c = []

for (dir, subdir, files) in subprocess.os.walk(home):
    for string in subdir:
        DirsStartingWithC_c +=  re.findall(r'[Cc].*',string)
print(DirsStartingWithC_c)