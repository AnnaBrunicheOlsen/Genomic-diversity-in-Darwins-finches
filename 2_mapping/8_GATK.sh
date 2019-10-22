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
-R ref.fa \
-I marked.bam -o forIndelRealigner.intervals

GenomeAnalysisTK -T IndelRealigner -R ref.fa \
-I marked.bam -targetIntervals forIndelRealigner.intervals -o realigned_reads.bam

# END
