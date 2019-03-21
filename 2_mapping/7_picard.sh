#!/bin/sh

#PBS -N picard
#PBS -q fnrquail
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load picard-tools

#module load samtools

cd $PBS_O_WORKDIR

cat 120_birds_1.txt | while read -r LINE

do

# go to sample dir and download the associated LINE
cd $LINE

# make tmp directory for the files
mkdir tmp

# marking PCR duplicated reads without removing them
PicardCommandLine MarkDuplicates INPUT=out.bam OUTPUT=marked.bam M=metrics.txt

# check coverage
PicardCommandLine CollectWgsMetrics I=marked.bam O=coverage_marked.txt \
R=/scratch/snyder/a/abruenic/Darwins_finches/ref.fa

PicardCommandLine BuildBamIndex INPUT=marked.bam

# create reference that reads can be mapped to. Will produce .fai file
#samtools faidx /scratch/snyder/a/abruenic/Darwins_finches/ref.fa

PicardCommandLine CreateSequenceDictionary \
reference=/scratch/snyder/a/abruenic/Darwins_finches/ref.fa output=ref.dict

cd ..

done

# END
