#!/bin/sh

#PBS -N gvcf_vcf
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load vcftools
module load GATK/3.8.1

cd $PBS_O_WORKDIR

cat sample.txt | while read -r LINE

do

cd $LINE

# convert g.vcf to vcf
java -jar $GATK -T GenotypeGVCFs \
   -R /scratch/snyder/a/abruenic/Darwins_finches/VCF/ref.fa \
   --variant ${LINE}.g.vcf \
   -o ${LINE}.vcf

# select SNPs
GenomeAnalysisTK -T SelectVariants -R /scratch/snyder/a/abruenic/killerwhale/ref.fa \
-V ${LINE}.vcf -selectType SNP -o ${LINE}_SNPs.vcf

# filter the ${LINE}.g.vcf file so only sites with minimum 20x are represented
vcffilter -f "DP > 19" ${LINE}_SNPs.vcf > ${LINE}_20x.vcf

cd ..

done

#END