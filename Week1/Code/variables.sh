#!/bin/bash
# Author: Wang YuHeng yuheng.wang18@imperial.ac.uk
# Script: variable
# Desc: Shows the use of variables
# Argument: MyVar-> string inputed; a,b-> number inputed; mysun-> number of adding result
# Date: Oct 2018 
MyVar= "some string"
echo "the current value of the variable is" $MyVar
echo "Please enter a new string"
read MyVar
echo "the current value of the variable is" $MyVar
## Reading multiple values
echo "Enter two numbers seperate by space(s)"
read a b 
echo "you enter" $a "and" $b ". Their sum is:"
mysum=`expr $a + $b`
echo $mysum