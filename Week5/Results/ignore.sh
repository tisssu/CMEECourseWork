#!/bin/bash
# Author: Wang YuHeng yuheng.wang18@imperial.ac.uk
# Script: ignore
# Desc: ignore files larger than 35mb
# Argument: none
# Date: Oct 2018 

find . -size +35M | cat >> .gitignore