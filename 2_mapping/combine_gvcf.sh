#!/bin/sh

#PBS -N gcvf_names
#PBS -q fnrquail
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load samtools

cd $PBS_O_WORKDIR

cat 120_birds.txt | while read -r LINE

do

cd $LINE

if grep -Fq "SRRedited" ${LINE}.g.vcf
then 
	# change sample info on g.vcf file
	sed -i -e "s/SRRedited/${LINE}/" ${LINE}.g.vcf
fi
	
cd ..

done

# END
