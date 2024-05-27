run_EDA <- function(cleaned_data) {
  # Plot response vs predictors
  # Save all plots
  cleaned_data %>% ggplot(aes(y = gene_expression, x = cell_line, colour = treatment)) + geom_boxplot()
  ggsave(here::here("figs/geneVsCellByTreament.pdf"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = treatment, colour = cell_line)) + geom_boxplot()
  ggsave(here::here("figs/geneVsTreatmentByCell.pdf"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = treatment, colour = name)) + geom_boxplot()
  ggsave(here::here("figs/geneVsCellByName.pdf"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = treatment, colour = name)) + geom_boxplot()
  ggsave(here::here("figs/geneVsCellByName.pdf"))

  cleaned_data %>% ggplot(aes(y = gene_expression, x = conc, colour = treatment)) + geom_point()
  ggsave(here::here("figs/geneVsConcByTreament.pdf"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = conc, colour = cell_line)) + geom_point()
  ggsave(here::here("figs/geneVsConcByCell.pdf"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = conc, colour = name)) + geom_point()
  ggsave(here::here("figs/geneVsConcByName.pdf"))

  cleaned_data %>% ggplot(aes(y = gene_expression, x = cell_line)) + geom_boxplot()
  ggsave(here::here("figs/geneVsCell.pdf"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = treatment)) + geom_boxplot()
  ggsave(here::here("figs/geneVsTreament.pdf"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = name)) + geom_boxplot()
  ggsave(here::here("figs/geneVsname.pdf"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = conc)) + geom_point()
  ggsave(here::here("figs/geneVsconc.pdf"))

}

# pacman::p_load(tidyverse,targets)
# tar_load(cleaned_data)
# run_EDA(cleaned_data)
