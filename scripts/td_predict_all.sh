#!/bin/bash --login
########## SBATCH Lines for Resource Request ##########

#SBATCH --time=48:00:00             # limit of wall clock time - how long the job will run (same as -t)
#SBATCH --nodes=1-5                 # number of different nodes - could be an exact number or a range of nodes (same as -N)
#SBATCH --ntasks=1                  # number of tasks - how many tasks (nodes) that you require (same as -n)
#SBATCH --cpus-per-task=10           # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem=100G            # memory required per allocated CPU (or core) - amount of memory (in bytes)
#SBATCH --job-name td_predict      # you can give your job a name for easier identification (same as -J)

########## Command Lines for Job Running ##########
  ### load necessary modules.
module purge
ml icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 TransDecoder/2.1.0-Perl-5.24.1

### change to the directory where your code is located.
#cd /mnt/scratch/crisstyl/anisoscript/src
cd /mnt/scratch/crisstyl/anisoscript/all_res
 ### call your executable. (use srun instead of mpirun

TransDecoder.Predict -t /mnt/scratch/crisstyl/anisoscript/all_res/transcriptome.fasta


#scontrol show job $SLURM_JOB_ID     ### write job information to SLURM output file.
#js -j $SLURM_JOB_ID                 ### write resource usage to SLURM output file (powertools command).
