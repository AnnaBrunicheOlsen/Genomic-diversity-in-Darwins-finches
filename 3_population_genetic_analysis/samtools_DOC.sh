#!/bin/sh

#PBS -N DOC
#PBS -q fnrquail
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load samtools

cd $PBS_O_WORKDIR

cat sample.txt | while read -r LINE

do

cd $LINE

# check coverage in each bam file
# some files have realigned_reads.bam others have realigned_reads_SM.bam

FILE=$"realigned_reads_SM.bam"

if [ -f $FILE ]
then
	samtools depth realigned_reads_SM.bam | awk '{sum += $3} END {print sum / NR}' > depth.txt
	depth=$(sed -n '1p' depth.txt)
else
	samtools depth realigned_reads.bam | awk '{sum += $3} END {print sum / NR}' > depth.txt
	depth=$(sed -n '1p' depth.txt)
fi

# print to file
echo -e "$PWD\t $depth" \
>> /scratch/snyder/a/abruenic/Darwins_finches/DOC.txt

cd ..

done

# END
