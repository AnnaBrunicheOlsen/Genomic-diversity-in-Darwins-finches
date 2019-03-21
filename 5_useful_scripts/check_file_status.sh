#!/bin/sh

#PBS -N check_files_exist
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=04:00:00
#PBS -m abe

module purge
module load bioinfo
module load samtools

cd $PBS_O_WORKDIR

cat 120_birds_1.txt | while read -r LINE

do

# go to sample dir
cd $LINE
	
	echo "$PWD"
	
# check that out.bam exists
if [ -f out.bam ];
then 
	echo 'Found out.bam!';
else
	echo 'No out.bam'	
fi

# check that marked.bam exists
if [ -f marked.bam ];
then 
	echo 'Found marked.bam!';
else
	echo 'No marked.bam'
fi

# check that realigned_reads.bam exists
if [ -f realigned_reads.bam ];
then 
	echo 'Found realigned_reads.bam!';
	# check that the NW_005081535.1 scaffold is there
	samtools index realigned_reads.bam
	samtools view -b realigned_reads.bam NW_005081535.1 > subset.bam
	if [ ! -s subset.bam ];
	then 
	echo "No NW_005081535.1";
	fi
else 
	echo 'No realigned.bam'
fi

#
# check that g.vcf exists
if [ -f ${LINE}.g.vcf ];
then 
	echo 'Found .g.vcf!';
	# check that "NW_005081535.1	122" is the last scaffold
	last_scaffold=$(tail -n 1 ${LINE}.g.vcf)
	echo $last_scaffold
else
	echo 'No .g.vcf!';
fi

cd ..

done

# END