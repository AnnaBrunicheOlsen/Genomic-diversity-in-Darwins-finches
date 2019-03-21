#!/bin/sh

#PBS -N GATK
#PBS -q fnrquail
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load GATK/3.8.1

cd $PBS_O_WORKDIR

# run GenotypeGVCF to crease raw SNP and indel VCFs
java -jar $GATK -T CombineGVCFs \
-R ref.fa \
   --variant /scratch/snyder/a/abruenic/Darwins_finches/Tiaris_bicolor_T1/Tiaris_bicolor_T1.g.vcf \
   --variant /scratch/snyder/a/abruenic/Darwins_finches/Tiaris_bicolor_T2/Tiaris_bicolor_T2.g.vcf \
   --variant /scratch/snyder/a/abruenic/Darwins_finches/Tiaris_bicolor_T3/Tiaris_bicolor_T3.g.vcf \
   -o population.g.vcf

mkdir tmp

# convert g.vcf to vcf
java -Djava.io.tmpdir=/tmp/ -jar $GATK \
-T GenotypeGVCFs \
   -R ref.fa \
   --variant population.g.vcf \
   -o population.vcf

# select SNPs
GenomeAnalysisTK -T SelectVariants -R ref.fa \
-V population.vcf -selectType SNP -o population_SNPs.vcf

#END

# END

