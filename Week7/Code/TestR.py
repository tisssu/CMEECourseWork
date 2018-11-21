#!/usr/bin/env python3

""" This script is to test run R in python,
Author: Wang YuHeng (yuheng.wang18@imperial.ac.uk) """

import subprocess
subprocess.Popen("/usr/local/bin/Rscript --verbose TestR.R > \
../Results/TestR.Rout 2> ../Results/TestR_errFile.Rout",\
 shell=True).wait()

