#!/bin/sh

#PBS -N sfs
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=20,naccesspolicy=shared
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


cd $LINE

# estimate SFS
angsd -bam bam.filelist -doSaf 1 -anc ref.fa -GL 1 -P 20 -out out \
-minMapQ 20 -minQ 20

# obtain ML estimate of SFS using the realSFS
realSFS out.saf.idx -P 20 > out.sfs



#END
