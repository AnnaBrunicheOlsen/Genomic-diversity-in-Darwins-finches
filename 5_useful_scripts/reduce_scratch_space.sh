#!/bin/sh

#PBS -N reduce_scratch
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=4:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

cat sra_322_birds.txt | while read -r LINE

do

cd $LINE

# remove excess files
rm -v !("realigned_reads.bam"|"${LINE}.g.vcf") 

rm -rf tmp
rm -rf ${LINE}_1_fastqc
rm -rf ${LINE}_2_fastqc

cd ..

done

# END
