#!/bin/sh

#PBS -N wget
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

# wait 1 sec and try 3 times
# put all the ftp in the FILE
wget -w 1 -t 3 -i sra_1_fastq.txt

wget -w 1 -t 3 -i sra_2_fastq.txt

# END
