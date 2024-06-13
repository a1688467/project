#
# Fit the three-way mixed effects model
# Reduce the model using the step function
# We need to force a lme4 model since R sometimes creates a lmerTest model
# And we can't get nice summaries from them!
#
fit_threeway_model <- function(cleaned_data) {
  M_threeway <- lmer(
    gene_expression ~ treatment:conc:cell_line + treatment:conc + treatment:cell_line +
      conc:cell_line + conc + cell_line + treatment + (1 | name),
    data = cleaned_data
  )

  step_model <- lmerTest::step(M_threeway) # This function isn't great and uses global state so we need o force cleaned_data
  M_threeway_final <- get_model(step_model)
  return(lme4::lmer(M_threeway_final, data = cleaned_data)) # Force the class to be lme4's lmer
}

# Driver
# pacman::p_load(tidyverse, targets, gglm, lme4)
# tar_load(cleaned_data)
# M2 <- fit_threeway_model(cleaned_data)
