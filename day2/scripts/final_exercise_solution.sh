#!/bin/bash
shopt -s expand_aliases

source $HOME/.aliases.sh

DATA="$HOME/data/exercise_dataset"
SAMPLES="WT_1 WT_2 KD_1 KD_2"

# Basecall the data
for sample in $SAMPLES; do
  guppy_basecaller -i $DATA/${sample} -s ${sample}/guppy \
    --config rna_r9.4.1_70bps_fast.cfg \
    --recursive \
    --num_callers 2 \
    --disable_pings \
    --qscore_filtering
done

# Convert the Ensembl GTF to BED
bedparse gtf2bed \
  ~/data/Homo_sapiens.GRCh38.102.chr.gtf \
  > reference_transcriptome.bed

# Generate a Fasta from the GTF
bedtools getfasta \
  -fi ~/data/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
  -s \
  -split \
  -name \
  -bed reference_transcriptome.bed \
  > Homo_sapiens.GRCh38.98_transcriptome.fa

# Generate a fasta index
samtools faidx Homo_sapiens.GRCh38.98_transcriptome.fa

# Map the reads and filter the alignments
for sample in $SAMPLES; do
  cat ${sample}/guppy/pass/*fastq > ${sample}/basecalled.fastq
  minimap2 -t 2 -a -x map-ont -k14 --for-only \
    Homo_sapiens.GRCh38.98_transcriptome.fa \
    ${sample}/basecalled.fastq \
    > ${sample}/mapped_reads.sam

  samtools view -b -F 2308 ${sample}/mapped_reads.sam |samtools sort > ${sample}/mapped_reads_filtered.bam
  samtools index ${sample}/mapped_reads_filtered.bam
done

# Nanopolish the reads
for sample in $SAMPLES; do
  nanopolish index \
    -d $DATA/${sample} \
    -s ${sample}/guppy/sequencing_summary.txt \
    ${sample}/basecalled.fastq
  
  nanopolish eventalign \
    --scale-events --print-read-names --samples --signal-index \
    --reads ${sample}/basecalled.fastq \
    --bam ${sample}/mapped_reads_filtered.bam \
    --genome Homo_sapiens.GRCh38.98_transcriptome.fa > ${sample}/eventalign.txt
done

# Run eventalign collapse
for sample in $SAMPLES; do
  nanocompore eventalign_collapse -i ${sample}/eventalign.txt --outpath ${sample}/eventalign_collapse
done

# Run nanocompore
nanocompore sampcomp \
     --file_list1 WT_1/eventalign_collapse/out_eventalign_collapse.tsv,WT_2/eventalign_collapse/out_eventalign_collapse.tsv \
     --file_list2 KD_1/eventalign_collapse/out_eventalign_collapse.tsv,KD_2/eventalign_collapse/out_eventalign_collapse.tsv \
     --label1 WT \
     --label2 KD \
     --fasta Homo_sapiens.GRCh38.98_transcriptome.fa \
     --outpath nanocompore \
     --sequence_context 2 \
     --allow_warnings \
     --pvalue_thr 0.01 \
     --min_coverage 30 \
     --logit \
     --nthreads 3
