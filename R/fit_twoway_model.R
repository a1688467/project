#
# Fit the two-way mixed effects model
# Reduce the model using the step function
# We need to force a lme4 model since R sometimes creates a lmerTest model
# And we can't get nice summaries from them!
#
fit_twoway_model <- function(cleaned_data) {
  M_twoway <- lmer(
    gene_expression ~ treatment:conc + treatment:cell_line + conc:cell_line +
      conc + cell_line + treatment + (1 | name),
    data = cleaned_data
  )

  M_twoway_final <- get_model(step(M_twoway))
  return (lme4::lmer(M_twoway_final, data = cleaned_data))

}

# Driver
# pacman::p_load(tidyverse,targets, gglm, lme4)
# tar_load(cleaned_data)
# M3 <- fit_twoway_model(cleaned_data)
