#!/bin/bash
#PBS -N train_gb
#PBS -o log-train_gb.out
#PBS -l walltime=20:00:00
#PBS -l mem=100g
#PBS -r n

cd $PBS_O_WORKDIR

source activate Augus

export AUGUSTUS_CONFIG_PATH="~/anaconda2/config/"

# Variables
RAW_GFF="GCF_000297895.1_oyster_v9_genomic.gff"
FOLDER="~/00_ressources/genomes/C_gigas"
INIT_FA="GCF_000297895.1_oyster_v9_genomic.fna"
CUR_GB_TRAIN="curated.cgigas.gb"
CUR_GFF="curated.cgigas.gff"

#Prepare Gff curated
cat "$FOLDER"/"$RAW_GFF" |awk '$3 == "gene"'|shuf -n 1500|awk -F ";" '{print $3}'|sed 's/Name=//g'|head -n 500 >list.curated.cgigas.txt

#check no overlap bedtools (to add)

grep -f list.curated.cgigas.txt "$FOLDER"/"$RAW_GFF" >"$CUR_GFF"

gff2gbSmallDNA.pl "$CUR_GFF" "$FOLDER"/"$INIT_FA" 1000 $CUR_GB_TRAIN

# Prepare new species
new_species.pl --species=P_marg

optimize_augustus.pl --species=P_marg "$CUR_GB_TRAIN"

etraining --species=P_marg $CUR_GB_TRAIN

# First test of prediction
augustus --species=P_marg 04_temp_results/sequence.gb.test | tee 04_temp_results/firsttest.out # takes ~1m

# Test accuracy
grep -A 22 Evaluation 04_temp_results/firsttest.out >04_temp_results/evaluation.step1

# Optimize metaparameters
optimize_augustus.pl --species=P_marg "$CUR_GB_TRAIN"

#Re-train with optimized parameters
#etraining --species=P_marg "$CUR_GB_TRAIN"

#Validate parameters are better
augustus --species=P_marg 04_temp_results/sequence.gb.test | tee 04_temp_results/secondtest.out # takes ~1m

# Validate accuracy second run
grep -A 22 Evaluation 04_temp_results/secondtest.out >04_temp_results/evaluation.step2
