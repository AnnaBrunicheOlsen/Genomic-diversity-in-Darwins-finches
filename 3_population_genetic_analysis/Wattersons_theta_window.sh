#!/bin/sh

#PBS -N Watterson
#PBS -q fnrquail
#PBS -l nodes=1:ppn=20,naccesspolicy=singleuser
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

# column 4 has Wattersons
awk '{print $4}' theta.thetasWindow.gz.pestPG > Watterson

# get mean
meanW=$(awk 'BEGIN{s=0;}{s=s+$1;}END{print s/NR;}' Watterson)

# get SD
sdW=$(awk '{delta = $1 - avg; avg += delta / NR; \
mean2 += delta * ($1 - avg); } END { print sqrt(mean2 / NR); }' Watterson)

# print to file
echo -e "$PWD\t $meanW\t $sdW" \
>> /scratch/snyder/a/abruenic/Darwins_finches/Wattersons_theta.txt

#END
