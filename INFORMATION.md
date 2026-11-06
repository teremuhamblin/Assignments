# 🧬 BMEG 400E / BMEG 424 — Genome Informatics

Pipeline bioinformatique reproductible développé dans le cadre du cours **BMEG 400E / 424 (UBC)**. Il automatise le traitement complet de données de séquençage NGS : contrôle qualité, rognage, alignement, post-traitement BAM et analyse statistique.

---

## ⚡ Démarrage rapide

```bash
# 1. Cloner le dépôt et activer l'environnement Conda
git clone https://github.com<VOTRE_COMPTE>/bmeg400E-Genome424.git
cd bmeg400E-Genome424
conda env create -f environment.yml && conda activate bmeg400e-env

# 2. Rendre les scripts exécutables
chmod +x scripts/*.sh scripts/*.R

# 3. Exécuter le pipeline complet (depuis la racine)
bash scripts/01_qc_raw.sh && \
bash scripts/02_trimming.sh && \
bash scripts/03_alignment.sh && \
bash scripts/04_sam_to_bam.sh && \
Rscript scripts/05_analysis.R
```

---

## 📂 Architecture du dépôt

```text
bmeg400E-Genome424/
├── README.md                  # Documentation principale
├── environment.yml            # Dépendances logicielles (Conda)
├── data/                      # Données (ignorées par Git)
│   ├── raw/                   # Entrée : fichiers *_R1.fastq.gz / *_R2.fastq.gz
│   ├── trimmed/               # Intermédiaire : lectures filtrées
│   └── reference/             # Entrée : génome de référence (.fa / .fasta)
├── scripts/                   # Pipeline modulaire (voir scripts/README.md)
│   ├── 01_qc_raw.sh           # FastQC + MultiQC (données brutes)
│   ├── 02_trimming.sh         # fastp + MultiQC (Q≥20, L≥35 pb)
│   ├── 03_alignment.sh        # Indexation et alignement BWA-MEM
│   ├── 04_sam_to_bam.sh       # Conversion, tri, indexation (.bai) et métriques
│   └── 05_analysis.R          # Statistiques et figures (ggplot2)
├── results/                   # Sorties générées
│   ├── qc_reports/            # Rapports HTML MultiQC / fastp
│   ├── aligned/               # Fichiers .sorted.bam et résumés .csv
│   └── figures/               # Graphiques haute résolution (.pdf / .png)
└── reports/
    └── assignment1_report.pdf # Rapport final du devoir
```

---

## 📋 Données requises avant exécution

| Dossier | Fichiers attendus | Format / Convention |
| :--- | :--- | :--- |
| `data/raw/` | Lectures de séquençage | `<ECHANTILLON>_R1.fastq.gz` (et `_R2.fastq.gz` si Paired-End) |
| `data/reference/` | Génome de référence | Un fichier `.fa` ou `.fasta` |

---

## 📊 Résultats générés

* **Qualité :** `results/qc_reports/raw/multiqc_raw_report.html` et `results/qc_reports/trimmed/multiqc_trimmed_report.html`
* **Alignements :** `results/aligned/*.sorted.bam` (+ index `.bai`)
* **Métriques CSV :** `results/aligned/alignment_summary.csv` et `results/aligned/coverage_summary.csv`
* **Figures :** `results/figures/01_mapping_rate.png` et `02_coverage_distribution.png`
