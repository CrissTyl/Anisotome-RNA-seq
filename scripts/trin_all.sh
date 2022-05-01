#!/bin/bash --login
########## SBATCH Lines for Resource Request ##########

#SBATCH --time=72:00:00             # limit of wall clock time - how long the job will run (same as -t)
#SBATCH --nodes=1-5                 # number of different nodes - could be an exact number or a range of nodes (same as -N)
#SBATCH --ntasks=1                  # number of tasks - how many tasks (nodes) that you require (same as -n)
#SBATCH --cpus-per-task=20           # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem=300G            # memory required per allocated CPU (or core) - amount of memory (in bytes)
#SBATCH --job-name alL_trin      # you can give your job a name for easier identification (same as -J)

########## Command Lines for Job Running ##########
  ### load necessary modules.
module purge
ml GCC/7.3.0-2.30 OpenMPI/3.1.1 Trinity/2.8.5 SAMtools/1.9 Python/3.7.0

### change to the directory where your code is located.
#cd /mnt/scratch/crisstyl/anisoscript/src
cd /mnt/scratch/crisstyl/anisoscript/all_res/
 ### call your executable. (use srun instead of mpirun.)
Trinity \
   --seqType fq \
   --max_memory 300G \
   --left all_F.fastq \
   --right all_R.fastq \
   --SS_lib_type RF \
   --CPU 20 \
   --full_cleanup

#scontrol show job $SLURM_JOB_ID     ### write job information to SLURM output file.
#js -j $SLURM_JOB_ID                 ### write resource usage to SLURM output file (powertools command).
