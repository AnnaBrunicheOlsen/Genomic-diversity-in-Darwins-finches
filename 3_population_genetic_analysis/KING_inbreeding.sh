# estimate KING relatedness coefficient for each pair of individuals

# make list of files
ls *2dsfs > files

cat files | while read -r LINE

do

# remove "
sed -i -e 's/"//g' $LINE

# find and replace "," with "\t"
sed -i -e 's/,/\t/g' $LINE 

# remove header
sed -i 1d $LINE 

# get mean of R0 coefficent(s)
R0=$(awk '{ total += $20 } END { print total/NR }' $LINE)

# get mean of R1 coefficent(s)
R1=$(awk '{ total += $21 } END { print total/NR }' $LINE)

# get mean of kings coefficent(s)
king=$(awk '{ total += $22 } END { print total/NR }' $LINE)

# mean Fst
Fst=$(awk '{ total += $23 } END { print total/NR }' $LINE)

# insert header
#echo -e ""sample_pair"\t "R0"\t "R1"\t "kin"\t "Fst"" \
#> /scratch/snyder/a/abruenic/Darwins_finches/SFS_files/relatedness_coefficients.txt

# print to file
echo -e "$LINE\t $R0\t $R1\t $king\t $Fst" \
>> /scratch/snyder/a/abruenic/Darwins_finches/SFS_files/relatedness_coefficients.tx

done

#END