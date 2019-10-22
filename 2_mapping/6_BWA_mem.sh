#!/bin/sh

#PBS -N BWA_mem
#PBS -q fnrgenetics
#PBS -l nodes=1:ppn=20,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load bwa

cd $PBS_O_WORKDIR

cat PJRJA301892 | while read -r LINE

do

# this defines sample and SRA
sra=$(echo "$LINE" | cut -d$'\t' -f2)
echo $sra

# go to sample dir and download the associated SRA
cd $sra

#cp /scratch/snyder/a/abruenic/Darwins_finches/ref* .

FILE1=${sra}_1.truncated.gz

# check if the AdaptorRemoval fq files exist
if [ -e "$FILE1" ]

then
bwa mem -t 20 -M -R "@RG\tID:group1\tSM:$sra\tPL:illumina\tLB:lib1\tPU:unit1" \
ref.fa ${sra}_1.truncated.gz ${sra}_2.truncated.gz > ${sra}.sam

else

# fastq
bwa mem -t 20 -M -R "@RG\tID:group1\tSM:$sra\tPL:illumina\tLB:lib1\tPU:unit1" \
ref.fa ${sra}_1.fastq.gz ${sra}_2.fastq.gz > ${sra}.sam

fi

cd ..

done

# END

