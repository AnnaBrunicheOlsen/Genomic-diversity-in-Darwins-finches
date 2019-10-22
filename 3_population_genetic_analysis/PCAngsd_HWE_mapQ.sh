#!/bin/sh

#PBS -N pcangsd
#PBS -q fnrwhale
#PBS -l nodes=1:ppn=20,naccesspolicy=singleuser
#PBS -l walltime=40:00:00
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

# make sure that all mtDNA, X and Y chr are excluded in the reference
# Hvis du koere HWE i pcangsd burde du kunne finde ud af hvilke det er samt hvis der 
# er scaffolds som er over merged/paraloge

# set min and max depth
# max gns dybde * 2 * antal ind
# min gns dybde / 2 * antal ind

# The input files are called mapq30.beagle.gz and mapq30.mafs.gz
angsd -GL 1 -minMapQ 30 -minQ 20 -out mapq30 -nThreads 20 -doGlf 2 -doMajorMinor 1 \
-doMaf 2 -SNP_pval 1e-6 -bam bam.filelist

# Estimate covariance matrix and individual admixture proportions
#python /home/abruenic/pcangsd/pcangsd.py -beagle mapq30.beagle.gz -admix -o mapq30 -threads 20

# Estimate covariance matrix and inbreeding coefficients
#python /home/abruenic/pcangsd/pcangsd.py -beagle mapq30.beagle.gz -inbreed 2 -o mapq30 -threads 20

# Estimate covariance matrix and perform selection scan
python /home/abruenic/pcangsd/pcangsd.py -beagle mapq30.beagle.gz -selection 2 -o mapq30 -threads 20

# Estimate kinship matrix based on method Based on PC-Relate
python /home/abruenic/pcangsd/pcangsd.py -beagle mapq30.beagle.gz -kinship -o mapq30 -threads 20

# estimate HWE
# Hvis du koere HWE i pcangsd burde du kunne finde ud af hvilke det er samt hvis der er 
# scaffolds som er over merged/paraloge dvs at scallold representere mere en et region
# af genomet fordi man er merged dem naar man har lavet scaffold og derfor vil der 
# vaere sites hvor alle er heteroxygote. 
# Du kan finde disse site som vil have negativ F i HWE test taet paa -1 hvis alle er
# heterozygote Disse sites vil faa individer til at se ud som om de er i familie
python /home/abruenic/pcangsd/pcangsd.py -beagle mapq30.beagle.gz -inbreedSites -o mapq30 -threads 20


#END
