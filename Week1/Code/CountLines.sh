#!/bin/bash
# Author: Wang YuHeng yuheng.wang18@imperial.ac.uk
# Script: CountLines
# Desc: count the number of lines in a file
# Argument: 1->line counted file
# Date: Oct 2018 
NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
echo