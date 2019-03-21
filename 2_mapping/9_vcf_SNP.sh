#!/bin/sh

#PBS -N make_realignbam
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=4:00:00
#PBS -m abe

module purge
module load bioinfo
module load GATK/3.8.1

cd $PBS_O_WORKDIR

mkdir tmp

# convert g.vcf to vcf
java -Djava.io.tmpdir=/scratch/snyder/a/abruenic/Darwins_finches/${PWD}/tmp/ -jar $GATK \
-T GenotypeGVCFs \
   -R /scratch/snyder/a/abruenic/Darwins_finches/ref.fa \
   --variant ${LINE}.g.vcf \
   -o ${LINE}.vcf

# select SNPs
GenomeAnalysisTK -T SelectVariants -R /scratch/snyder/a/abruenic/Darwins_finches/ref.fa \
-V ${LINE}.vcf -selectType SNP -o ${LINE}_SNPs.vcf

# END
