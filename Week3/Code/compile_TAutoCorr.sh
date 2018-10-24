#!/bin/bash
pdflatex TAutoCorr.tex
pdflatex TAutoCorr.tex

evince TAutoCorr.pdf &

## Cleanup
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc