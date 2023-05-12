#!/bin/bash
# genome from gencode
GENOME=/data/data_reditools/Epitranscriptome_course_2023/refs/GRCh37.primary_assembly.genome_chrs_4_14_19.fa

BAM=/data/data_reditools/Epitranscriptome_course_2023/brain/SRR1319672_chrs_4gria2_14_19.bam
OUTPUTDIR=/home/instructor_1/SRR1319672_filt_inv
# -j for DNA seq data or other experiments 
# -R to filter invariant positions
python /data/data_reditools/Epitranscriptome_course_2023/src/REDItools/main/REDItoolDnaRna.py \
    -o $OUTPUTDIR \
    -i $BAM \
    -f $GENOME \
    -t 4 \
    -c 1,1 \
    -m 30,255 \
    -v 1 \
    -q 30,30 \
    -e \
    -n 0.0 \
    -N 0.0 \
    -u \
    -l \
    -p \
    -R
