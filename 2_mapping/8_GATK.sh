#!/bin/sh

#PBS -N GeoCon3
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=20,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load samtools
module load GATK/3.8.1

cd $PBS_O_WORKDIR

LINE=$"Geospiza_conirostris_CE3"

# index bam file
samtools index marked.bam

#GATK was used for local realignment of reads
GenomeAnalysisTK -nt 20 -T RealignerTargetCreator \
-R /scratch/snyder/a/abruenic/Darwins_finches/ref.fa \
-I marked.bam -o forIndelRealigner.intervals

GenomeAnalysisTK -T IndelRealigner -R /scratch/snyder/a/abruenic/Darwins_finches/ref.fa \
-I marked.bam -targetIntervals forIndelRealigner.intervals -o realigned_reads.bam

samtools view -H realigned_reads.bam > header.sam

# change SM to the same for all libraries
sed -i -e 's/\(SRR\)......./\1edited/' header.sam

samtools reheader header.sam realigned_reads.bam > realigned_reads_SM.bam

samtools index realigned_reads_SM.bam

# Run HaplotypeCaller
GenomeAnalysisTK -T HaplotypeCaller \
-R /scratch/snyder/a/abruenic/Darwins_finches/ref.fa -I realigned_reads_SM.bam -nct 20 \
--emitRefConfidence GVCF -stand_call_conf 0 --min_base_quality_score 20 \
--min_mapping_quality_score 20 -o ${LINE}.g.vcf

#mkdir tmp

# convert g.vcf to vcf
java -Djava.io.tmpdir=/scratch/snyder/a/abruenic/Darwins_finches/${LINE}/tmp/ -jar $GATK \
-T GenotypeGVCFs \
   -R /scratch/snyder/a/abruenic/Darwins_finches/ref.fa \
   --variant ${LINE}.g.vcf \
   -o ${LINE}.vcf

# select SNPs
GenomeAnalysisTK -T SelectVariants -R /scratch/snyder/a/abruenic/Darwins_finches/ref.fa \
-V ${LINE}.vcf -selectType SNP -o ${LINE}_SNPs.vcf


# END
