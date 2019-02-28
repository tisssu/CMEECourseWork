#!/bin/bash
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run"
R --vanilla < $HOME/HPC_dir/HPC_practice.R
mv HPC_results* $HOME/HPC_dir/Results
echo "R has finished running"
