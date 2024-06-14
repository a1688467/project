#
# Clean the data
# And rename things to be better and more clear
# Often inspiration is taken from how Karl has named things in his requests
# Or how Jono did in the plot Karl liked
#
clean_data <- function(raw_data) {
  raw_data <- readxl::read_xlsx(raw_data)

  # Clean the names and data magically
  raw_data <- janitor::clean_names(raw_data)
  raw_data$cell_line <- stringr::str_to_title(raw_data$cell_line)
  raw_data$treatment <- stringr::str_to_sentence(raw_data$treatment)
  raw_data$name <- stringr::str_to_title(raw_data$name)

  # Clean the rest of the names and data manually
  raw_data$cell_line <- as.factor(raw_data$cell_line)
  raw_data$cell_line <- forcats::fct_rev(raw_data$cell_line)
  raw_data$Treatment <- as.factor(raw_data$treatment)
  raw_data$name <- as.factor(raw_data$name)

  raw_data <- raw_data %>%
    mutate(
      name = recode(
        name,
        "Gl-Xib" = "XIb",
        "Gl-Cdz" = "cDZ",
        "Gl-Cwn" = "cwN",
        "Gl-Kyh" = "kYH",
        "Gl-Mfa" = "MFA",
        "Gl-Rjs" = "rjS",
        "Gl-Xik" = "Xik",
        "Gl-Zhw" = "ZHw"
      )
    ) %>%
    mutate(cell_line = recode(cell_line, "Wild-Type" = "Wild-type"))

  write_delim(raw_data, here::here("data/cleaned_latest_data"))

  return(raw_data)
}

## DO NOT REMOVE OR COMMENT
# imerTest step function workaround
#
# As noted before, lmerTest's step uses global state
# If I cared enough and had more time I'd submit a patch but alas
# This are needed to ensure cleaned_data is in the global state
# In it's own file without target as
pacman::p_load(tidyverse)
raw_data_file = "raw-data/karl-data-4-3-24.xlsx"
cleaned_data <-  clean_data(raw_data_file)
Sys.setenv(TAR_WARN = "false") # Shut targets up

# Driver
#pacman::p_load(tidyverse, targets)
#targets::tar_load(raw_data_file)
#raw_data_file
#cleaned <- clean_data(raw_data_file)
