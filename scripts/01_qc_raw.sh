#!/usr/bin/env bash
set -euo pipefail

# Définition des répertoires
RAW_DIR="data/raw"
QC_OUT="results/qc_reports/raw"
THREADS=4

mkdir -p "$QC_OUT"

echo "=== [01] Démarrage du contrôle qualité sur les données brutes ==="

# Exécution de FastQC
fastqc -t "$THREADS" -o "$QC_OUT" "$RAW_DIR"/*.fastq.gz

# Agrégation avec MultiQC
multiqc "$QC_OUT" -o "$QC_OUT" -n "multiqc_raw_report.html" --force

echo "=== [01] Terminé ! Rapports disponibles dans : $QC_OUT ==="
