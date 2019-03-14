#!/bin/bash
#PBS -N EVM
#PBS -o 98_log_files/log-icombine_EVM.out
#PBS -l walltime=12:00:00
#PBS -l mem=5g
#PBS -r n

cd $PBS_O_WORKDIR


GENOME="1_info_files/sspace.final.scaffolds.fasta"
WEIGHT="01_info_files/weight.txt"
OUTPUT="EVM_output.txt"
GENOME_NAME="sspace.final.scaffolds.fasta"


# combine evidence modeler
~/softwares/EVidenceModeler/EvmUtils/recombine_EVM_partial_outputs.pl --partitions partitions_list.out --output_file_name "$OUTPUT"

~/softwares/EVidenceModeler/EvmUtils/convert_EVM_outputs_to_GFF3.pl  --partitions partitions_list.out --output "$OUTPUT" --genome "$GENOMENAME"
