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
# KEEP UNCOMMENTED
# As noted before, lmerTest's step uses global state
# If I cared enough and had more time I'd submit a patch but alas
# These two lines are needed to ensure cleaned_data is in the global state
Sys.setenv(TAR_WARN = "false")
pacman::p_load(tidyverse, targets, gglm, lme4)
tar_load(cleaned_data)
# M2 <- fit_threeway_model(cleaned_data)
