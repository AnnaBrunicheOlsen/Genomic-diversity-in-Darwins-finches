#!/bin/sh

#PBS -N check_samfile
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=0:30:00
#PBS -m abe

module purge
module load bioinfo
module load samtools
module load picard-tools

cd $PBS_O_WORKDIR

cat missing | while read -r LINE

do

# this defines sample and SRA
sra=$(echo "$LINE" | cut -d$'\t' -f2)
echo $sra

# check that the samfile has no errors
cd $sra

check=$(grep "No errors found" *_samfile.txt)

# check if variable is empty
if [ -z "$check" ]
then
	echo "error"
else
	echo "no_error"	
fi

cd ..

done

# END
