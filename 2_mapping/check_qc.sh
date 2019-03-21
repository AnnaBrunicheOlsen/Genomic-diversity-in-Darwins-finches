#!/bin/sh

#PBS -N BWA_mem
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=19,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load bwa

cd $PBS_O_WORKDIR

cat sample_sra.txt | while read -r LINE

do

# this defines sample and SRA
sample=$(echo "$LINE" | cut -d$'\t' -f1)
echo $sample

# go to sample dir and download the associated SRA
cd $sample

qc=$(grep 'FAIL' qc_log.txt)

echo $qc

cd ..

done

# END

