#!/bin/sh

#PBS -N depth_60birds
#PBS -q fnrgenetics
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
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

# copy all bam files
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917279/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917279.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917280/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917280.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917281/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917281.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917282/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917282.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917283/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917283.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917284/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917284.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917285/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917285.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917286/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917286.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917287/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917287.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917288/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917288.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917289/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917289.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917290/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917290.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917291/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917291.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917292/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917292.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917293/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917293.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917294/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917294.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917295/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917295.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917296/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917296.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917297/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917297.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917298/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917298.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917299/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917299.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917300/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917300.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917301/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917301.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917302/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917302.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917303/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917303.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917304/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917304.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917305/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917305.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917306/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917306.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917307/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917307.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917308/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917308.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917309/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917309.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917310/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917310.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917311/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917311.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917312/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917312.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917313/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917313.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917314/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917314.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917315/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917315.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917316/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917316.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917317/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917317.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917318/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917318.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917319/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917319.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917320/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917320.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917321/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917321.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917322/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917322.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917323/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917323.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917324/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917324.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917325/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917325.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917326/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917326.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917327/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917327.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917328/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917328.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917329/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917329.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917330/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917330.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917331/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917331.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917332/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917332.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917333/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917333.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917334/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917334.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917335/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917335.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917336/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917336.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917337/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917337.bam
cp /scratch/snyder/a/abruenic/Darwins_finches/SRR2917338/realigned_reads.bam /scratch/snyder/a/abruenic/Darwins_finches/60_birds/SRR2917338.bam

# find depth for all sites
angsd -bam 60_birds.bamlist -doDepth 1 -out all -doCounts 1

# find depth for files fulfilling our filtering criteria
angsd -bam 60_birds.bamlist -doDepth 1 -out strict -doCounts 1 -minMapQ 20 -minQ 20

# END