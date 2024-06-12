fit_threeway_model <- function(cleaned_data) {
  M_threeway <- lmer(
    gene_expression ~ treatment:conc:cell_line + treatment:conc + treatment:cell_line +
      conc:cell_line + conc + cell_line + treatment + (1 | name),
    data = cleaned_data
  )

  step_model <- lmerTest::step(M_threeway) # This function sucks and uses global state

  M_threeway_final <- get_model(step_model)
  return(lme4::lmer(M_threeway_final, data = cleaned_data)) # Force the class to be lme4's lmer
}

# Driver
# pacman::p_load(tidyverse, targets, gglm, lme4)
# tar_load(cleaned_data)
# M2 <- fit_threeway_model(cleaned_data)
