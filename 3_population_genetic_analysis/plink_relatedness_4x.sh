#!/bin/sh

#PBS -N relatedness_4x
#PBS -q fnrquail
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load vcflib
module load GATK/3.8.1
module load vcftools

cd $PBS_O_WORKDIR

# plink path
export PATH=/depot/fnrdewoody/apps:$PATH

cat populations.txt | while read -r LINE

do

cd $LINE

##########################
##### call genotypes #####
##########################

# filter vcf file for depth
vcffilter -f "DP > 3" population_SNPs.vcf > out.vcf

# divide header and SNPs
grep "#" out.vcf > header.txt
grep -v "#" out.vcf > body.txt

# filter vcf for sequencing errors
grep -v -a '0/1:1,' body.txt > body1.txt
grep -v -a '0/1:*,1:' body1.txt > body2.txt

# put the vcf back together
cat header.txt body2.txt > population_SNPs.vcf

# remove intermediate files
rm -rf header.txt
rm -rf body*.txt
rm -rf out.vcf

#############################################
###### THIS PART ESTIMATES RELATEDNESS ######
#############################################

# run directly on VCF
plink-1.9 --vcf population_SNPs.vcf --double-id --allow-extra-chr \
--genome full

# count number of ROHs, ROHs are in column 9
awk '{print $9}' population_SNPs.hom > ROH.txt

# remove header
tail -n+2 ROH.txt > roh.txt

# count number of ROHs
wc -l roh.txt > rohNumber.txt
rohNumber=$(awk '{print $1}' rohNumber.txt)

# estimate length of ROHs
rohLength=$(awk '{ sum += $1} END {printf "%.2f", sum }' roh.txt)

# number of SNPs in ROHs, SNPs are in column 10
awk '{print $10}' population_SNPs.hom > ROH_SNPs.txt

# remove header
tail -n+2 ROH_SNPs.txt > roh_snps.txt

# estimate number of ROHs
snpNumberROH=$(awk '{ sum += $1} END {printf "%.2f", sum }' roh_snps.txt)

# change name in *.hom files
# this is to make the file ready for R-plots
sed -i "s/sample1/$LINE/g" population_SNPs.hom

# write results to file
cat population_SNPs.hom >> /scratch/snyder/a/abruenic/Darwins_finches/individual_ROHs.txt

############################################
###### THIS PART FINDS HETEROZYGOSITY ######
############################################

# total number of sites at 20x depth of coverage
# replace \t with \n
tr '\t' '\n' < realigned_reads.sample_cumulative_coverage_counts > site_16x.txt
# grep line 520 (gte_16)
sites=$(sed -n '520p' site_16x.txt)

# print to file
echo -e "$PWD\t $sites" \
>> /scratch/snyder/a/abruenic/Darwins_finches/sites_20x_coverage_16x.txt

# count heterozygotes
grep -a '0/1' population_SNPs.vcf > het.txt
het="$(wc -l < het.txt)"

# count homozygotes
grep -a '0/0' population_SNPs.vcf > homo.txt
grep -a '1/1' population_SNPs.vcf >> homo.txt
homo="$(wc -l < homo.txt)"

# total number of SNPs
SNPs=$(($homo + $het)) 

# non-variant sites
bc <<< "($sites - $SNPs)" > non.txt
non=$(sed -n '1p' non.txt)

# heterozygosity
# adjust scale to allow for decimals
bc <<< "scale=9; ($het / $sites)" > hetero.txt
heteroAll=$(sed -n '1p' hetero.txt)

# heterozygosity minus ROH snps
bc <<< "($sites - $snpNumberROH)" > sitesNoRoh.txt
sitesNoRoh=$(sed -n '1p' sitesNoRoh.txt)
bc <<< "scale=9; ($het / $sitesNoRoh)" > hetNoRoh.txt
heteroNoRoh=$(sed -n '1p' hetNoRoh.txt)

# SNPrate
bc <<< "scale=6; ($SNPs / $sites)" > SNPrate.txt
SNPrate=$(sed -n '1p' SNPrate.txt)

# remove excess files
rm -rf *.txt
rm -rf *nosex
rm -rf *log
rm -rf *map
rm -rf *ped
rm -rf *summary
rm -rf *.e*
rm -rf *.o*
rm -rf *.sh
rm -rf *.sam

#echo -e ""PWD"\t "rohNumber"\t "rohLength"\t "snpNumberROH"\t \
#"sites"\t "het"\t "homo"\t "SNPs"\t "non"\t "heteroAll"\t "heteroNoRoh"" \
#>> /scratch/snyder/a/abruenic/Darwins_finches/heterozygosity.txt

# print to file
echo -e "$PWD\t $rohNumber\t $rohLength\t $snpNumberROH\t \
$sites\t $het\t $homo\t $SNPs\t $non\t $heteroAll\t $heteroNoRoh" \
>> /scratch/snyder/a/abruenic/Darwins_finches/heterozygosity_16x.txt

cd ..

done

# END