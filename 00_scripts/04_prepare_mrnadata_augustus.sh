#!/bin/bash
#PBS -N bam2wig
#PBS -o 98_log_files/log-prepmrna.out
#PBS -l walltime=10:00:00
#PBS -l mem=140g
#PBS -r n

cd $PBS_O_WORKDIR


# Conda module 
source activate Augus

# Mapping RNA-seq
# Data repsents 8 lib., including larva stages (Ld;LV;LU;LO), Female & Male gonades with ribo-0 lib. prep (T1_F; T2_M); whole juvenile (AN9) and mantle from adult (X8)

samtools merge 02_data/merge.bam \
	02_data/393_T1_F_2_RNAseq.paired.sorted.bam \
	02_data/864_T2_M_RNAseq.paired.sorted.bam \
	02_data/HI.4255.001.Index_5.AN9.sorted.bam \
	02_data/HI.4112.001.D708---D501.X8.sorted.bam \
	02_data/HI.4441.001.Index_20.J4-LD1.sorted.bam \
	02_data/HI.4441.001.Index_27.J8-LV-TL3.sorted.bam \
	02_data/HI.4441.001.Index_2.J13-LU-TL1.sorted.bam \
	02_data/HI.4441.001.Index_7.J22-LO-TL1b.sorted.bam		

# hints intron only
bam2hints --intronsonly --in=merge.bam --out=hints.intron.mrna.gff

bam2wig 02_data/merge.bam >04_temp_results/augustus.mrna.wig 

# Hints exon
cat 04_temp_results/augustus.mrna.wig|wig2hints.pl --width=40 --margin=20 --minthresh=0.4 --minscore=0.4 --radius=4.5 --pri=4 --strand="." > 04_temp_results/hints.ep.mrna.gff


# Combine hints
cat 04_temp_results/hints.intron.mrna.gff 04_temp_results/hints.ep.mrna.gff > 02_data/hints.mrna.gff


# Correct manual entries
sed -i -e 's/src=X/src=M/g' -e 's/src=E/src=M/g' 02_data/hints.mrna.gff




