#!/bin/sh

#PBS -N hom_ROH
#PBS -q fnrquail
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module load bioinfo

cd $PBS_O_WORKDIR

cat sample.txt | while read -r LINE

do

cd $LINE

FILE4x=${LINE}_4x.hom

if [ -f $FILE4x ]
then
    echo "$FILE4x_exist"
else
	echo "$FILE4x_doesnt_exist"
fi

FILE4x=${LINE}_8x.hom

if [ -f $FILE8x ]
then
    echo "$FILE8x_exist"
else
	echo "$FILE8x_doesnt_exist"
fi

FILE4x=${LINE}_12x.hom

if [ -f $FILE12x ]
then
    echo "$FILE12x_exist"
else
	echo "$FILE12x_doesnt_exist"
fi

FILE4x=${LINE}_16x.hom

if [ -f $FILE16x ]
then
    echo "$FILE16x_exist"
else
	echo "$FILE16x_doesnt_exist"
fi

cd ..

done

# END

