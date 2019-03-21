#!/bin/sh

#PBS -N gvcf_vcf
#PBS -q fnrgenetics
#PBS -l nodes=1:ppn=20,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load vcftools
module load GATK/3.8.1

cd $PBS_O_WORKDIR

mkdir tmp

# convert g.vcf to vcf
java -Djava.io.tmpdir=/scratch/snyder/a/abruenic/Darwins_finches/Certhidea_fusca/tmp/ -jar $GATK \
-T GenotypeGVCFs -nt 20 \
   -R /scratch/snyder/a/abruenic/Darwins_finches/VCF/ref.fa \
   --variant Certhidea_fusca.g.vcf \
   -o Certhidea_fusca.vcf

# select SNPs
GenomeAnalysisTK -T SelectVariants -R /scratch/snyder/a/abruenic/Darwins_finches/VCF/ref.fa \
-V Certhidea_fusca.vcf -selectType SNP -o Certhidea_fusca_SNPs.vcf

# filter the ${LINE}.g.vcf file so only sites with minimum 20x are represented
vcffilter -f "DP > 19" Certhidea_fusca_SNPs.vcf > Certhidea_fusca_20x.vcf

#END