#!/bin/bash
# Author Wang YuHeng yuheng.wang18@imperial.ac.uk
# Script: csvtospace.sh
# Desc: substitude the commas in the file with space
# saves the output into a .txt file
# Arguments: 1-> comma delimited file
# Date: Oct 2018

echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "," " " >> $1.txt
echo "Done!"
exit