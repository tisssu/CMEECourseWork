#!/bin/bash
# Author: Wang YuHeng yuheng.wang18@imperial.ac.uk
# Script: run_MiniProject.sh
# Desc: run the whole workflow
# Date: Feb 2019 

python symbolic_regression.py

Rscript data_analysis.R

bash tex_count.sh

bash Compilelatex.sh main

