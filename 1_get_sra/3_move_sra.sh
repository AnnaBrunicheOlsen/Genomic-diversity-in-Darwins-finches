#!/bin/sh

#PBS -N genome_sra
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

cat test.txt | while read -r LINE

do

# this defines the SRA
sra=$(echo "$LINE" | cut -d$'\t' -f2)

# this defines the two read files
R1=$(echo "$LINE" | cut -d$'\t' -f3)

R2=$(echo "$LINE" | cut -d$'\t' -f4)

cd $sra

wget -w 1 -t 3 $R1

wget -w 1 -t 3 $R2

cd ..

done

# END
