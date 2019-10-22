#!/bin/sh

#PBS -N IBSrelate
#PBS -q fnrwhale
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
export PATH=/home/abruenic/ngsRelate/:$PATH

# copy ref
cp /scratch/snyder/a/abruenic/Darwins_finches/ref.fa* .

# make bam.filelist
ls *.bam > bam.filelist

# make consensus - needed to make saf files
angsd -b bam.filelist -minMapQ 30 -minQ 20 -P 20 -setMinDepth 3 -doFasta 2 \
-doCounts 1 -out consensus

cat bam.filelist | while read -r LINE

do

# make *.saf files (per individual)
angsd -b ${LINE} -ref ref.fa -anc consensus.fa.gz -P 20 \
-minMapQ 30 -minQ 20 -GL 2 -doSaf 1 -doDepth 1 -doCounts 1 -out ${LINE}

done

cat bam.filelist | while read -r LINE

do

# create array for the bamfiles to make the pairwise 2SDS
oldIFS="$IFS"
IFS=$'\n' arr=($(<bam.filelist))
IFS="$oldIFS"
#echo "${arr[1]}"

# show contents of array
#echo "${arr[@]}"

# show length of array
#echo "${#arr[@]}"

files=$"${#arr[@]}"

if [ "$files" == 2 ]
# realSFS for each pair of individuals
realSFS ${arr[1]}.saf.idx ${arr[2]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[2]}.saf.idx.2dsfs
fi

if [ "$files" == 3 ]
# realSFS for each pair of individuals
realSFS ${arr[1]}.saf.idx ${arr[2]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[2]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[3]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[3]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[3]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[3]}.saf.idx.2dsfs
fi

if [ "$files" == 4 ]
# realSFS for each pair of individuals
realSFS ${arr[1]}.saf.idx ${arr[2]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[2]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[3]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[3]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[3]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[3]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[4]}.saf.idx.2dsfs
fi

if [ "$files" == 5 ]
# realSFS for each pair of individuals
realSFS ${arr[1]}.saf.idx ${arr[2]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[2]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[3]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[3]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[3]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[3]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[5]}.saf.idx.2dsfs
fi

if [ "$files" == 8 ]
# realSFS for each pair of individuals
realSFS ${arr[1]}.saf.idx ${arr[2]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[2]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[3]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[3]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[3]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[3]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[6]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[6]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[6]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[6]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[7]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[7]}${arr[8]}.saf.idx.2dsfs
fi

if [ "$files" == 10 ]
# realSFS for each pair of individuals
realSFS ${arr[1]}.saf.idx ${arr[2]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[2]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[3]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[3]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[3]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[3]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[6]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[6]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[6]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[6]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[6]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[6]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[6]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[6]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[7]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[7]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[7]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[7]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[7]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[7]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[8]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[8]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[8]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[8]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[9]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[9]}${arr[10]}.saf.idx.2dsfs
fi

if [ "$files" == 12 ]
# realSFS for each pair of individuals
realSFS ${arr[1]}.saf.idx ${arr[2]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[2]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[3]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[3]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[11]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[11]}.saf.idx.2dsfs
realSFS ${arr[1]}.saf.idx ${arr[12]}.saf.idx-P 20 -tole 1e-10 > ${arr[1]}${arr[12]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[3]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[3]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[11]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[11]}.saf.idx.2dsfs
realSFS ${arr[2]}.saf.idx ${arr[12]}.saf.idx-P 20 -tole 1e-10 > ${arr[2]}${arr[12]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[4]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[4]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[11]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[11]}.saf.idx.2dsfs
realSFS ${arr[3]}.saf.idx ${arr[12]}.saf.idx-P 20 -tole 1e-10 > ${arr[3]}${arr[12]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[5]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[5]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[11]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[11]}.saf.idx.2dsfs
realSFS ${arr[4]}.saf.idx ${arr[12]}.saf.idx-P 20 -tole 1e-10 > ${arr[4]}${arr[12]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[6]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[6]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[11]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[11]}.saf.idx.2dsfs
realSFS ${arr[5]}.saf.idx ${arr[12]}.saf.idx-P 20 -tole 1e-10 > ${arr[5]}${arr[12]}.saf.idx.2dsfs
realSFS ${arr[6]}.saf.idx ${arr[7]}.saf.idx-P 20 -tole 1e-10 > ${arr[6]}${arr[7]}.saf.idx.2dsfs
realSFS ${arr[6]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[6]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[6]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[6]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[6]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[6]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[6]}.saf.idx ${arr[11]}.saf.idx-P 20 -tole 1e-10 > ${arr[6]}${arr[11]}.saf.idx.2dsfs
realSFS ${arr[6]}.saf.idx ${arr[12]}.saf.idx-P 20 -tole 1e-10 > ${arr[6]}${arr[12]}.saf.idx.2dsfs
realSFS ${arr[7]}.saf.idx ${arr[8]}.saf.idx-P 20 -tole 1e-10 > ${arr[7]}${arr[8]}.saf.idx.2dsfs
realSFS ${arr[7]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[7]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[7]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[7]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[7]}.saf.idx ${arr[11]}.saf.idx-P 20 -tole 1e-10 > ${arr[7]}${arr[11]}.saf.idx.2dsfs
realSFS ${arr[7]}.saf.idx ${arr[12]}.saf.idx-P 20 -tole 1e-10 > ${arr[7]}${arr[12]}.saf.idx.2dsfs
realSFS ${arr[8]}.saf.idx ${arr[9]}.saf.idx-P 20 -tole 1e-10 > ${arr[8]}${arr[9]}.saf.idx.2dsfs
realSFS ${arr[8]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[8]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[8]}.saf.idx ${arr[11]}.saf.idx-P 20 -tole 1e-10 > ${arr[8]}${arr[11]}.saf.idx.2dsfs
realSFS ${arr[8]}.saf.idx ${arr[12]}.saf.idx-P 20 -tole 1e-10 > ${arr[8]}${arr[12]}.saf.idx.2dsfs
realSFS ${arr[9]}.saf.idx ${arr[10]}.saf.idx-P 20 -tole 1e-10 > ${arr[9]}${arr[10]}.saf.idx.2dsfs
realSFS ${arr[9]}.saf.idx ${arr[11]}.saf.idx-P 20 -tole 1e-10 > ${arr[9]}${arr[11]}.saf.idx.2dsfs
realSFS ${arr[9]}.saf.idx ${arr[12]}.saf.idx-P 20 -tole 1e-10 > ${arr[9]}${arr[12]}.saf.idx.2dsfs
realSFS ${arr[10]}.saf.idx ${arr[11]}.saf.idx-P 20 -tole 1e-10 > ${arr[10]}${arr[11]}.saf.idx.2dsfs
realSFS ${arr[10]}.saf.idx ${arr[12]}.saf.idx-P 20 -tole 1e-10 > ${arr[10]}${arr[12]}.saf.idx.2dsfs
realSFS ${arr[11]}.saf.idx ${arr[12]}.saf.idx-P 20 -tole 1e-10 > ${arr[11]}${arr[12]}.saf.idx.2dsfs
fi

# END
