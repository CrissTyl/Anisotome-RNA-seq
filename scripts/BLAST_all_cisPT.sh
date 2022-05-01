#!/bin/bash
#SBATCH --time=04:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=12G
#SBATCH --job-name BLAST_CisPT

###SEE BELOW FOR DESCRIPTIONS OF EACH VARIABLE

THREADS=12

module load BLAST

###define stuff for database
DB_PROGRAM=makeblastdb
DB_INPUT=/mnt/scratch/crisstyl/anisoscript/BLAST/cisPT_RefSet.fasta
DB_TYPE=prot ###nucl or prot
DB_OUTPUT=./db/database

###define stuff for BLAST search
BLAST_TYPE=blastp ###~/bin/myblast/bin/blastn or "/blastp
OUTFMT=6
BLAST_QUERY=/mnt/scratch/crisstyl/anisoscript/all_res/transcriptome.fasta.transdecoder.pep
E_VALUE=1e-10
BLAST_OUTPUT=/mnt/scratch/crisstyl/anisoscript/all_res/blast_all_cisPT_out

###make database
$DB_PROGRAM -in $DB_INPUT -dbtype $DB_TYPE -out $DB_OUTPUT

###search against database
$BLAST_TYPE -db $DB_OUTPUT -query $BLAST_QUERY -outfmt $OUTFMT -evalue $E_VALUE -word_size 4 -out $BLAST_OUTPUT -num_threads $THREADS

###show job
scontrol show job $SLURM_JOB_ID


###THREADS is how many cpus you're using. Make sure this matches what you have above for cpus-per-task

###DB_PROGRAM is the path to BLAST's database-making program. Don't change this unless the path moves
###DB_INPUT is the fasta file that you want to search against (typically your reference sequences)
###DB_TYPE is either nucl or prot depending on what type of sequences you're searching
###DB_OUTPUT is the name of the directory (db) and the files within (database.***). Don't change this unless you hate my names :( or need to have different databases in the same directory (you usually don't)

###BLAST_TYPE is the path to the actual program. The last term will be blastp (amino acid), blastn (nucleotide), or blastx (one file is amino acid and the other is nucleotide)
###OUTFMT is a pre-defined output format. You can google what each column is because the actual output doesn't have column headers
###BLAST_QUERY is the fasta file you want to search against your database (e.g. an assembled transcriptome)
###E-VALUE is how strict you want the program to be when writing any given match to the output file. You can always set this low (~5-10) and then filter low probability hits out of your output later. Something like 1E-100 is pretty strict and will only give you high ID matches over a long alignment
###BLAST_OUTPUT is whatever you want your output file to be called
