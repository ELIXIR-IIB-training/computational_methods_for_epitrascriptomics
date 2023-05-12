#!/bin/bash
BAM=/data/data_reditools/Epitranscriptome_course_2023/brain/SRR1311771_chrs_4gria2_14_19.bam
REFSEQ=/data/data_reditools/Epitranscriptome_course_2023/refs/hg19_RefSeq.bed
# launch command
infer_experiment.py -i $BAM -r $REFSEQ