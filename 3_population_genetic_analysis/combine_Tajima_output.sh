#!/bin/sh

#PBS -N combineTajimasD
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=0:30:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

cat sample.txt | while read -r LINE

do

cd $LINE

# combine all Tajimas D output from ANGSD
# select column 9,10,11
awk '{print $9 "\t" $10 "\t" $11}' theta.thetasWindow.gz.pestPG > Tajimas

# insert header
header=$(echo $LINE $LINE $LINE)

awk -v x="$header" 'NR==1{print x} 1' file.txt

# END

