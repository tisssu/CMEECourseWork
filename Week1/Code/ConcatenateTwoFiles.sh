#!/bin/bash
# Author: Wang YuHeng yuheng.wang18@imperial.ac.uk
# Script: ConcatenateTwoFiles
# Desc: change the third file with first one, the add second file to it
# Argument: 1-> file used to switch the third file; 2-> file added in the third file; 3-> file been changed by first file
# Date: Oct 2018
cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3