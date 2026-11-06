#!/usr/bin/env bash
set -euo pipefail

# Définition des répertoires
RAW_DIR="data/raw"
TRIM_DIR="data/trimmed"
QC_TRIM_OUT="results/qc_reports/trimmed"
THREADS=4

mkdir -p "$TRIM_DIR" "$QC_TRIM_OUT"

echo "=== [02] Démarrage du rognage des adaptateurs et filtrage qualité (fastp) ==="

# Boucle sur les fichiers Paired-End (*_R1.fastq.gz et *_R2.fastq.gz)
for R1 in "$RAW_DIR"/*_R1.fastq.gz; do
    SAMPLE=$(basename "$R1" _R1.fastq.gz)
    R2="$RAW_DIR/${SAMPLE}_R2.fastq.gz"

    if [[ -f "$R2" ]]; then
        echo "Traitement de l'échantillon Paired-End : $SAMPLE"
        fastp \
            -i "$R1" -I "$R2" \
            -o "$TRIM_DIR/${SAMPLE}_R1.trimmed.fastq.gz" \
            -O "$TRIM_DIR/${SAMPLE}_R2.trimmed.fastq.gz" \
            --detect_adapter_for_pe \
            --qualified_quality_phred 20 \
            --length_required 35 \
            --thread "$THREADS" \
            --html "$QC_TRIM_OUT/${SAMPLE}_fastp.html" \
            --json "$QC_TRIM_OUT/${SAMPLE}_fastp.json"
    else
        echo "Traitement de l'échantillon Single-End : $SAMPLE"
        fastp \
            -i "$R1" \
            -o "$TRIM_DIR/${SAMPLE}_R1.trimmed.fastq.gz" \
            --qualified_quality_phred 20 \
            --length_required 35 \
            --thread "$THREADS" \
            --html "$QC_TRIM_OUT/${SAMPLE}_fastp.html" \
            --json "$QC_TRIM_OUT/${SAMPLE}_fastp.json"
    fi
done

# Agrégation MultiQC post-trimming
multiqc "$QC_TRIM_OUT" -o "$QC_TRIM_OUT" -n "multiqc_trimmed_report.html" --force

echo "=== [02] Terminé ! Fichiers nettoyés dans : $TRIM_DIR ==="
