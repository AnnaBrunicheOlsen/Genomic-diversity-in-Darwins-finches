#!/bin/sh

#PBS -N proportion_genome_snps_10kb
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

# What proportion of the genome is in scaffolds containing 20 or more SNPs 
# for each individual? 

cat sample.txt | while read -r LINE

do

cd $LINE

# omit header
grep -v "#" ${LINE}_16x.vcf > SNPs.txt

# grep gi_entries
cut -d. -f1 SNPs.txt > gi_numbers.txt

# count number of times each gi_ entry occurs
uniq -c gi_numbers.txt > gi_frequency.txt

# total number of different gi_
total_gi="$(wc -l < gi_frequency.txt)" 

# gi_ entries is equal or greater than 20
ge_20="$(awk '$1>19{c++} END{print c+0}' gi_frequency.txt)"

awk '$1>19' gi_frequency.txt > ge_20.txt
grep "NW" ge_20.txt > ge_20_NW.txt
sed 's/^.*NW/NW/' ge_20_NW.txt > ge_20_scaf.txt

# gi_entries minimum 10kb in length
# make file with gi with minimum 10kb length
# cd /scratch/snyder/a/abruenic/killerwhale
#awk ' $2 > 9999 ' ref.fa.fai > scaffolds_10kb.txt
#awk '{print $1}' scaffolds_10kb.txt > 1st_column.txt
#awk '{print $2}' scaffolds_10kb.txt > 2nd_column.txt
#sed -i 's/.\{2\}$//' 1st_column.txt
#paste 1st_column.txt 2nd_column.txt > scaffolds_10kb_x.txt
#grep "NW" scaffolds_10kb_x.txt > scaffolds_10kb.txt

# remove intermediate files
#rm -rf 1st*
#rm -rf 2nd*
#rm -rf scaffolds_10kb_x.txt

# compare the scaffolds with >20 SNPs to the scaffold length file
awk 'FNR==NR{a[$1];next}($1 in a){print}' ge_20_scaf.txt \
/scratch/snyder/a/abruenic/Darwins_finches/scaffolds_10kb.txt > scaffolds_genome_16x.txt

# "genome" length == length of scaffolds >10kb + >20SNPs
cut -f2 scaffolds_genome.txt > length.txt
genome="$(awk '{ sum += $1 } END { print sum }' length.txt)"

# remove excess files
rm -rf SNPs.txt
rm -rf gi_numbers.txt
rm -rf gi_frequency.txt
rm -rf ge_20.txt
rm -rf ge_20_NW.txt
rm -rf ge_20_scaf.txt
rm -rf scaffolds_genome.txt
rm -rf length.txt

# print to file
#echo -e ""PWD"\t "total_scaffolds"\t "scaffold_min_20SNPs"\t "genome_size"" \
#>> /scratch/snyder/a/abruenic/Darwins_finches/proportion_scaffolds_10kb_20snps.txt

echo -e "$PWD\t $total_gi\t $ge_20\t $genome" \
>> /scratch/snyder/a/abruenic/Darwins_finches/proportion_scaffolds_10kb_20snps_16x.txt

cd ..

done

# END 
