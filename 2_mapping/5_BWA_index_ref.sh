#!/bin/sh

#PBS -N BWA_index_ref
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load bwa

cd $PBS_O_WORKDIR

# download reference genome
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/277/835/GCF_000277835.1_GeoFor_1.0/GCF_000277835.1_GeoFor_1.0_genomic.fna.gz

# change name to ref
mv GCF_000277835.1_GeoFor_1.0_genomic.fna.gz ref.fa.gz

# unzip
gunzip ref.fa.gz

# index reference and map reads
bwa index -a bwtsw ref.fa

# END
