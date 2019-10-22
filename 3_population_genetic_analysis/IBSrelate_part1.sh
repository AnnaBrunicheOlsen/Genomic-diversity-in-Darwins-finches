#!/bin/sh

#PBS -N IBSrelate_part1
#PBS -q fnrwhale
#PBS -l nodes=1:ppn=1,naccesspolicy=singleuser
#PBS -l walltime=300:00:00
#PBS -m abe

module load bioinfo
module load gsl
module load zlib
module load gcc
module load samtools

cd $PBS_O_WORKDIR

export PATH=/home/abruenic/angsd/:$PATH
export PATH=/home/abruenic/angsd/misc/:$PATH
export PATH=/home/abruenic/ngsRelate/:$PATH

# remove ref to save space
#rm -rf ref.fa*

# link to ref
#REF=$"/scratch/snyder/a/abruenic/Darwins_finches/ref.fa"

# make bam.filelist
#ls *.bam > bam.filelist

# make consensus - needed to make saf files
#angsd -b bam.filelist -minMapQ 30 -minQ 20 -P 1 -setMinDepth 3 -doFasta 2 \
#-doCounts 1 -out consensus

#cp /scratch/snyder/a/abruenic/Darwins_finches/ref.fa* .

gunzip consensus.
# reindex fasta file
samtools faidx consensus.fa.gz

samtools faidx ref.fa

cat bam.filelist | while read -r LINE

do

# make *.saf files (per individual)
angsd -i ${LINE} -ref ref.fa \
-anc consensus.fa.gz \
-minMapQ 30 -minQ 20 -GL 2 -doSaf 1 -doDepth 1 -doCounts 1 -out ${LINE}

done

# END