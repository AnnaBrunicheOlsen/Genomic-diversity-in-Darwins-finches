#!/bin/sh

#PBS -N TajimasD
#PBS -q fnrquail
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

#mkdir Camarhynchus_pallidus
#cd Camarhynchus_pallidus
#cp /scratch/snyder/a/abruenic/Darwins_finches/Camarhynchus_pallidus_PAL1/realigned_reads.bam Camarhynchus_pallidus_PAL1.bam
#cp /scratch/snyder/a/abruenic/Darwins_finches/Camarhynchus_pallidus_PAL2/realigned_reads.bam Camarhynchus_pallidus_PAL2.bam
#cp /scratch/snyder/a/abruenic/Darwins_finches/Camarhynchus_pallidus_PAL3/realigned_reads.bam Camarhynchus_pallidus_PAL3.bam
#cp /scratch/snyder/a/abruenic/Darwins_finches/Camarhynchus_pallidus_PAL4/realigned_reads.bam Camarhynchus_pallidus_PAL4.bam
#cp /scratch/snyder/a/abruenic/Darwins_finches/Camarhynchus_pallidus_PAL5/realigned_reads.bam Camarhynchus_pallidus_PAL5.bam
#cp /scratch/snyder/a/abruenic/Darwins_finches/ref.* .

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

# END