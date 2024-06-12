run_EDA <- function(cleaned_data) {
  # Just the basic EDA, see Karls plot for the best picture

  cleaned_data %>% ggplot(aes(x = gene_expression)) + geom_histogram()
  ggsave(here::here("figs/gene.svg"))

  cleaned_data %>% ggplot(aes(y = gene_expression, x = cell_line, colour = treatment)) + geom_boxplot()
  ggsave(here::here("figs/geneVsCellByTreament.svg"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = treatment, colour = cell_line)) + geom_boxplot()
  ggsave(here::here("figs/geneVsTreatmentByCell.svg"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = treatment, colour = name)) + geom_boxplot()
  ggsave(here::here("figs/geneVsCellByName.svg"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = treatment, colour = name)) + geom_boxplot()
  ggsave(here::here("figs/geneVsCellByName.svg"))

  cleaned_data %>% ggplot(aes(y = gene_expression, x = conc, colour = treatment)) + geom_point()
  ggsave(here::here("figs/geneVsConcByTreament.svg"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = conc, colour = cell_line)) + geom_point()
  ggsave(here::here("figs/geneVsConcByCell.svg"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = conc, colour = name)) + geom_point()
  ggsave(here::here("figs/geneVsConcByName.svg"))

  cleaned_data %>% ggplot(aes(y = gene_expression, x = cell_line)) + geom_boxplot()
  ggsave(here::here("figs/geneVsCell.svg"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = treatment)) + geom_boxplot()
  ggsave(here::here("figs/geneVsTreament.svg"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = name)) + geom_boxplot()
  ggsave(here::here("figs/geneVsname.svg"))
  cleaned_data %>% ggplot(aes(y = gene_expression, x = conc)) + geom_point()
  ggsave(here::here("figs/geneVsconc.svg"))

}

# pacman::p_load(tidyverse,targets)
# tar_load(cleaned_data)
# run_EDA(cleaned_data)
