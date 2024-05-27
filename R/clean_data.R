clean_data <- function(raw_data) {

  raw_data <- readxl::read_xlsx(raw_data)
  raw_data <- janitor::clean_names(raw_data)



  # Merge same names
  #fix_line <- c("Cell-type 101" = "CELL-TYPE 101", "WILD-TYPE" = "Wild-type")
  #fix_treament <- c("placebo" = "Placebo", "activating factor 42" = "Activating factor 42")

  #raw_data <- raw_data |>
  #  mutate(
  #    cell_line <- recode(cell_line, !!!fix_line),
  #    treatment <- recode(treatment, !!!fix_treament)
  #  )

  raw_data$cell_line <- stringr::str_to_title(raw_data$cell_line)
  raw_data$treatment <- stringr::str_to_sentence(raw_data$treatment)
  raw_data$name <- stringr::str_to_title(raw_data$name)



  # Mutate into factor not working
  #raw_data <- raw_data |>
  #  mutate(
  #    cell_line <- as.factor(cell_line),
  #    treatment <- as.factor(treatment),
  #   name <- as.factor(name),
  #    conc <- as.factor(conc) # Maybe?
  #  )

  raw_data$cell_line <- as.factor(raw_data$cell_line)
  raw_data$cell_line <- forcats::fct_rev(raw_data$cell_line)
  raw_data$Treatment <- as.factor(raw_data$treatment)
  raw_data$name <- as.factor(raw_data$name)
  #raw_data$conc <- as.factor(raw_data$conc)

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
      ))

  raw_data <- raw_data %>%
    mutate(
      cell_line = recode(
        cell_line,
        "Wild-Type" = "Wild-type"
      ))

}

# # Driver
# pacman::p_load(tidyverse,targets)
# targets::tar_load(raw_data_file)
# raw_data_file
# cleaned <- clean_data(raw_data_file)
