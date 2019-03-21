#!/bin/sh

#PBS -N ngsRelate
#PBS -q fnrquail
#PBS -l nodes=1:ppn=20,naccesspolicy=shared
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
export PATH=/home/abruenic/ngsRelate/:$PATH

# make bam.filelist
#ls > bam.filelist

### First we generate a file with allele frequencies (angsdput.mafs.gz) 
# and a file with genotype likelihoods (angsdput.glf.gz).
angsd -b bam.filelist -gl 2 -domajorminor 1 -snp_pval 1e-6 -domaf 1 \
-minMapQ 20 -minQ 20 -minmaf 0.05 -doGlf 3 -P 20

### Then we extract the frequency column from the allele frequency file and 
# remove the header (to make it in the format NgsRelate needs)
zcat angsdput.mafs.gz | cut -f5 |sed 1d > freq

# insert the number of individuals 
ind=$(wc -l < bam.filelist)

### run NgsRelate
ngsRelate -g angsdput.glf.gz -n $ind -f freq -p 20 > newres

#END
