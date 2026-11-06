# Scripts du Pipeline (`scripts/`)

Ce dossier contient les scripts d'analyse bioinformatique du projet **BMEG 400E / 424 (Devoir 1)**. Ils s'exécutent séquentiellement depuis la **racine du projet** (`bmeg400e-assignment1/`).

## Vue d'ensemble des scripts

| Script | Outil(s) | Rôle principal | Entrées | Sorties principales |
| :--- | :--- | :--- | :--- | :--- |
| **`01_qc_raw.sh`** | FastQC, MultiQC | Contrôle qualité des lectures brutes | `data/raw/*.fastq.gz` | `results/qc_reports/raw/` |
| **`02_trimming.sh`** | fastp, MultiQC | Suppression des adaptateurs et filtrage (`Q≥20`, `L≥35`) | `data/raw/*.fastq.gz` | `data/trimmed/` & `results/qc_reports/trimmed/` |
| **`03_alignment.sh`** | BWA-MEM | Indexation de la référence et alignement des lectures | `data/trimmed/` & `data/reference/` | `results/aligned/*.sam` |
| **`04_sam_to_bam.sh`** | SAMtools | Conversion BAM, tri, indexation (`.bai`) et métriques | `results/aligned/*.sam` | `*.sorted.bam`, `*.flagstat.txt`, `*.depth.txt` |
| **`05_analysis.R`** | R (`ggplot2`, `dplyr`) | Statistiques descriptives et génération de graphiques | `*.flagstat.txt` & `*.depth.txt` | `*.csv` & `results/figures/` (PDF/PNG) |

## Exécution rapide

```bash
# Donner les droits d'exécution (une seule fois)
chmod +x scripts/*.sh scripts/*.R

# Lancer les étapes dans l'ordre depuis la racine du projet
bash scripts/01_qc_raw.sh
bash scripts/02_trimming.sh
bash scripts/03_alignment.sh
bash scripts/04_sam_to_bam.sh
Rscript scripts/05_analysis.R
```

> **Note :** Les scripts Bash utilisent **4 threads** par défaut (`THREADS=4`) et gèrent automatiquement les données *Paired-End* (`_R1`/`_R2`) et *Single-End*.
