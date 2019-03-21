#!/bin/sh

#PBS -N msmc
#PBS -q fnrquail
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load samtools
module load bcftools
module load python/3.4.1
module load bwa

cd $PBS_O_WORKDIR

export PATH=/depot/fnrdewoody/apps:$PATH

cat sample.txt | while read -r LINE

do

cd $LINE

# index bam file
samtools index realigned_reads.bam

# pull out the longest scaffold (30Mb) NW_005054297.1
samtools view -b realigned_reads.bam NW_005054297.1 > in.bam

# check mean coverage in bam file
samtools depth in.bam | awk '{sum += $3} END {print sum / NR}' > depth.txt

meanDOC=$(sed -n '1p' depth.txt)

samtools mpileup -q 20 -Q 20 -C 50 -u -f ref.fa in.bam \
| bcftools call -c -V indels | \
./bamCaller.py ${meanDOC} out_mask.bed.gz | gzip -c > out.vcf.gz

# needs python3
# make infile
###### scaf1 ######
./msmc-tools-master/generate_multihetsep.py \
						 --mask=scaf1_112.bed.gz \
                         --mask=scaf1.ref.mask.bed.gz \
                         scaf1_112.vcf.gz > scaf1_112.txt

cd ..

done

# END