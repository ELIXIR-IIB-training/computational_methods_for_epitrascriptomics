#!/bin/bash
reditable=/home/instructor_1/SRR1319672_filt_inv/DnaRna_785319920/outTable_785319920
RepeatMask=/data/data_reditools/Epitranscriptome_course_2023/refs/rmsk_sorted.gtf.gz
RefGene=/data/data_reditools/Epitranscriptome_course_2023/refs/refGene_sorted.gtf.gz
# launch AnnotateTable.py for RepeatMask
python /data/data_reditools/Epitranscriptome_course_2023/src/REDItools/accessory/AnnotateTable.py \
    -i $reditable \
    -a $RepeatMask \
    -u \
    -c1,2,3 \
    -n rmsk \
    -o ${reditable}_rmsk

# launch AnnotateTable.py for Refseq gene annotations
# instead of –u use –S if you want to correct strand by annotation
python /data/data_reditools/Epitranscriptome_course_2023/src/REDItools/accessory/AnnotateTable.py \
    -i ${reditable}_rmsk \
    -a $RefGene \
    -u \
    -c 2 \
    -n RefGene \
    -o ${reditable}_rmsk_Refgene
echo Computations finished.
