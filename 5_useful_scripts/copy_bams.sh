#!/bin/sh

#PBS -N depth_120birds
#PBS -q fnrquail
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

cat 120_birds_original.txt | while read -r LINE

do

# copy all bam files
cp /scratch/snyder/a/abruenic/Darwins_finches/${LINE}/realigned_reads_SM.bam /scratch/snyder/a/abruenic/Darwins_finches/120_birds/${LINE}.bam

done


# END