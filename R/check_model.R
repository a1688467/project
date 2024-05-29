check_model <- function(model, data) {
  gglm(model)
  # TODO name should be model name! Use tricks
  ggsave(here::here("figs/assumptions_model.pdf"))
}

## Driver
#pacman::p_load(tidyverse,targets, gglm, lme4)
#tar_load(cleaned_data)
#tar_load(fitted_model)
#check_model(cleaned_data, fitted_model)
