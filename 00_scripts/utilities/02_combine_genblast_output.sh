#!/usr/bin/env bash
#PBS -N CombineGenblast
#PBS -o 98_log_files/log-combineGenblast.out
#PBS -l walltime=20:00:00
#PBS -l mem=40g
#PBS -r n


cd $PBS_O_WORKDIR

INPUTDOLDER="04_temp_results"
OUTPUTFOLDER="05_predictions"

# combine files
cat "$INPUTFOLDER"/output.genblast*gff |grep -v "##sequence" > "$OUTPUTFOLDER"/homology.genblast.gff

# Clean up
rm x*
