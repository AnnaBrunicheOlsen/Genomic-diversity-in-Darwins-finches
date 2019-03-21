#!/bin/sh

#PBS -N BWA_mem
#PBS -q fnrgenetics
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

cat PRJNA301892_sample_sra_fastq.txt | while read -r LINE

do

# this defines sample and SRA
#sample=$(echo "$LINE" | cut -d$'\t' -f1)
echo $sra
sra=$(echo "$LINE" | cut -d$'\t' -f2)

# go to sample dir and download the associated SRA
cd $sra

#qc=$(grep 'No errors found' *_samfile.txt)

#[ -z "$qc" ] && echo "Empty"

# -s file exists and is not zero size
if [ -s "$sra.g.vcf" ]
then 
   echo " file exists and is not empty "
else
   echo " file does not exist, or is empty "
fi

cd ..

done

# END

