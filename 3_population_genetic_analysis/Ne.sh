#!/bin/sh

#PBS -N ne_SFS
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=0:30:00
#PBS -m abe

module purge
module load bioinfo
module load r

cd $PBS_O_WORKDIR

cat populations.txt | while read -r LINE

do

cd $LINE

Rscript /scratch/snyder/a/abruenic/Darwins_finches/Ne_SFS.R

echo $LINE

echo "Ne"
Ne=$(sed -n '1p' Ne.txt)
echo $Ne

cd ..

done

#END
