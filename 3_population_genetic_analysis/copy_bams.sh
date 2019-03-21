#!/bin/sh

#PBS -N copy_bams
#PBS -q fnrquail
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

cat populations.txt | while read -r LINE

do

cd $LINE

cp *.bam /scratch/snyder/a/abruenic/Darwins_finches/all_birds/

cd ..

done

#END