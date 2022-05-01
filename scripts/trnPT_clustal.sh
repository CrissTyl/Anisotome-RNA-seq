#!/bin/bash
#SBATCH --time=02:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=20G
#SBATCH --job-name cisPT

ml icc/2018.1.163-GCC-6.4.0-2.28 impi/2018.1.163 argtable/2.13 ClustalW2/2.1

INPUT=../all_res/trnPT_MSA_in.fasta 
ALNOUTPUT=/mnt/scratch/crisstyl/anisoscript/all_res/trnPT_MSA.fasta

clustalw2 -align -infile=$INPUT -type=pep -output=fasta -outfile=$ALNOUTPUT
