#!/bin/sh

#PBS -N pcangsd
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=singleuser
#PBS -l walltime=300:00:00
#PBS -m abe

module load bioinfo
module load r

export R_LIBS=~/Rlibs:$R_LIBS

cd $PBS_O_WORKDIR

cat populations.txt | while read -r LINE

do

cp ${LINE}.inbreed.sites.npy species.inbreed.sites.npy
cp ${LINE}.lrt.sites.npy species.lrt.sites.npy

Rscript /scratch/snyder/a/abruenic/Darwins_finches/HWE.R

mv inbreeding.txt ${LINE}_inbreeding.txt

rm -rf species.inbreed.sites.npy
rm -rf species.lrt.sites.npy

done

#END
