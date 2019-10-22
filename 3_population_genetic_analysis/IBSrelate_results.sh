#!/bin/sh

#PBS -N download
#PBS -q fnrsnake
#PBS -l nodes=1:ppn=1,naccesspolicy=singleuser
#PBS -l walltime=300:00:00
#PBS -m abe

cd $PBS_O_WORKDIR



#END