#!/usr/bin/env bash

#SBATCH -p instruction
#SBATCH -c 8
#SBATCH -J HW4task2
#SBATCH -o HW4task2.out -e HW4task2.err
#SBATCH --mem=16G
#SBATCH --hint=nomultithread

./task2 100 10
