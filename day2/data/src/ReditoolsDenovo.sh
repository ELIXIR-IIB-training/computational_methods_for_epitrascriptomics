#!/bin/bash
# genome from gencode
GENOME=/data/data_reditools/Epitranscriptome_course_2023/refs/GRCh37.primary_assembly.genome_chrs_4_14_19.fa
OUTPUTDIR=/home/instructor_1/SRR1319672_Denovo   # change to redirect output to your working area
BAM=/data/data_reditools/Epitranscriptome_course_2023/brain/SRR1319672_chrs_4gria2_14_19.bam
# launch REDItoolDenovo
python /data/data_reditools/Epitranscriptome_course_2023/src/REDItools/main/REDItoolDenovo.py \
    -i $BAM \
    -o $OUTPUTDIR \
    -f $GENOME \
    -t 3 \
    -c 5 \
    -m 255 \
    -v 1 \
    -q 30 \
    -e \
    -n 0.0 \
    -u
