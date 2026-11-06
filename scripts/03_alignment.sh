#!/usr/bin/env bash
set -euo pipefail

# Définition des répertoires
REF_DIR="data/reference"
TRIM_DIR="data/trimmed"
ALIGN_DIR="results/aligned"
THREADS=4

mkdir -p "$ALIGN_DIR"

# Recherche automatique du fichier FASTA de référence
REF_FASTA=$(find "$REF_DIR" -maxdepth 1 \( -name "*.fa" -o -name "*.fasta" \) | head -n 1)

if [[ -z "$REF_FASTA" ]]; then
    echo "ERREUR : Aucun fichier FASTA (.fa ou .fasta) trouvé dans $REF_DIR"
    exit 1
fi

echo "=== [03] Référence détectée : $REF_FASTA ==="

# Indexation BWA (uniquement si l'index .bwt n'existe pas encore)
if [[ ! -f "${REF_FASTA}.bwt" ]]; then
    echo "Indexation du génome de référence avec BWA..."
    bwa index "$REF_FASTA"
else
    echo "Index BWA déjà présent, étape ignorée."
fi

# Alignement avec BWA-MEM
for R1 in "$TRIM_DIR"/*_R1.trimmed.fastq.gz; do
    SAMPLE=$(basename "$R1" _R1.trimmed.fastq.gz)
    R2="$TRIM_DIR/${SAMPLE}_R2.trimmed.fastq.gz"
    SAM_OUT="$ALIGN_DIR/${SAMPLE}.sam"

    echo "Alignement de l'échantillon : $SAMPLE"
    if [[ -f "$R2" ]]; then
        bwa mem -t "$THREADS" -R "@RG\tID:${SAMPLE}\tSM:${SAMPLE}\tPL:ILLUMINA" \
            "$REF_FASTA" "$R1" "$R2" > "$SAM_OUT"
    else
        bwa mem -t "$THREADS" -R "@RG\tID:${SAMPLE}\tSM:${SAMPLE}\tPL:ILLUMINA" \
            "$REF_FASTA" "$R1" > "$SAM_OUT"
    fi
done

echo "=== [03] Alignement terminé ! Fichiers SAM générés dans : $ALIGN_DIR ==="
