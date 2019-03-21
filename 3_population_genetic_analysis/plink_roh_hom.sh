#!/bin/sh

#PBS -N hom_ROH
#PBS -q fnrquail
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

cat sample.txt | while read -r LINE

do

cd $LINE

# write results to file
cat ${LINE}_4x.hom >> /scratch/snyder/a/abruenic/Darwins_finches/hom_ROHs_4x.txt

cat ${LINE}_8x.hom >> /scratch/snyder/a/abruenic/Darwins_finches/hom_ROHs_8x.txt

cat ${LINE}_12x.hom >> /scratch/snyder/a/abruenic/Darwins_finches/hom_ROHs_12x.txt

cat ${LINE}_16x.hom >> /scratch/snyder/a/abruenic/Darwins_finches/hom_ROHs_16x.txt

cd ..

done

# END

