fit_simple_mixed_model <- function(data) {
  fit <- lmer(gene_expression ~ cell_line+treatment+conc+(1|name), data = data)
  return (fit)
}



# # Driver
# pacman::p_load(tidyverse,targets, gglm, lme4)
# d_file <- tar_load(raw_data_file)
# df <- clean_data(d_file)
# m <- fit_model(df)

