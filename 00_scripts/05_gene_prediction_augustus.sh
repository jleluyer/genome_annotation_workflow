#!/bin/bash
#PBS -N Augus_genePred
#PBS -o 98_log_files/log-august.pred.out
#PBS -l walltime=10:00:00
#PBS -l mem=140g
#PBS -r n

cd $PBS_O_WORKDIR



# Variables
GENOME="01_info_files/sspace.final.scaffolds.fasta"
OUTPUTFOLDER="05_prediction"
TMP="04_temp_results"

# Mapping RNA-seq
# Merging bam files
# Prepare hints
# train augustus

#Load module
source activate Augus

# Predict using hints 

augustus --hintsfile=02_data/hints.mrna.gff --species=P_marg $GENOME > "$TMP"/augustus.mrna.out

# Compile results
grep "AUGUSTUS" "$TMP"/augustus.mrna.out > "$OUTPUTFOLDER"/augustus.mrna.gff
