#!/bin/sh

#PBS -N pcangsd
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=10,naccesspolicy=singleuser
#PBS -l walltime=300:00:00
#PBS -m abe

module load bioinfo
module load gsl
module load zlib
module load gcc
#module load samtools
module load use.own
module load conda-env/mypackages-py2.7.14
#module load anaconda

cd $PBS_O_WORKDIR

export PATH=/home/abruenic/angsd/:$PATH
export PATH=/home/abruenic/angsd/misc/:$PATH
export PATH=/home/abruenic/pcangsd/:$PATH

# The input files are called data.beagle.gz and data.mafs.gz

cat populations.txt | while read -r LINE

do

cd $LINE

ls *.bam > bam.filelist

# make angsd input 
angsd -GL 1 -out ${LINE} -minMapQ 30 -minQ 20 -nThreads 10 -doGlf 2 -doMajorMinor 1 \
-doMaf 2 -SNP_pval 1e-6 -bam bam.filelist

# Estimate covariance matrix and individual admixture proportions
#python /home/abruenic/pcangsd/pcangsd.py -beagle floreana.beagle.gz -admix -o floreana -threads 20

# Estimate covariance matrix and inbreeding coefficients
#python /home/abruenic/pcangsd/pcangsd.py -beagle floreana.beagle.gz -inbreed 2 -o floreana -threads 20

# Estimate covariance matrix and perform selection scan
#python /home/abruenic/pcangsd/pcangsd.py -beagle floreana.beagle.gz -selection 1 -o floreana -threads 20

python /home/abruenic/pcangsd/pcangsd.py -beagle ${LINE}.beagle.gz -inbreedSites \
-o ${LINE} -threads 10

cd ..

done

#END
