#!/usr/bin/env bash

#SBATCH -p instruction
#SBATCH -J HW5task1
#SBATCH -o HW5task1.out -e HW5task1.err
#SBATCH --mem=16G
#SBATCH --hint=nomultithread
#SBATCH --gpus-per-task=1

./task1
