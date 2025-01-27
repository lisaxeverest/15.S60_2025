#!/bin/bash

#Set up computing environment
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --partition=sched_any_quicktest
#SBATCH --time=0-00:10
#SBATCH -o outputlog.out

#Load software
module load julia/1.7.3

#Run the script as usual
julia shortestpath.jl