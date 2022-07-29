#!/bin/bash

#SBATCH --job-name=Aaron-lz77        # Job name
#SBATCH --mail-type=ALL                    # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yu.hong@ufl.edu    # Where to send mail
#SBATCH --ntasks=1                              # Run on a single CPU
#SBATCH --mem=300gb                             # Job memory request
#SBATCH --time=48:00:00               # Time limit hrs:min:sec
#SBATCH --cpus-per-task=32            # Number of CPU cores per task

pwd; hostname; date

module load cmake
module load gcc/9.3.0

#python3 test_disk.py
./src/lz_77_test ../data/Chr_19_2504_256.fasta -t 32

date