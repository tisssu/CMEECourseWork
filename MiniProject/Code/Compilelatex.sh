#!/bin/bash
# Author: Wang YuHeng yuheng.wang18@imperial.ac.uk
# Script: CompileLaTeX
# Desc: compile the latex file
# Argument: 1->compiled file
# Date: Feb 2019 

pdflatex $1.tex
pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex
evince $1.pdf &

## Cleanup
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc
rm *.bbl
rm *.blg