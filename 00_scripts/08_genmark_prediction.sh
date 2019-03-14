#!/usr/bin/env bash
#PBS -N genmark
#PBS -o log-genmark.out
#PBS -l walltime=24:00:00
#PBS -l mem=100g
#PBS -r n


# Global variables
GENOME="sspace.final.scaffolds.fasta"


~/softwares/gm_et_linux_64/gmes_petap/gmes_petap.pl --prediction --max_gap 1000 --sequence "$GENOME"
