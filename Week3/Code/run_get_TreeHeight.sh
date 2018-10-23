#!/bin/bash
# Author: Wang YuHeng yuheng.wang18@imperial.ac.uk
# Script: run_get_TreeHeight.sh
# Desc:test the get_TreeHeight.R script in unix
# Argument: none
# Date: Oct 2018 

#run the script of R
Rscript get_TreeHeight.R ../Data/trees.csv


# run the script of python
python3 get_TreeHeight.py ../Data/trees.csv