#
# Save the assumption plots of a given model
#
check_model <- function(model) {
  gglm(model)
  ggsave(here::here("figs/assumptions_model.svg"))
}

# Driver
#pacman::p_load(tidyverse,targets, gglm, lme4)
#tar_load(cleaned_data)
#tar_load(threeway_model)
#check_model(cleaned_data, threeway_model)
