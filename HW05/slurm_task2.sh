#!/usr/bin/env bash

#SBATCH -p instruction
#SBATCH -J HW5task2
#SBATCH -o HW5task2.out -e HW5task2.err
#SBATCH --mem=16G
#SBATCH --hint=nomultithread
#SBATCH --gpus-per-task=1

./task2
