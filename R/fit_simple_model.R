fit_simple_model <- function(cleaned_data) {
  M_simple <- lmer(gene_expression ~ conc + cell_line + treatment + (1 | name), data = cleaned_data)
  M_simple_final <- get_model(step(M_simple))
  return (lme4::lmer(M_simple_final, data = cleaned_data))
}

## Driver
# pacman::p_load(tidyverse,targets)
# tar_load(cleaned_data)
# M1 <- fit_simple_model(cleaned_data)
