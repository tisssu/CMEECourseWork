#!/usr/bin/env python3

""" This script is to run LV1.py, LV2.py
AUthor: Wang YuHeng (yuheng.wang18@imperial.ac.uk) """

import time
import subprocess

start = time.time()
subprocess.os.system("python3 LV1.py")
print("LV1.py takes %f s to run" % (time.time() - start))

start = time.time()
subprocess.os.system("python3 LV2.py 1.0 0.1 1.5 0.75 80")
print("LV2.py takes %f s to run" % (time.time() - start))