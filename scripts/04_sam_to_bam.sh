#!/usr/bin/env bash
set -euo pipefail

ALIGN_DIR="results/aligned"
THREADS=4

echo "=== [04] Conversion SAM -> BAM, tri, indexation et statistiques ==="

for SAM_FILE in "$ALIGN_DIR"/*.sam; do
    SAMPLE=$(basename "$SAM_FILE" .sam)
    BAM_SORTED="$ALIGN_DIR/${SAMPLE}.sorted.bam"

    echo "Traitement SAMtools pour : $SAMPLE"

    # Conversion en BAM et tri par coordonnées
    samtools view -@ "$THREADS" -bS "$SAM_FILE" | \
        samtools sort -@ "$THREADS" -o "$BAM_SORTED"

    # Indexation du fichier BAM trié (.bai)
    samtools index -@ "$THREADS" "$BAM_SORTED"

    # Extraction des statistiques d'alignement (pour le script R)
    samtools flagstat "$BAM_SORTED" > "$ALIGN_DIR/${SAMPLE}.flagstat.txt"

    # Extraction de la profondeur de couverture par position (pour le script R)
    samtools depth -a "$BAM_SORTED" > "$ALIGN_DIR/${SAMPLE}.depth.txt"

    # Suppression du fichier SAM brut pour économiser l'espace disque
    rm -f "$SAM_FILE"
done

echo "=== [04] Terminé ! Fichiers BAM triés/indexés et métriques dans : $ALIGN_DIR ==="
