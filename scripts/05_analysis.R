#!/usr/bin/env Rscript

# Chargement des bibliothèques (installer ggplot2, dplyr, tidyr si nécessaire)
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
})

# Définition des chemins
align_dir  0) {
  read_depth <- function(file_path) {
    sample_name <- sub("\\.depth\\.txt$", "", basename(file_path))
    df <- read.table(file_path, header = FALSE, col.names = c("Chr", "Pos", "Depth"))
    df$Sample <- sample_name
    return(df)
  }
  
  depth_data <- bind_rows(lapply(depth_files, read_depth))
  
  # Statistiques descriptives de couverture
  depth_summary <- depth_data %>%
    group_by(Sample) %>%
    summarise(
      Mean_Depth = round(mean(Depth), 2),
      Median_Depth = median(Depth),
      SD_Depth = round(sd(Depth), 2),
      Breadth_1X_Pct = round(sum(Depth >= 1) / n() * 100, 2)
    )
  
  cat("\nRésumé de la profondeur de couverture :\n")
  print(depth_summary)
  write.csv(depth_summary, file.path(align_dir, "coverage_summary.csv"), row.names = FALSE)
  
  # Graphique 2 : Distribution de la profondeur de couverture (Boxplot / Violon)
  p_cov <- ggplot(depth_data, aes(x = Sample, y = Depth + 1, fill = Sample)) +
    geom_violin(trim = FALSE, alpha = 0.7) +
    geom_boxplot(width = 0.15, fill = "white", outlier.shape = NA) +
    scale_y_log10() +
    theme_minimal(base_size = 13) +
    labs(
      title = "Distribution de la profondeur de couverture génomique",
      subtitle = "Échelle logarithmique (Depth + 1)",
      x = "Échantillon",
      y = "Profondeur de lecture (log10)"
    ) +
    theme(legend.position = "none")
  
  ggsave(file.path(fig_dir, "02_coverage_distribution.pdf"), p_cov, width = 7, height = 5)
  ggsave(file.path(fig_dir, "02_coverage_distribution.png"), p_cov, width = 7, height = 5, dpi = 300)
}

cat("=== [05] Analyse terminée ! Graphiques enregistrés dans :", fig_dir, "===\n")
