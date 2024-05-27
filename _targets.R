library(targets)
library(tarchetypes) # Load other packages as needed.
pacman::p_load(tidyverse, harrypotter, gt, quarto, gglm, webshot2, janitor, here, patchwork, lme4)
pacman::p_load(showtext,ggrepel)

tar_option_set(
  packages = c("tidyverse", "harrypotter", "gt", "quarto", "gglm", "webshot2", "janitor") # Packages that your targets need for their tasks.
)

tar_source()

list(
  tar_file(raw_data_file, "raw-data/karl-data-4-3-24.xlsx"),
  tar_target(cleaned_data, clean_data(raw_data_file)),
  tar_target(eda, run_EDA(cleaned_data)),

  tar_target(simple_models, fit_simple_models(cleaned_data)),
  #tar_target(checked_simple_models, check_simple_models(simple_models)),

  tar_target(simple_fitted_model, fit_simple_mixed_model(cleaned_data)),
  tar_target(simple_pvalues, get_pvals(simple_fitted_model)),


  tar_target(karls_plot, create_karls_plot(cleaned_data)),

  tar_target(transformed_eda, get_transformed_EDA(cleaned_data)),

  tar_target(fitted_model, fit_model(cleaned_data)),
  tar_target(pvalues, get_pvals(fitted_model)),

  tar_target(checked_model, check_model(fitted_model, cleaned_data)),

  tar_target(prediction_interval_plot, get_prediction_interval_plot(fitted_model, cleaned_data))
)
