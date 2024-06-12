library(targets)
library(tarchetypes) # Load other packages as needed.
pacman::p_load(tidyverse, harrypotter, gt, quarto, gglm, webshot2, janitor, here, patchwork, lme4, gt, lmerTest, mixedup, pwr)
pacman::p_load(showtext,ggrepel)

tar_option_set(
  packages = c("tidyverse", "harrypotter", "gt", "quarto", "gglm", "webshot2", "janitor", "lme4", "lmerTest", "mixedup", "pwr") # Packages that your targets need for their tasks.
)

tar_source()

list(
  tar_file(raw_data_file, "raw-data/karl-data-4-3-24.xlsx"),
  tar_target(cleaned_data, clean_data(raw_data_file)),

  tar_target(eda, run_EDA(cleaned_data)),
  tar_target(karls_plot, create_karls_plot(cleaned_data)),


  tar_target(simple_model, fit_simple_model(cleaned_data)),
  tar_target(twoway_model, fit_twoway_model(cleaned_data)),
  tar_target(threeway_model, fit_threeway_model(cleaned_data)),

  tar_target(AIC_table, create_AIC_table(simple_model, twoway_model, threeway_model)),

  # threeway is the best
  tar_target(checked_model, check_model(threeway_model, cleaned_data)),
  tar_target(coef_table, create_coef_table(threeway_model)),

  # Karl wants this, it's for a separate model though but lets keep it together
  tar_target(new_model_sample_size, get_sample_size())

  ## Qmd stuff
#  tar_quarto(Report, "Report.qmd"),
 # tar_quarto(Readme, "Readme.qmd")
)
