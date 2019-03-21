#!/bin/sh

#PBS -N scaffold
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=4:00:00
#PBS -m abe

module purge
module load bioinfo
module load vcftools

cd $PBS_O_WORKDIR

cat populations.txt | while read -r LINE

do

vcftools --vcf ${LINE}_8x.vcf --thin 5000 --recode --max-missing-count 0 \
--chr NW_005054297.1 --out ${LINE}_thin

done

# END
