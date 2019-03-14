#!/usr/bin/env bash
#PBS -N exonerate_gb
#PBS -o 98_log_files/log-exonerate.__REF__.out
#PBS -l walltime=20:00:00
#PBS -l mem=100g
#PBS -r n

cd $PBS_O_WORKDIR

# Global variables
REF=ref.pep
GENOME="01_info_files/sspace.final.scaffolds.fasta"
OUTPUTFOLDER="04_temp_results"


source activate EXNRT

exonerate --model protein2genome --refine region -q "$REF" -t "$GENOME" -Q protein -T dna --showtargetgff yes --showalignment no -D 80 --percent 30 >"$OUTPUTFOLDER"/exonerate.out


