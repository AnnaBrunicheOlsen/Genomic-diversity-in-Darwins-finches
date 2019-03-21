#!/bin/sh

#PBS -N TajimasD
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=20,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load gsl
module load zlib
module load gcc
module load samtools

cd $PBS_O_WORKDIR

export PATH=/home/abruenic/angsd/:$PATH
export PATH=/home/abruenic/angsd/misc/:$PATH

# estimate SFS
angsd -bam bam.filelist -doSaf 1 -anc ref.fa -GL 1 -P 20 -out out \
-minMapQ 20 -minQ 20

# obtain ML estimate of SFS using the realSFS
realSFS out.saf.idx -P 20 > out.sfs

# calculate theta for each site
angsd -bam bam.filelist -out out -doThetas 1 -doSaf 1 -pest out.sfs \
-anc ref.fa -GL 1

# estimate Tajimas D
thetaStat do_stat out.thetas.idx

thetaStat do_stat out.thetas.idx -win 50000 -step 10000  -outnames theta.thetasWindow.gz

# column 9 has Tajimas D
awk '{print $9}' theta.thetasWindow.gz.pestPG > TajimasD

# get mean
meanD=$(awk 'BEGIN{s=0;}{s=s+$1;}END{print s/NR;}' TajimasD)

# get SD
sdD=$(awk '{delta = $1 - avg; avg += delta / NR; \
mean2 += delta * ($1 - avg); } END { print sqrt(mean2 / NR); }' TajimasD)

# column 10 has FU&LIS F
awk '{print $10}' theta.thetasWindow.gz.pestPG > FuLiF

# get mean
meanFuLiF=$(awk 'BEGIN{s=0;}{s=s+$1;}END{print s/NR;}' FuLiF)

# get SD
sdFuLiF=$(awk '{delta = $1 - avg; avg += delta / NR; \
mean2 += delta * ($1 - avg); } END { print sqrt(mean2 / NR); }' FuLiF)

# column 11 has FU&LIS D
awk '{print $11}' theta.thetasWindow.gz.pestPG > FuLiD

# get mean
meanFuLiD=$(awk 'BEGIN{s=0;}{s=s+$1;}END{print s/NR;}' FuLiD)

# get SD
sdFuLiD=$(awk '{delta = $1 - avg; avg += delta / NR; \
mean2 += delta * ($1 - avg); } END { print sqrt(mean2 / NR); }' FuLiD)

# print to file
echo -e "$PWD\t $meanD\t $sdD" \
>> /scratch/snyder/a/abruenic/Darwins_finches/TajimasD.txt

#END
