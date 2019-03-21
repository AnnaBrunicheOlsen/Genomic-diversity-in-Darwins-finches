#!/bin/sh

#PBS -N Fst
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=20
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

# see http://evomics.org/learning/population-and-speciation-genomics/2018-population-and-speciation-genomics/angsd-activity-sfs-fst-pbs/

# cp reference to dir
#cp /scratch/snyder/a/abruenic/Darwins_finches/ref.* .

# generate 2D SFS
#realSFS $SAN $SCZ > Geo.Ful.ml
realSFS \
/scratch/snyder/a/abruenic/Darwins_finches/Geospiza_magnirostris_daphne/out.saf.idx \
/scratch/snyder/a/abruenic/Darwins_finches/Geospiza_magnirostris_Genovesa/out.saf.idx \
> pop.ml

#first we will index the sample so that the same sites are analysed for each population
#realSFS fst index $SAN $SCZ -sfs Geo.Ful.ml -fstout Geo.ful
realSFS fst index \
/scratch/snyder/a/abruenic/Darwins_finches/Geospiza_magnirostris_daphne/out.saf.idx \
/scratch/snyder/a/abruenic/Darwins_finches/Geospiza_magnirostris_Genovesa/out.saf.idx \
-sfs pop.ml -fstout pop

#get the global estimate
realSFS fst stats pop.fst.idx

# END
