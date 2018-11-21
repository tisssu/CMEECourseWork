""" This script is to run frm.R and put the output on python idea,
Aurhor: Wang YuHeng (yuheng.wang18@imperial.ac.uk) """

import subprocess
p = subprocess.Popen(["Rscript", "fmr.R"],stdout = subprocess.PIPE,stderr= subprocess.PIPE)
stdout, stderr = p.communicate()
print(stdout.decode())
