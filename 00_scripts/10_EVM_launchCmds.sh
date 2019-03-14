#!/usr/bin/env bash
#PBS -N launch_EVM
#PBS -o 98_log_files/log-launch_evm.out
#PBS -l walltime=00:30:00
#PBS -l mem=4g
#PBS -r n


cd $PBS_O_WORKDIR


# Prepare Augustus GFF to GFF3
cat 01_info_files/header_sbatch_evm.txt commands.txt >commands_jobs.sh


# Launch job
qsub commands_jobs.sh
