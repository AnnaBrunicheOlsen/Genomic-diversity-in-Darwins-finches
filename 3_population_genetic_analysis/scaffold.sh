#!/bin/sh

#PBS -N scaffold
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=4:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

cat missing.txt | while read -r LINE

do

grep "NW_005054297.1" ${LINE}_8x.vcf > ${LINE}.vcf
grep "CHROM" ${LINE}_8x.vcf > header
cat header ${LINE}.vcf > ${LINE}_scaf.vcf 

rm -rf ${LINE}.vcf
rm -rf header

done

# END
