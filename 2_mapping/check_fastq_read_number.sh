#!/bin/sh

#PBS -N GATK_remaining_SRR
#PBS -q fnrquail
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load GATK/3.8.0
module load samtools
module load picard-tools

cd $PBS_O_WORKDIR

cat PRJNA301892_remaining_sample_sra.txt | while read -r LINE

do

# this defines SRA
sra=$(echo "$LINE" | cut -d$'\t' -f2)
echo $sra

fq1=$(echo "$LINE" | cut -d$'\t' -f3)
fq2=$(echo "$LINE" | cut -d$'\t' -f4)

# go to sample dir
cd $sra

# count number of reads in fastq files
R1=$(awk '{s++}END{print s/4}' ${sra}_1.fastq.gz)
R2=$(awk '{s++}END{print s/4}' ${sra}_2.fastq.gz)

# check that the number of reads are identical
if [$R1 -eq $R2]
	then
		echo "R1 equal R2"

	else 
	echo "R1 non R2"
fi

cd ..

done

# END
