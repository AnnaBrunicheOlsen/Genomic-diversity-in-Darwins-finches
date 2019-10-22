#!/bin/sh

#PBS -N depth_60birds
#PBS -q fnrgenetics
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load gsl
module load zlib
module load gcc
module load samtools

cd $PBS_O_WORKDIR

export PATH=/home/abruenic/angsd/:$PATH
export PATH=/home/abruenic/angsd/misc/:$PATH

# find depth for all sites
angsd -bam 60_birds.bamlist -doDepth 1 -out all -doCounts 1

# find depth for files fulfilling our filtering criteria
angsd -bam 60_birds.bamlist -doDepth 1 -out strict -doCounts 1 -minMapQ 20 -minQ 20

# END