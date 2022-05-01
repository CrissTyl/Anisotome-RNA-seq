#!/bin/bash --login
########## SBATCH Lines for Resource Request ##########

#SBATCH --time=04:00:00             # limit of wall clock time - how long the job will run (same as -t)
#SBATCH --nodes=1-5                 # number of different nodes - could be an exact number or a range of nodes (same as -N)
#SBATCH --ntasks=5                  # number of tasks - how many tasks (nodes) that you require (same as -n)
#SBATCH --cpus-per-task=8           # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem-per-cpu=32G            # memory required per allocated CPU (or core) - amount of memory (in bytes)
#SBATCH --job-name A_lyallii_young_leaf_FR      # you can give your job a name for easier identification (same as -J)

########## Command Lines for Job Running ##########

module load FastQC/0.11.5-Java-1.8.0_162  ### load necessary modules.

cd /mnt/scratch/crisstyl/anisoscript/src               ### change to the directory where your code is located.

srun fastqc /mnt/scratch/crisstyl/anisoscript/data/A_lyallii_young_root_F.fastq -o /mnt/scratch/crisstyl/anisoscript/results -f fastq
srun fastqc /mnt/scratch/crisstyl/anisoscript/data/A_lyallii_young_root_R.fastq -o /mnt/scratch/crisstyl/anisoscript/results -f fastq
 ### call your executable. (use srun instead of mpirun.)

scontrol show job $SLURM_JOB_ID     ### write job information to SLURM output file.
js -j $SLURM_JOB_ID                 ### write resource usage to SLURM output file (powertools command).
