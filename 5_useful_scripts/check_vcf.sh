#!/bin/sh

#PBS -N check_vcf
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=04:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

cat 120_birds_original.txt | while read -r LINE

do

# go to sample dir
cd $LINE
	
	echo "$PWD"

# check that g.vcf exists
if [ -f ${LINE}.g.vcf ];
then 
	echo 'Found .g.vcf!';
	# check that "NW_005081535.1	122" is the last scaffold
#	last_scaffold=$(tail -n 1 ${LINE}.g.vcf)
#	echo $last_scaffold
else
	echo 'No .g.vcf!';
fi

# check that vcf exists
if [ -f ${LINE}.vcf ];
then 
	echo 'Found .vcf!';
else
	echo 'No .vcf!';
fi

# check that SNP vcf exists
if [ -f ${LINE}_SNPs.vcf ];
then 
	echo 'Found SNPs.vcf!';
		# check that "NW_005081535.1	122" is the last scaffold
	last_scaffold=$(tail -n 1 ${LINE}_SNPs.vcf)
	echo $last_scaffold
else
	echo 'No SNPs.vcf!';
fi

cd ..

done

# END

