###### Modèle complet et professionnel structuré selon les standards des dépôts bio-informatiques (*GitHub/GitLab*) pour ce type de devoir (*contrôle qualité, alignement de lectures NGS et analyse sous Bash / R*)

---

###### README.md >> markdown
# bmeg400E-Genome424
- Genomes Informatiques
- Assignment 1
》》 **Pipeline d'analyse bio-informatique et computationnelle de données NGS**

[![Language: Bash](https://img.shields.io/badge/Language-bash-FF0000.svg)](https://www.gnu.org/software/bash/)
[![Language: Rmed](https://img.shields.io/badge/Language-Rmed-FF0000.svg)](https://www.r-project.org/)
[![Conda](https://img.shields.io/badge/Environment-Conda-FF0000.svg)](https://docs.conda.io/)

---

### 📖 Description du projet

Ce dépôt contient l'ensemble des scripts, analyses et visualisations réalisés dans le cadre du **Devoir 1 (Assignment 1)** du cours **BMEG 400E (Genome Informatiques)**.

L'objectif de ce projet est de concevoir un pipeline computationnel reproductible permettant :
```text
》》 1. L'évaluation de la qualité de données brutes de séquençage à haut débit (NGS).
》》 2. Le pré-traitement et filtrage des lectures (*reads*).
》》 3. L'alignement (*mapping*) des lectures sur un génome de référence.
》》 4. L'évaluation statistique de l'alignement (taux de couverture, mappabilité, métriques SAM/BAM).
```

---
---

### 📁 Structure du répertoire

```text
bmeg400e-assignment1/
│
├── README.md                   # Documentation générale du projet
├── environment.yml             # Environnement Conda avec les dépendances
│
├── data/                       # Données (exclues du suivi Git via .gitignore)
│   ├── raw/                    # Fichiers FASTQ bruts
│   └── reference/              # Génome de référence (FASTA) et index
│
├── scripts/                    # Scripts d'analyse
│   ├── 01_qc_raw.sh            # Contrôle qualité initial (FastQC / MultiQC)
│   ├── 02_trimming.sh         # Rognage des adaptateurs et filtrage qualité
│   ├── 03_alignment.sh        # Indexation et alignement (BWA / Bowtie2)
│   ├── 04_sam_to_bam.sh       # Conversion, tri, indexation (SAMtools)
│   └── 05_analysis.R          # Analyses statistiques et visualisations en R
│
├── results/                    # Sorties du pipeline
│   ├── qc_reports/             # Rapports HTML FastQC / MultiQC
│   ├── aligned/                # Fichiers BAM triés et indexés
│   └── figures/                # Graphiques générés (PDF/PNG)
│
└── reports/
    └── assignment1_report.pdf  # Rapport final / Réponses aux questions
```

### ⚙️ Prérequis et Dépendances
>*Logiciels bio-informatiques*
- 》》 **FastQC (v0.11.9+)** : Contrôle qualité des séquences brutes.

- 》》 **MultiQC (v1.14+)** : Agrégation des rapports de qualité.

- 》》 **Trimmomatic ou fastp** : Filtrage et rognage des lectures.

- 》》 **BWA-MEM ou Bowtie2** : Aligneur sur génome de référence.

- 》》 **SAMtools (v1.16+)** : Manipulation des fichiers SAM/BAM.

- 》》 **Bedtools** : Analyse des intervalles génomiques et couverture.

- 》》 **Environnement R**
   - **R >= 4.2.0**

- 》》 **Bibliothèques** : tidyverse, ggplot2, GenomicRanges, Rsamtools.

### 🚀 Installation & Exécution
1. **Cloner le dépôt et configurer l'environnement**
```bash
git clone https://github.com/votre-nom-utilisateur/bmeg400e-assignment1.git
cd bmeg400e-assignment1
```

###### Créer et activer
1. **L'environnement Conda**
```conda
conda env create -f environment.yml
conda activate bmeg400e-env
```

2. **Téléchargement des données**
- Déposez les données de séquençage brutes dans le répertoire dédié :
```bash
# Exemple pour des lectures FASTQ appariées (paired-end)
mkdir -p data/raw data/reference
# (Télécharger vos fichiers FASTQ dans data/raw/)
```

3. **Exécution étape par étape du pipeline**
- Étape 1 : Contrôle qualité initial (QC)
```bash
bash scripts/01_qc_raw.sh
# Génère les rapports dans results/qc_reports/
```

- Étape 2 : Nettoyage et rognage des lectures
```bash
bash scripts/02_trimming.sh
```

- Étape 3 : Indexation et alignement sur le génome de référence
```bash
bash scripts/03_alignment.sh
```

- Étape 4 : Traitement des fichiers SAM / BAM
```bash
bash scripts/04_sam_to_bam.sh
```
###### Cette étape convertit le fichier SAM en BAM, trie par coordonnées génomiques, supprime/marque les doublons de PCR et indexe le fichier final (.bam.bai).

- Étape 5 : Analyse computationnelle et visualisations
```bash
Rscript scripts/05_analysis.R
```

---
---

#### 📊 Principaux résultats attendus
>Taux d'alignement (Mapping Rate) :
- *pourcentage de lectures alignées avec succès sur le génome hôte*.

>Distribution des scores Phred :
- *Évolution de la qualité par base avant et après rognage*.

>Profondeur et couverture :
- *Calcul de la couverture moyenne par base et identification des régions à faible mappabilité (repetitive regions)*.

#### 🔒 Intégrité académique
```markdown
Ce projet a été réalisé dans un cadre académique pour le cours BMEG 400E
Avertissement :
- 》》 Le partage de solutions directes peut enfreindre la politique d'intégrité académique de l'université.
- 》》 Ce code est partagé à des fins de documentation de portfolio et de reproductibilité scientifique personnelle.
```

#### Conseils de personnalisation avant de l'ajouter à votre dépôt :
```markdown
1. Remplacez **`votre-nom-utilisateur`** par votre identifiant GitHub réel.
2. Si votre devoir utilisait un aligneur spécifique (par exemple uniquement **`bwa mem`** ou uniquement **`bowtie2`**), conservez uniquement celui mentionné dans l'énoncé.
3. Pensez à ajouter un fichier **`.gitignore`** contenant **`data/`**, **`*.bam`**, **`*.sam`** et **`*.fastq.gz`** afin de ne pas tenter d'envoyer des fichiers de plusieurs gigaoctets sur GitHub.
```

---
