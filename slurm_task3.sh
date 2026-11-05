#!/usr/bin/env bash

#SBATCH -p instruction
#SBATCH -J HW5task3
#SBATCH -o HW5task3.out -e HW5task3.err
#SBATCH --mem=16G
#SBATCH --hint=nomultithread
#SBATCH --gpus-per-task=1

for i in {10..29}; do
	./task3 $(2**i);
done
