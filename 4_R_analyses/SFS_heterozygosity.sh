#!/bin/sh

#PBS -N het_SFS
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=singleuser
#PBS -l walltime=0:30:00
#PBS -m abe

module load bioinfo
module load r

cd $PBS_O_WORKDIR

cat birds.txt | while read -r LINE

do

cd $LINE

Rscript /scratch/snyder/a/abruenic/bird_ROH/SFS_heterozygosity.R

het=$(sed -n '1p' het.txt)

# edit this line so it writes to a dir on your computer. The idea is that you will have \
# all the info from all your ABYSS runs in one file 
echo -e "$LINE\t $het" \
>> /scratch/snyder/a/abruenic/bird_ROH/SFS_het.txt

cd ..

done

#END
