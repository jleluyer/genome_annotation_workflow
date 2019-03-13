#!/usr/bin/env bash
#PBS -N seqtk
#PBS -o 98_log_files/log-getunit.out
#PBS -l walltime=20:00:00
#PBS -l mem=40g
#PBS -r n


cd $PBS_O_WORKDIR

UNIREF50="/home/ref-bioinfo/beedeem/p/Uniprot_Uniref50/current/Uniprot_Uniref50/uniref50.fasta"

# split Uniref50 in 1000 entries files

split -l 1000 01_info_files/list.uniref50.eukaryote.txt


# Retrieve sequences fasta


. /appli/bioinfo/seqtk/latest/env.sh


for i in  $(ls x*|grep -v ".fa")

do 

seqtk subseq $UNIREF50 $i >"$i".fa

done
