library(targets)
library(tarchetypes) # Load other packages as needed.

pacman::p_load(
  tidyverse,
  gt,
  quarto,
  gglm,
  pwr,
  lme4,
  lmerTest,
  ggrepel,
  patchwork,
  here,
  janitor,
  svglite, # Please work on jono's mac
  harrypotter,
  assertthat,
  webshot2 # Please work on Jono's mac
)

withr::with_envvar(
  c(R_REMOTES_NO_ERRORS_FROM_WARNINGS = "true"),
  remotes::install_github('m-clark/mixedup')
)

tar_option_set(
  packages = c(
    "tidyverse",
    "gt",
    "quarto",
    "gglm",
    "pwr",
    "lme4",
    "lmerTest",
    "ggrepel",
    "patchwork",
    "here",
    "janitor",
    "svglite",
    "harrypotter",
    "mixedup",
    "assertthat",
    "webshot2"
  )
)

tar_source()

list(
  # IMPORTANT
  # If you change these two lines, i.e. for new data then make sure you change
  # clean_data's code bellow the function
  # Since lmerTest's step function uses global state
  tar_file(raw_data_file, "raw-data/karl-data-4-3-24.xlsx"),
  tar_target(cleaned_data, clean_data(raw_data_file)),

  # Both part of Karls requests
  tar_target(eda, run_EDA(cleaned_data)),
  tar_target(interaction_plot, create_interaction_plot(cleaned_data)),

  # All interaction models
  tar_target(simple_model, fit_simple_model(cleaned_data)),
  tar_target(twoway_model, fit_twoway_model(cleaned_data)),
  tar_target(threeway_model, fit_threeway_model(cleaned_data)),

  # Validate the best
  tar_target(
    AIC_table,
    create_AIC_table(simple_model, twoway_model, threeway_model)
  ),

  # three-way is the best
  tar_target(checked_model, check_model(threeway_model)),
  tar_target(coef_table, create_coef_table(threeway_model)),

  # Karl wants this, it's for a separate model though but lets keep it together
  tar_target(new_model_sample_size, get_sample_size()),

  ## TODO qmd stuff only works intermittently on Ubuntu 24.04
  # Add comma to above target if testing this! Targets has bad error messages
  tar_quarto(Report, "Report.qmd"),
  tar_quarto(Readme, "Readme.qmd")
)
