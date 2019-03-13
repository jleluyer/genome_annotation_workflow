#!/usr/bin/env bash
#PBS -N CombineGenblast
#PBS -o 98_log_files/log-combineGenblast.out
#PBS -l walltime=20:00:00
#PBS -l mem=40g
#PBS -r n


cd $PBS_O_WORKDIR


# Prepare Augustus GFF to GFF3
augustus_GTF_to_EVM_GFF3.pl 05_prediction/augustus.mrna.gff >05_prediction/augustus.mrna.gff3


# Check all gff3 files before running evm

for i in $(ls 05_prediction/*gff3)

do

base=$(basename "$i")

gff3_gene_prediction_file_validator.pl 05_predictions/"$i" >"$i".check

done
