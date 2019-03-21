#!/bin/sh

#PBS -N Geospiza_difficilis_DW9
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=4:00:00
#PBS -m abe

module purge
module load bioinfo
module load samtools

cd $PBS_O_WORKDIR

samtools merge out.bam \
/scratch/snyder/a/abruenic/Darwins_finches/SRR1607456/realigned_reads.bam \
/scratch/snyder/a/abruenic/Darwins_finches/SRR1607457/realigned_reads.bam

# END