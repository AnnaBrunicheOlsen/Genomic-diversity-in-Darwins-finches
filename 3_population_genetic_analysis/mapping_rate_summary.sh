#!/bin/sh

#PBS -N flagstat
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=singleuser
#PBS -l walltime=4:00:00
#PBS -m abe

module load bioinfo
module load samtools

cd $PBS_O_WORKDIR

cat xaf | while read -r LINE

do

samtools flagstat ${LINE}.bam > ${LINE}.out

done

#END
