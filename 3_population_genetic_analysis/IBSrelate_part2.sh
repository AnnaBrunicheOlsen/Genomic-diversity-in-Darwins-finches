#!/bin/sh

#PBS -N IBSrelate_part2
#PBS -q fnrwhale
#PBS -l nodes=1:ppn=5,naccesspolicy=singleuser
#PBS -l walltime=300:00:00
#PBS -m abe

module load bioinfo
module load gsl
module load zlib
module load gcc
module load samtools

cd $PBS_O_WORKDIR

export PATH=/home/abruenic/angsd/:$PATH
export PATH=/home/abruenic/angsd/misc/:$PATH
export PATH=/home/abruenic/ngsRelate/:$PATH


FILE1=$"Geospiza_fuliginosa_fulig12.bam"
FILE2=$"Geospiza_fuliginosa_fulig15.bam"
FILE3=$"SRR2917299"
FILE4=$"SRR2917300"
FILE5=$"SRR2917301"
FILE6=$"SRR2917302"
FILE7=$"SRR2917303"
FILE8=$"SRR2917304"
FILE9=$"SRR2917305"
FILE10=$"SRR2917306"
FILE11=$"SRR2917307"
FILE12=$"SRR2917308"


realSFS ${FILE1}.saf.idx ${FILE2}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE1}${FILE2}.saf.idx.2dsfs
realSFS ${FILE1}.saf.idx ${FILE3}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE1}${FILE3}.saf.idx.2dsfs
realSFS ${FILE1}.saf.idx ${FILE4}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE1}${FILE4}.saf.idx.2dsfs
realSFS ${FILE1}.saf.idx ${FILE5}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE1}${FILE5}.saf.idx.2dsfs
realSFS ${FILE1}.saf.idx ${FILE6}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE1}${FILE6}.saf.idx.2dsfs
realSFS ${FILE1}.saf.idx ${FILE7}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE1}${FILE7}.saf.idx.2dsfs
realSFS ${FILE1}.saf.idx ${FILE8}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE1}${FILE8}.saf.idx.2dsfs
realSFS ${FILE1}.saf.idx ${FILE9}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE1}${FILE9}.saf.idx.2dsfs
realSFS ${FILE1}.saf.idx ${FILE10}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE1}${FILE10}.saf.idx.2dsfs
realSFS ${FILE1}.saf.idx ${FILE11}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE1}${FILE11}.saf.idx.2dsfs
realSFS ${FILE1}.saf.idx ${FILE12}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE1}${FILE12}.saf.idx.2dsfs
realSFS ${FILE2}.saf.idx ${FILE3}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE2}${FILE3}.saf.idx.2dsfs
realSFS ${FILE2}.saf.idx ${FILE4}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE2}${FILE4}.saf.idx.2dsfs
realSFS ${FILE2}.saf.idx ${FILE5}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE2}${FILE5}.saf.idx.2dsfs
realSFS ${FILE2}.saf.idx ${FILE6}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE2}${FILE6}.saf.idx.2dsfs
realSFS ${FILE2}.saf.idx ${FILE7}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE2}${FILE7}.saf.idx.2dsfs
realSFS ${FILE2}.saf.idx ${FILE8}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE2}${FILE8}.saf.idx.2dsfs
realSFS ${FILE2}.saf.idx ${FILE9}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE2}${FILE9}.saf.idx.2dsfs
realSFS ${FILE2}.saf.idx ${FILE10}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE2}${FILE10}.saf.idx.2dsfs
realSFS ${FILE2}.saf.idx ${FILE11}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE2}${FILE11}.saf.idx.2dsfs
realSFS ${FILE2}.saf.idx ${FILE12}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE2}${FILE12}.saf.idx.2dsfs
realSFS ${FILE3}.saf.idx ${FILE4}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE3}${FILE4}.saf.idx.2dsfs
realSFS ${FILE3}.saf.idx ${FILE5}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE3}${FILE5}.saf.idx.2dsfs
realSFS ${FILE3}.saf.idx ${FILE6}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE3}${FILE6}.saf.idx.2dsfs
realSFS ${FILE3}.saf.idx ${FILE7}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE3}${FILE7}.saf.idx.2dsfs
realSFS ${FILE3}.saf.idx ${FILE8}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE3}${FILE8}.saf.idx.2dsfs
realSFS ${FILE3}.saf.idx ${FILE9}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE3}${FILE9}.saf.idx.2dsfs
realSFS ${FILE3}.saf.idx ${FILE10}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE3}${FILE10}.saf.idx.2dsfs
realSFS ${FILE3}.saf.idx ${FILE11}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE3}${FILE11}.saf.idx.2dsfs
realSFS ${FILE3}.saf.idx ${FILE12}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE3}${FILE12}.saf.idx.2dsfs
realSFS ${FILE4}.saf.idx ${FILE5}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE4}${FILE5}.saf.idx.2dsfs
realSFS ${FILE4}.saf.idx ${FILE6}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE4}${FILE6}.saf.idx.2dsfs
realSFS ${FILE4}.saf.idx ${FILE7}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE4}${FILE7}.saf.idx.2dsfs
realSFS ${FILE4}.saf.idx ${FILE8}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE4}${FILE8}.saf.idx.2dsfs
realSFS ${FILE4}.saf.idx ${FILE9}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE4}${FILE9}.saf.idx.2dsfs
realSFS ${FILE4}.saf.idx ${FILE10}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE4}${FILE10}.saf.idx.2dsfs
realSFS ${FILE4}.saf.idx ${FILE11}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE4}${FILE11}.saf.idx.2dsfs
realSFS ${FILE4}.saf.idx ${FILE12}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE4}${FILE12}.saf.idx.2dsfs
realSFS ${FILE5}.saf.idx ${FILE6}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE5}${FILE6}.saf.idx.2dsfs
realSFS ${FILE5}.saf.idx ${FILE7}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE5}${FILE7}.saf.idx.2dsfs
realSFS ${FILE5}.saf.idx ${FILE8}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE5}${FILE8}.saf.idx.2dsfs
realSFS ${FILE5}.saf.idx ${FILE9}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE5}${FILE9}.saf.idx.2dsfs
realSFS ${FILE5}.saf.idx ${FILE10}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE5}${FILE10}.saf.idx.2dsfs
realSFS ${FILE5}.saf.idx ${FILE11}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE5}${FILE11}.saf.idx.2dsfs
realSFS ${FILE5}.saf.idx ${FILE12}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE5}${FILE12}.saf.idx.2dsfs
realSFS ${FILE6}.saf.idx ${FILE7}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE6}${FILE7}.saf.idx.2dsfs
realSFS ${FILE6}.saf.idx ${FILE8}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE6}${FILE8}.saf.idx.2dsfs
realSFS ${FILE6}.saf.idx ${FILE9}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE6}${FILE9}.saf.idx.2dsfs
realSFS ${FILE6}.saf.idx ${FILE10}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE6}${FILE10}.saf.idx.2dsfs
realSFS ${FILE6}.saf.idx ${FILE11}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE6}${FILE11}.saf.idx.2dsfs
realSFS ${FILE6}.saf.idx ${FILE12}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE6}${FILE12}.saf.idx.2dsfs
realSFS ${FILE7}.saf.idx ${FILE8}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE7}${FILE8}.saf.idx.2dsfs
realSFS ${FILE7}.saf.idx ${FILE9}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE7}${FILE9}.saf.idx.2dsfs
realSFS ${FILE7}.saf.idx ${FILE10}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE7}${FILE10}.saf.idx.2dsfs
realSFS ${FILE7}.saf.idx ${FILE11}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE7}${FILE11}.saf.idx.2dsfs
realSFS ${FILE7}.saf.idx ${FILE12}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE7}${FILE12}.saf.idx.2dsfs
realSFS ${FILE8}.saf.idx ${FILE9}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE8}${FILE9}.saf.idx.2dsfs
realSFS ${FILE8}.saf.idx ${FILE10}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE8}${FILE10}.saf.idx.2dsfs
realSFS ${FILE8}.saf.idx ${FILE11}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE8}${FILE11}.saf.idx.2dsfs
realSFS ${FILE8}.saf.idx ${FILE12}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE8}${FILE12}.saf.idx.2dsfs
realSFS ${FILE9}.saf.idx ${FILE10}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE9}${FILE10}.saf.idx.2dsfs
realSFS ${FILE9}.saf.idx ${FILE11}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE9}${FILE11}.saf.idx.2dsfs
realSFS ${FILE9}.saf.idx ${FILE12}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE9}${FILE12}.saf.idx.2dsfs
realSFS ${FILE10}.saf.idx ${FILE11}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE10}${FILE11}.saf.idx.2dsfs
realSFS ${FILE10}.saf.idx ${FILE12}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE10}${FILE12}.saf.idx.2dsfs
realSFS ${FILE11}.saf.idx ${FILE12}.saf.idx -P 5 -tole 1e-10 -nSites 100000000 > ${FILE11}${FILE12}.saf.idx.2dsfs
