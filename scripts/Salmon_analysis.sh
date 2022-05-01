#!/bin/bash
############### SBATCH Lines For Resources Request #######################
#SBATCH --time=48:00:00			#Limit of wall clock time -how long the job will run
#SBATCH --nodes=1-10			#Number of different nodes - could be an exact number or a range of nodes
#SBATCH --ntasks=1			#Number of tasks - how many tasks (nodes) that you require
#SBATCH --cpus-per-task=10		#Number of CPUs (or cores) per task
#SBATCH --mem=20G			#Specify the real memory required per node
#SBATCH --job-name Anisotome_quant	#Give job a name for identification
##########################################################################

################################################
#
#    USER NOTE:
#    Will require Salmon 1.2.1; FastP 0.21.0, SRA-Toolkit/2.10.7-centos_linux64
#
################################################

# Load Relevant Modules from MSU HPCC (Salmon 1.2.1)
module purge
module load Salmon/1.2.1

# Index Arabidopsis transcriptome

#use MSA_in files as index without reference (Spades and trin concat) for -t, -i is name of index 
salmon index -t ../all_res/transcriptome.fasta -i Anisotome_index

echo "Quantifying transcripts to Arabidopsis transcriptome!"

# put name of index above into -i here, -l A -1 forward_read_tissue -2 reverse_Read_tissue -o tisue_quantification
#Old Root, young leaf, young root 
salmon quant -i Anisotome_index -l A -1 ../results/old_root_F_pair.fastq -2 ../results/old_root_R_pair.fastq -o Salmon_old_root_alignment
salmon quant -i Anisotome_index -l A -1 ../results/young_leaf_F_pair.fastq -2 ../results/young_leaf_R_pair.fastq -o Salmon_young_leaf_alignment
salmon quant -i Anisotome_index -l A -1 ../results/young_root_F_pair.fastq -2 ../results/young_root_R_pair.fastq -o Salmon_young_root_alignment
# 
# Merge files based on tpm and num_reads to maps with same reference metatranscriptomes
#use name of 3 outputs above as inputs for below
salmon quantmerge --quants Salmon_old_root_alignment Salmon_young_leaf_alignment Salmon_young_root_alignment -o Salmon_anisotome_quant

