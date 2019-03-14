#!/bin/bash
#PBS -N pasa
#PBS -o 98_log_files/log-pasa.out
#PBS -l walltime=20:00:00
#PBS -l mem=40g
#PBS -q omp
#PBS -l ncpus=8
#PBS -r n

cd $PBS_O_WORKDIR

# Variables
TRANSCRIPTOME="transcriptome.final.fa"
UNIVEC="/home1/datawork/jleluyer/00_ressources/univec/univec.fasta"
GENOME="01_info_files/sspace.final.scaffolds.fasta"
SEQOUT="04_temp_results/transcriptome.univecclean.fa"
FULLCDNA="01_info_files/full_length_acc.txt"
NCPU=8
CONFIGFILE=""

# cLean trancriptome sequences
#seqclean $TRANSCRIPTOME -v $UNIVEC -o "$SEQOUT" -c 8

source activate PASA

# Annotate with gmap and blat
Launch_PASA_pipeline.pl \
           -c $CONFIGFILE -C -R -g $GENOME \
           -t $SEQOUT -T -u $TRANSCRIPTOME \
           -f $FULLCDNA --ALIGNERS blat,gmap --CPU $NCPU

