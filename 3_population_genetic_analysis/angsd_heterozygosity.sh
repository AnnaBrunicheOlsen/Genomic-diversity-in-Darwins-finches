#!/bin/sh

#PBS -N angsd
#PBS -q fnrquail
#PBS -l nodes=1:ppn=20,naccesspolicy=singleuser
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

cat bam.filelist | while read -r LINE

do

# estimate SFS
angsd -i ${LINE} -anc ref.fa -dosaf 1 -gl 1 -minMapQ 20 -minQ 20 -out ${LINE}

#followed by the actual estimation
realSFS ${LINE} .saf.idx > ${LINE}.ml

done


#END
