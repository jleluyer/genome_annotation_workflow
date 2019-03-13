#!/bin/bash
#PBS -N EVM
#PBS -o 98_log_files/log-EVM.out
#PBS -l walltime=12:00:00
#PBS -l mem=5g
#PBS -r n

cd $PBS_O_WORKDIR


GENOME="/home1/datawork/jleluyer/01_projects/genome_augustus/01_info_files/sspace.final.scaffolds.fasta"
WEIGHT="/home1/datawork/jleluyer/01_projects/genome_augustus/01_info_files/weight.txt"
OUTPUT="EVM_output.txt"
GENOME_NAME="sspace.final.scaffolds.fasta"

#Converter augustus gtf to gff3
#augustus_GTF_to_EVM_GFF3.pl

# Check .gff3 files
#gff3_gene_prediction_file_validator.pl transcript.test.gff3 >test.tr

#partition_EVM_inputs.pl --genome "$GENOME" \
#     --gene_predictions denovo.test.gff3 --protein_alignments homology.test.gff3 \
#     --transcript_alignments transcript.test.gff3 \
#     --segmentSize 100000 --overlapSize 10000 --partition_listing partitions_list.out


#write_EVM_commands.pl --genome "$GENOME" --weights "$WEIGHT" \
#      --gene_predictions denovo.test.gff3 --protein_alignments homology.test.gff3 \
#      --transcript_alignments transcript.test.gff3 \
#      --output_file_name "$OUTPUT" --partitions partitions_list.out >commands.list

# Prepare command list file
#sed -i 's#/home1/datahome/jleluyer/softwares/EVidenceModeler/EvmUtils/.././evidence_modeler.pl#/home1/datahome/jleluyer/softwares/EVidenceModeler/evidence_modeler.pl#g' commands.list 

# Launch raw jobs

#while read in; do echo $in >> list.done && perl $in; done < temp.cmds 

# combine evidence modeler
#~/softwares/EVidenceModeler/EvmUtils/recombine_EVM_partial_outputs.pl --partitions partitions_list.out --output_file_name EVM_output.txt

~/softwares/EVidenceModeler/EvmUtils/convert_EVM_outputs_to_GFF3.pl  --partitions partitions_list.out --output EVM_output.txt  --genome sspace.final.scaffolds.fasta
