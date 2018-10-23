#!/bin/bash
# Author: Wang YuHeng
# function: calculate the time of Vectorize1.R, Vectorize2.R, Vectorize1.py, Vectorize2.py
# Argument: none

#calculate the time of Vectorize1.R
time Rscript Vectorize1.R

#calculate the time of Vectorize1.py
time python3 Vectorize1.py

#calculate the time of Vectorize2.R
time Rscript Vectorize2.R

#calculate the time of Vectorize2.py
time python3 Vectorize2.py

