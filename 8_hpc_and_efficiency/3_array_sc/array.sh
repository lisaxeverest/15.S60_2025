#!/bin/bash

#SBATCH -o array.sh.log-%a
#SBATCH -a 1-3

#Load software
module load julia/1.7.3

julia shortestpath_many.jl  $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT