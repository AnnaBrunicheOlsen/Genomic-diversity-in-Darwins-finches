#!/bin/sh

#PBS -N vcf
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=4:00:00
#PBS -m abe

module purge
module load bioinfo
module load vcflib
module load vcftools

cd $PBS_O_WORKDIR

cp /scratch/snyder/a/abruenic/Darwins_finches/Camarhynchus_parvulus/population_SNPs.vcf Camarhynchus_parvulus.vcf
cp /scratch/snyder/a/abruenic/Darwins_finches/Certhidea_fusca_Espanola/population_SNPs.vcf Certhidea_fusca_Espanola.vcf

LINE=$"Camarhynchus_parvulus"

vcffilter -f "DP > 7" population_SNPs.vcf > ${LINE}_8x.vcf

# remove heterozygote sites with less than 1 allele
grep "#" ${LINE}_8x.vcf > header.txt
grep -v "#" ${LINE}_8x.vcf > body.txt

grep -v -a '0/1:1,' body.txt > body1.txt
grep -v -a '0/1:*,1:' body1.txt > body2.txt

cat header.txt body2.txt > ${LINE}_8x.vcf

# make PLINK PED file
vcftools --vcf ${LINE}_8x.vcf --plink --out ${LINE}

LINE=$"Certhidea_fusca_Espanola"

vcffilter -f "DP > 7" Certhidea_fusca_Espanola.vcf > ${LINE}_8x.vcf

# remove heterozygote sites with less than 1 allele
grep "#" ${LINE}_8x.vcf > header.txt
grep -v "#" ${LINE}_8x.vcf > body.txt

grep -v -a '0/1:1,' body.txt > body1.txt
grep -v -a '0/1:*,1:' body1.txt > body2.txt

cat header.txt body2.txt > ${LINE}_8x.vcf

# make PLINK PED file
vcftools --vcf ${LINE}_8x.vcf --plink --out ${LINE}


# END
