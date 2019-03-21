
# filter vcf file for depth
vcffilter -f "DP > 11" ${LINE}_SNPs.vcf > out.vcf

# divide header and SNPs
grep "#" out.vcf > header.txt
grep -v "#" out.vcf > body.txt

# filter vcf for sequencing errors
grep -v -a '0/1:1' body.txt > body1.txt
grep -v -a '0/1:*,1:' body1.txt > body2.txt

# count number of columns (10 columns)
#awk '{print NF}' out3.vcf | sort -nu | tail -n 1

# GT info is in column 10
#awk '{print $10}' body2 > hetero

# put the vcf back together
cat header.txt body2.txt > ${LINE}_12x.vcf


vcftools --vcf ${LINE}_12x.vcf --plink --out ${LINE}_12x

# make test file with scaffold info instead of chromosome info
# take column with contig info
awk '{print $2}' ${LINE}_12x.map > scaffold.txt
#split at the first full stop
awk -F'.' '{print $1}' scaffold.txt > scaffold2.txt
paste -d' ' scaffold2.txt ${LINE}_12x.map > test.map
awk '{print $1,$3,$4,$5}' test.map > ${LINE}_12x.map

# min 1KB in length
plink-1.9 --ped ${LINE}_12x.ped --map ${LINE}_12x.map --allow-extra-chr \
--homozyg-snp 20 \
--homozyg-kb 10 --homozyg-window-het 0 --homozyg-window-snp 20 \
--homozyg-window-threshold 0.05 --out ${LINE}_12x

# count number of ROHs, ROHs are in column 9
awk '{print $9}' ${LINE}_12x.hom > ROH.txt

# remove header
tail -n+2 ROH.txt > roh.txt

# count number of ROHs
wc -l roh.txt > rohNumber.txt
rohNumber=$(awk '{print $1}' rohNumber.txt)

# estimate length of ROHs
rohLength=$(awk '{ sum += $1} END {printf "%.2f", sum }' roh.txt)

# number of SNPs in ROHs, SNPs are in column 10
awk '{print $10}' ${LINE}_12x.hom > ROH_SNPs.txt

# remove header
tail -n+2 ROH_SNPs.txt > roh_snps.txt

# estimate number of ROHs
snpNumberROH=$(awk '{ sum += $1} END {printf "%.2f", sum }' roh_snps.txt)

# change name in *.hom files
# this is to make the file ready for R-plots
sed -i "s/sample1/$LINE/g" ${LINE}_12x.hom


# total number of sites at 20x depth of coverage
# replace \t with \n
tr '\t' '\n' < realigned_reads.sample_cumulative_coverage_counts > site_12x.txt
# grep line 516 (gte_12)
sites=$(sed -n '516p' site_12x.txt)

# print to file
echo -e "$PWD\t $sites" \
>> /scratch/snyder/a/abruenic/Darwins_finches/sites_20x_coverage.txt

# count heterozygotes
grep -a '0/1' ${LINE}_12x.vcf > het.txt
het="$(wc -l < het.txt)"

# count homozygotes
grep -a '0/0' ${LINE}_12x.vcf > homo.txt
grep -a '1/1' ${LINE}_12x.vcf >> homo.txt
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

# print to file
echo -e "$PWD\t $rohNumber\t $rohLength\t $snpNumberROH\t \
$sites\t $het\t $homo\t $SNPs\t $non\t $heteroAll\t $heteroNoRoh" \
>> /scratch/snyder/a/abruenic/Darwins_finches/heterozygosity_12x.txt
