fit_threeway_model <- function(cleaned_data) {
  M_threeway <- lmer(gene_expression ~ treatment:conc:cell_line+treatment:conc+treatment:cell_line+conc:cell_line+conc+cell_line+treatment+(1|name), data = cleaned_data)
  step_model <- step(M_threeway)
  M_threeway_final <- get_model(step_model)
  return (M_threeway_final)
}



# # Driver
#pacman::p_load(tidyverse,targets, gglm, lme4)
#tar_load(cleaned_data)
#M2 <- fit_threeway_model(cleaned_data)
