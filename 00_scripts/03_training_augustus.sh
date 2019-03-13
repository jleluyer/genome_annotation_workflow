#!/bin/bash
#PBS -N train_gb
#PBS -o log-train_gb.out
#PBS -l walltime=20:00:00
#PBS -l mem=100g
#PBS -r n

cd $PBS_O_WORKDIR

# train with genbank data

source activate Augus

#. /appli/bioinfo/augustus/3.3/env.sh

export AUGUSTUS_CONFIG_PATH="/home1/datahome/jleluyer/anaconda2/config/"

# Variables
RAW_GFF="GCF_000297895.1_oyster_v9_genomic.gff"
FOLDER="/home1/datawork/jleluyer/00_ressources/genomes/C_gigas"
INIT_FA="GCF_000297895.1_oyster_v9_genomic.fna"
CUR_GB_TRAIN="curated.cgigas.gb"
CUR_GFF="curated.cgigas.gff"
PMARG_FA="/home/datawork-rmpf/p_margaritifera/genome/annotation/01_reference/sspace.final.scaffolds.fasta"

#Prepare Gff curated
#cat "$FOLDER"/"$RAW_GFF" |awk '$3 == "gene"'|shuf -n 1500|awk -F ";" '{print $3}'|sed 's/Name=//g'|head -n 20 >list.curated.cgigas.txt

#chekc no verlap bedtools

#grep -f list.curated.cgigas.txt "$FOLDER"/"$RAW_GFF" >"$CUR_GFF"

#gff2gbSmallDNA.pl "$CUR_GFF" "$FOLDER"/"$INIT_FA" 1000 $CUR_GB_TRAIN

# Prepare new species
#new_species.pl --species=P_marg

#optimize_augustus.pl --species=P_marg "$CUR_GB_TRAIN"

etraining --species=P_marg $CUR_GB_TRAIN

# test august
augustus --hintsfile=hints.mrna.gff --species=P_marg "$PMARG_FA" >augustus.hints.test.gff

# First test of prediction
#augustus --species=oyster 02_data/sequence.gb.test | tee 05_prediction/firsttest.out # takes ~1m

# Test accuracy
#grep -A 22 Evaluation 05_prediction/firsttest.out >05_prediction/evaluation.step1

# Optimize metaparameters
#optimize_augustus.pl --species=oyster 02_data/sequence.gb.train

#Re-train with optimized parameters
#etraining --species=oyster 02_data/sequence.gb.train

#Validate parameters are better
#augustus --species=oyster 02_data/sequence.gb.test | tee 05_prediction/secondtest.out

# Validate accuracy second run
#grep -A 22 Evaluation 05_prediction/secondtest.out >05_prediction/evaluation.step2
