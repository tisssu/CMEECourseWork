#!/bin/bash
# Author Wang YuHeng yuheng.wang18@imperial.ac.uk
# Script: tiff2png
# Desc: substitude the tiff file in the png file
# Arguments: f-> tiff file
# Date: Oct 2018

for f in *.tif;
    do 
        echo "Converting $f";
        convert "$f" "$(basename "$f" .tif).png";
    done
    