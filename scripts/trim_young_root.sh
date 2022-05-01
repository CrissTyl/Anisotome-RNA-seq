#!/bin/bash --login
########## SBATCH Lines for Resource Request ##########

#SBATCH --time=04:00:00             # limit of wall clock time - how long the job will run (same as -t)
#SBATCH --nodes=1-5                 # number of different nodes - could be an exact number or a range of nodes (same as -N)
#SBATCH --ntasks=5                  # number of tasks - how many tasks (nodes) that you require (same as -n)
#SBATCH --cpus-per-task=8           # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem-per-cpu=12G            # memory required per allocated CPU (or core) - amount of memory (in bytes)
#SBATCH --job-name A_lyallii_young_root      # you can give your job a name for easier identification (same as -J)

########## Command Lines for Job Running ##########
module load Trimmomatic/0.36-Java-1.8.0_92
  ### load necessary modules.

cd /mnt/scratch/crisstyl/anisoscript/src               ### change to the directory where your code is located.

THREAD=12
FORWARD=../data/A_lyallii_young_root_F.fastq
REVERSE=../data/A_lyallii_young_root_R.fastq

java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.36.jar PE -threads 12 -phred33 $FORWARD $REVERSE \
../results/young_root_F_pair.fastq ../results/young_root_F_unpair.fastq ../results/young_root_R_pair.fastq ../results/young_root_R_unpair.fastq \
ILLUMINACLIP:/opt/software/Trimmomatic/0.36-Java-1.8.0_92/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 \
SLIDINGWINDOW:4:15 \
MINLEN:35 \
#CROP:75 \

 ### call your executable. (use srun instead of mpirun.)

scontrol show job $SLURM_JOB_ID     ### write job information to SLURM output file.
js -j $SLURM_JOB_ID                 ### write resource usage to SLURM output file (powertools command).
