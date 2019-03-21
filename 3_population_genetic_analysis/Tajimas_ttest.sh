#!/bin/sh

#PBS -N tajimaResults
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=1:00:00
#PBS -m abe

module purge
module load bioinfo
module load r

cd $PBS_O_WORKDIR

cat populations_2missing.txt | while read -r LINE

do

cd $LINE

# remove # from first line 
sed -i -e 's/#//g' theta.thetasWindow_nooverlap.gz.pestPG

Rscript /scratch/snyder/a/abruenic/Darwins_finches/Tajimas_D.R

echo $LINE

echo "tajimasD"
D=$(sed -n '11p' Tajima_results_nonoverlap.txt)
echo $D
# print results to file
Tajima=$(sed -n '6p' Tajima_results_nonoverlap.txt)
if [[ $Tajima == "alternative hypothesis: true mean is not equal to 0" ]];
then	
	echo "true mean not equal to 0"
else
	echo "true mean equal to 0"
fi

echo "FuF"
F=$(sed -n '23p' Tajima_results_nonoverlap.txt)
echo $F
FuF=$(sed -n '18p' Tajima_results_nonoverlap.txt)
if [[ $Tajima == "alternative hypothesis: true mean is not equal to 0" ]];
then	
	echo "true mean not equal to 0"
else
	echo "true mean equal to 0"
fi

echo "FuD"
fD=$(sed -n '35p' Tajima_results_nonoverlap.txt)
echo $fD
FuD=$(sed -n '30p' Tajima_results_nonoverlap.txt)
if [[ $Tajima == "alternative hypothesis: true mean is not equal to 0" ]];
then	
	echo "true mean not equal to 0"
else
	echo "true mean equal to 0"
fi

cd ..

done

#END
