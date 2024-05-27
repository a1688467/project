get_pvals <- function(model) {
  coeffs <- coef(summary(model))
  p_value <- pnorm(abs(coeffs[, "t value"]), lower.tail = FALSE) * 2
  tab <- cbind(coeffs, "p value" = round(p_value, 4))
  return (tibble(tab))
}

# # Drivers
# pacman::p_load(tidyverse,targets, lme4)
# tar_load(fitted_model)
# tab <- get_pvals(fitted_model)
