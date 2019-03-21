#!/bin/sh

#PBS -N DepthOfCoverage
#PBS -q fnrquail
#PBS -l nodes=1:ppn=19,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load picard-tools
module load GATK/3.8.1
module load vcftools

cd $PBS_O_WORKDIR

cat sample.txt | while read -r LINE

do

cd $LINE

# coverage needs to be included we chose 20x as minimum
# check if the file listing coverage/bp exists
FILE1=$"realigned_reads.sample_cumulative_coverage_counts"

if [ -f $FILE1 ]
then

    echo "$FILE1_exist"
    coverage=$"$FILE1_exist"

else
	PicardCommandLine BuildBamIndex INPUT=realigned_reads.bam

	GenomeAnalysisTK -T DepthOfCoverage -R /scratch/snyder/a/abruenic/Darwins_finches/VCF/ref.fa \
	-o realigned_reads -I realigned_reads.bam -nt 19 -omitIntervals -omitSampleSummary \
	-omitBaseOutput

fi

cd ..

done

# END