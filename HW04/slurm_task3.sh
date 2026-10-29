#!/usr/bin/env bash

#SBATCH -p instruction
#SBATCH -c 8
#SBATCH -J HW4task3
#SBATCH -o HW4task3.out -e HW4task3.err
#SBATCH --mem=16G
#SBATCH --hint=nomultithread

for i in {1..8} do
	./task3 100 100 $((i));
done

