library(targets)
library(tarchetypes) # Load other packages as needed.
pacman::p_load(tidyverse, harrypotter, gt, quarto, gglm, webshot2, janitor, here, patchwork, lme4, gt, lmerTest)
pacman::p_load(showtext,ggrepel)

tar_option_set(
  packages = c("tidyverse", "harrypotter", "gt", "quarto", "gglm", "webshot2", "janitor") # Packages that your targets need for their tasks.
)

tar_source()

list(
  tar_file(raw_data_file, "raw-data/karl-data-4-3-24.xlsx"),
  tar_target(cleaned_data, clean_data(raw_data_file)),

  tar_target(eda, run_EDA(cleaned_data)),
  tar_target(karls_plot, create_karls_plot(cleaned_data)),


  tar_target(simple_model, fit_simple_model(cleaned_data)),
  tar_target(simple_pvalues, get_pvals(simple_model)),

  tar_target(twoway_model, fit_twoway_model(cleaned_data)),
  tar_target(twoway_pvalues, get_pvals(twoway_model)),


  tar_target(threeway_model, fit_threeway_model(cleaned_data)),
  tar_target(threeway_pvalues, get_pvals(threeway_model)),

  # threeway is the best
  tar_target(checked_model, check_model(threeway_model, cleaned_data)),
  tar_target(prediction_interval_plot, get_prediction_interval_plot(threeway_model, cleaned_data))
)
