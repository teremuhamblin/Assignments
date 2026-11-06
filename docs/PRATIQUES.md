### 🛡️ Reproductibilité et Bonnes 
# Pratiques

- 》》 *Seed aléatoire* : **Les graines (set.seed(42)) sont définies dans tous les scripts stochastiques (t-SNE/UMAP, permutations)**.

- 》》 *Gestion des gros fichiers* : **Les fichiers volumineux (.fastq, .bam, .bigWig) ne doivent pas être poussés sur GitHub (ajouter data/raw/* dans .gitignore)**.
