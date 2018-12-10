#!/bin/bash
# Author: Wang YuHeng yuheng.wang18@imperial.ac.uk
# Script: ignore
# Desc: ignore file larger than 35mb in results
# Argument: none
# Date: Dec 2018 

find ../Results . -size +35M | cat >> .gitignore