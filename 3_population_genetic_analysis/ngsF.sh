#!/bin/sh

#PBS -N ngsF
#PBS -q fnrquail
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load samtools


cd $PBS_O_WORKDIR

export PATH=/home/abruenic/angsd/:$PATH
export PATH=/home/abruenic/angsd/misc/:$PATH

# ORIGNINAL
angsd -P 4 -b typeB1.bamlist -ref ref.fa -out Results/typeB1 -r 11 \
-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -baq 1 \
-minMapQ 20 -minQ 20 -minInd 5 -setMinDepth 20 -setMaxDepth 200 -doCounts 1 \
-GL 1 -doMajorMinor 1 -doMaf 1 -skipTriallelic 1 \
-doGlf 3 -SNP_pval 1e-3 &> /dev/null

# ANNA
angsd -P 4 -b typeB1.bamlist -ref ref.fa -out typeB1 \
-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -baq 1 \
-minMapQ 30 -minQ 20 -minInd 5 -setMinDepth 20 -setMaxDepth 200 -doCounts 1 \
-GL 1 -doMajorMinor 1 -doMaf 1 -skipTriallelic 1 \
-doGlf 3 -SNP_pval 1e-3 


-b 				filelist
-r 				region
-uniqueOnly 	remove reads that have multiple best hits
-remove_bads 	Same as the samtools flags -x which removes read with a flag above 255
-only_proper_pairs include with both mate pairs mapped
-trim 			number of bases to remove from both ends of the read
-C 				adjust mapQ for excessice mismathces 
-baq 			use BAQ computation
-minMapQ 		min map quality
-minQ 			min base quality score
-minInd			Only keep sites with at least minIndDepth (default is 1) from at least [int] individuals
-setMinDepth 	discard sites with total depth less than X
-setMaxDepth	discard sites with total depth more than X
-doCounts		allele frequency counts
-GL 			genotype likelihood
-doMajorMinor	infer minor and major allele
-doMaf 			calculate allele frequencies
-skipTriallelic only 2 variants
-doGlf 			estimate GL
-SNP_pval 		remove sites with P-values larger

#cat sample.txt | while read -r LINE

#do

#cd $LINE



#cd ..

#done

# END


angsd -I SAMEA2784708.bam -doSaf 1 -out 112_30Mb -anc ref.fa \
-GL 1 -P 10 -minMapQ 30 -minQ 20