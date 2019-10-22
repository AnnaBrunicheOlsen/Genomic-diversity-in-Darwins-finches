#!/bin/sh

#PBS -N angsd
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=20,naccesspolicy=singleuser
#PBS -l walltime=300:00:00
#PBS -m abe

module load bioinfo
module load gsl
module load zlib
module load gcc
module load samtools

cd $PBS_O_WORKDIR

export PATH=/home/abruenic/angsd/:$PATH
export PATH=/home/abruenic/angsd/misc/:$PATH

angsd -GL 1 -minMapQ 20 -minQ 20 -out data -nThreads 20 -doGlf 2 -doMajorMinor 1 \
-minInd 50 -setMaxDepth -skipTriallelic 1 -doMaf 2 -SNP_pval 1e-6 \
-bam bam.filelist

# remove triallelic
# set either minInd ELLER setMinDepth
# minimum dybde =71*5*1/2
# maximum dybde = 71*5*2


#END
