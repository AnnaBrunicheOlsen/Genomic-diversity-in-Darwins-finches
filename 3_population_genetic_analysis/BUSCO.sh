#!/bin/sh

#PBS -N busco
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=20,naccesspolicy=singleuser
#PBS -l walltime=300:00:00
#PBS -m abe

module load bioinfo
module load BUSCO
module load AUGUSTUS
module load gcc
module load bamtools/2.4.0

cd $PBS_O_WORKDIR

#mkdir /home/abruenic/augustus
#cp -rp $AUGUSTUS_CONFIG_PATH /home/abruenic/augustus
export AUGUSTUS_CONFIG_PATH=/home/abruenic/augustus/config

# assess genome completeness by running BUSCO
BUSCO -i ref.fa -o out -l eukaryota_odb9 -m geno -c 20

# END