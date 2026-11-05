### 💡 Recommandations et utilisation

### 1. Création et activation de l'environnement
- *Exécutez dans votre terminal à la racine du projet* :
```bash
# Créer l'environnement
conda env create -f environment.yml
```

### Activer l'environnement
- 》》 **conda activate bmeg400e-env**

### 2. Conseil de performance (Mamba)
- La résolution des *dépendances mixtes* (**Bioconda + R/CRAN + Conda-Forge**) peut être lente avec le solveur classique de **Conda**.
- Si vous avez **mamba** installé, la création est *quasi-instantanée* :

```bash
mamba env create -f environment.yml
```

### 3. Vérification des outils installés
Une fois activé, vérifiez le bon fonctionnement des logiciels clés :
```bash
samtools --version
fastqc --version
multiqc --version
bwa
R --version
```

