fit_twoway_model <- function(cleaned_data) {
  M_twoway <- lmer(
    gene_expression ~ treatment:conc + treatment:cell_line + conc:cell_line +
      conc + cell_line + treatment + (1 | name),
    data = cleaned_data
  )
  M_twoway_final <- get_model(step(M_twoway))
  return (M_twoway_final)

}


# # Driver
# pacman::p_load(tidyverse,targets, gglm, lme4)
# tar_load(cleaned_data)
# M3 <- fit_twoway_model(cleaned_data)
