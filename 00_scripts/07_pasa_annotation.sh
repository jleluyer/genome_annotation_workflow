#!/bin/bash
#PBS -N pasa
#PBS -o 98_log_files/log-pasa.out
#PBS -l walltime=20:00:00
#PBS -l mem=40g
#PBS -q omp
#PBS -l ncpus=16
#PBS -r n

cd $PBS_O_WORKDIR

# Variables
TRANSCRIPTOME="02_data/transcriptome.final.fa"
UNIVEC="/home1/datawork/jleluyer/00_ressources/univec/univec.fasta"
GENOME="01_info_files/sspace.final.scaffolds.fasta"
FULLCDNA="01_info_files/full_length_acc.txt"
NCPU=8
CONFIGFILE="01_info_files/alignAssembly.config"
TRANSCRIPTOMECLN="02_data/transcriptome.final.fa.clean"

# cLean trancriptome sequences
#seqclean $TRANSCRIPTOME -v $UNIVEC -c 8

source activate PASA

# annotate genome
~/anaconda2/envs/PASA/opt/pasa-2.3.3/Launch_PASA_pipeline.pl -c $CONFIGFILE -C -R \
	-g $GENOME -f $FULLCDNA -t $TRANSCRIPTOMECLN -T -u $TRANSCRIPTOME --ALIGNERS gmap,blat --CPU $NCPU

