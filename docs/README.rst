Version reStructuredText (`docs/index.rst`)

Ce fichier est prêt à être intégré dans un projet de documentation Sphinx (avec génération HTML via `make html`) :

.. BMEG 400E / Genome 424 documentation master file.

BMEG 400E / Genome 424 : Genome Informatics
===========================================

.. image:: https://img.shields.io/badge/License-MIT-yellow.svg
   :target: https://opensource.org/licenses/MIT
   :alt: Licence

.. image:: https://img.shields.io/badge/Language-R%20%7C%20Bash-blue.svg
   :alt: Langages

Bienvenue dans la documentation technique du projet **BMEG 400E / BMEG 424 (Genome Informatics)**.
Ce projet fournit un ensemble d'outils, scripts et protocoles bioinformatiques pour l'exploration de données de séquençage et la génomique fonctionnelle.

Table des matières
------------------

.. toctree::
   :maxdepth: 2
   :caption: Contenu:

   introduction
   installation
   modules
   pipelines
   reproducibility

Vue d'ensemble
--------------

Le cours et le projet abordent les principes fondamentaux du traitement des données génomiques à haut débit :

* **Génomique structurale** : Analyse de mappabilité, séquences répétées et architecture chromosomique.
* **Épigénomique** : Analyse d'enrichissement de pics ChIP-seq / ATAC-seq, accessibilité chromatinienne.
* **Transcriptomique** : Analyse d'expression différentielle (RNA-seq) et profilage en cellule unique (scRNA-seq).
* **Génomique statistique** : Études d'association pangénomique (GWAS) et filtrage des variants génétiques.

Structure du projet
-------------------

.. code-block:: text

   bmeg400E-Genome424/
   ├── data/
   │   ├── raw/
   │   └── processed/
   ├── scripts/
   │   ├── bash/
   │   └── R/
   ├── notebooks/
   ├── results/
   └── docs/

Installation et Dépendances
---------------------------

Environnement Conda
^^^^^^^^^^^^^^^^^^^

Pour créer et activer l'environnement requis :

.. code-block:: bash

   conda env create -f environment.yml
   conda activate genome424

Packages R recommandés
^^^^^^^^^^^^^^^^^^^^^^

Les scripts s'appuient sur l'écosystème **Bioconductor** :

.. code-block:: r

   install.packages("BiocManager")
   BiocManager::install(c("GenomicRanges", "DESeq2", "edgeR", "rtracklayer"))
   install.packages(c("tidyverse", "pheatmap"))

Exécution des analyses
----------------------

Prétraitement CLI
^^^^^^^^^^^^^^^^^

Pour exécuter les étapes de contrôle qualité et de filtrage d'alignements :

.. code-block:: bash

   # Filtrage des alignements selon le score de qualité (ex: MAPQ >= 30)
   samtools view -b -q 30 data/raw/input.bam > data/processed/filtered.bam

Analyse R / Bioconductor
^^^^^^^^^^^^^^^^^^^^^^^^

Exécution d'un script d'analyse en ligne de commande :

.. code-block:: bash

   Rscript scripts/R/run_differential_expression.R \
       --input data/processed/counts.tsv \
       --output results/tables/de_genes.tsv

Directives de reproductibilité
------------------------------

Afin de garantir la validité des résultats :

1. Les données d'entrée doivent être référencées avec leurs versions d'assemblage (ex. *GRCh38* / *hg38*).
2. Toujours fixer la graine aléatoire dans les scripts d'échantillonnage ou de réduction de dimension :

   .. code-block:: r

      set.seed(42)

3. Ne jamais commiter de données brutes volumineuses (`.fastq.gz`, `.bam`) dans le suivi de version Git.

Licence
-------

Ce projet est sous licence MIT. Reportez-vous au fichier ``LICENSE`` pour les termes complets.
