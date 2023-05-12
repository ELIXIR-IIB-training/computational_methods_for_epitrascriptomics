#!/bin/bash
reditable=/home/instructor_1/SRR1319672_filt_inv/DnaRna_785319920/outTable_785319920
SNP=/data/data_reditools/Epitranscriptome_course_2023/refs/snp151Common.sorted.gtf.gz
noSNPoutput=${reditable}_noSNPs
SNPoutput=${reditable}_SNPs

# launch FilterTable.py script to retrieve noSNPs sites
python /data/data_reditools/Epitranscriptome_course_2023/src/REDItools/accessory/FilterTable.py \
    -i $reditable \
    -s $SNP \
    -S snp \
    -o $noSNPoutput \
    -E \
    -p

# launch FilterTable.py script to retrieve SNPs sites (-f instead of -s)
python /data/data_reditools/Epitranscriptome_course_2023/src/REDItools/accessory/FilterTable.py \
    -i $reditable \
    -f $SNP \
    -F snp \
    -o $SNPoutput \
    -E \
    -p
