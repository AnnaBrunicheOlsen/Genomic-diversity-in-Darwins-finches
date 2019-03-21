#!/bin/sh

#PBS -N make_dir
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

cat sample_sra_fastq.txt | while read -r LINE

do

# this defines sample and SRA
sra=$(echo "$LINE" | cut -d$'\t' -f2)
echo $sra

mkdir $sra

done

# END

