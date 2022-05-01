#!/bin/bash
#SBATCH --time=08:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=200G
#SBATCH --partition=batch
#SBATCH --job-name trnPT_Phylogeny

#THIS PROGRAM WILL NOT WORK ON AN INTEL 14 NODE, DO SSH "ANY OTHER NODE"

ml -* icc/2019.1.144-GCC-8.2.0-2.31.1  impi/2018.4.274 RAxML/8.2.12-hybrid-avx2

ALNOUTPUT=/mnt/scratch/crisstyl/anisoscript/all_res/trnPT_MSA.fasta
NUMBER=12345
THREADS=16
MODEL=PROTGAMMAAUTO
ALGORITHM=a
BOOTSTRAPS=100
OUTPUT=trnPT_phylogeny
#OUTGROUP=PpCPS/KS

raxmlHPC -p 24 -s $ALNOUTPUT -x $NUMBER -T $THREADS -m $MODEL -f $ALGORITHM -N $BOOTSTRAPS -n $OUTPUT

###show job
#scontrol show job $SLURM_JOB_ID
