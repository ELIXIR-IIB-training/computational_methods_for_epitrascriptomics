#!/bin/bash
reditable=/home/instructor_1/SRR1319672_filt_inv/DnaRna_785319920/outTable_785319920
# launch selectPositions.py to decrease the number of sites to annotate and to eliminate invariant sites
python /home/instructor_1/data_reditools/Epitranscriptome_course_2023/src/REDItools/accessory/selectPositions.py \
    -i $reditable \
    -d -1 \
    -c 3 \
    -v 1 \
    -s AG,TC \
    -r \
    -o ${reditable}_SelPos