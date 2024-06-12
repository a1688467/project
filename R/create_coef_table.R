create_coef_table <- function(threeway_model) {
  # Fix this
  model <- threeway_model


  ## START CODE

  fixed_eff <- mixedup::extract_fixed_effects(model)
  random_eff_with_int <- mixedup::extract_random_coefs(threeway_model)
  random_eff_without_int <- mixedup::extract_random_effects(threeway_model)

  fixed_eff <- fixed_eff %>% mutate(
    term = recode(
      term,
      "conc" = "Concentration",
      "cell_lineCell-Type 101" = "Cell-type 101",
      "treatmentPlacebo" = "Placebo",
      "treatmentPlacebo:conc" = "Concentration:Placebo",
      "treatmentPlacebo:cell_lineCell-Type 101" = "Placebo:Cell-type 101",
      "conc:cell_lineCell-Type 101" = "Concentration:Cell-type 101",
      "treatmentPlacebo:conc:cell_lineCell-Type 101" = "Concentration:Cell-type 101:Placebo"
    )
  )

  fixed_eff <- fixed_eff %>% rename(
    `t-value` = t,
    "p-value" = p_value,
    lower = lower_2.5,
    upper = upper_97.5
  )

  random_eff_without_int <- random_eff_without_int %>%
    dplyr::select(-one_of("group_var")) %>%
    dplyr::select(-one_of("effect"))  %>% rename(lower = lower_2.5, upper =
                                                   upper_97.5)

  random_eff_without_int <- random_eff_without_int %>% rename(term = group)


  random_eff_without_int$cell_line <- random_eff_without_int$term
  random_eff_without_int <- random_eff_without_int %>% mutate(
    cell_line = recode(
      cell_line,
      "XIb" = "Wild-type",
      "cDZ" = "Wild-type",
      "cwN" = "Cell-Type 101",
      "kYH" = "Cell-Type 101",
      "MFA" = "Cell-Type 101",
      "rjS" = "Wild-type",
      "Xik" = "Wild-type",
      "ZHw" = "Cell-Type 101"
    )
  )


  random_component <- random_eff_without_int %>% add_column(type = "Random effects", .before = "term") %>% add_column(`p-value` = NA, .before = "se") %>% add_column(`t-value` = NA, .before = "se")
  fixed_component <- fixed_eff %>% add_column(type = "Fixed effects", .before = "term")

  grouped_rand <- random_component %>% dplyr::select(-cell_line)
  components <- rbind(fixed_component, grouped_rand)

  #
  tble <- components %>% group_by(type) %>%
    gt %>%
    tab_header(title = "Summary of fixed and random effects coefficients") %>%
    tab_spanner(label = md("**Bounds**"),
                columns = c("lower", "upper")) %>%
    tab_footnote(footnote = "Note that the lower-bound is 2.5% and upper-bound is 97.5%", locations = cells_column_spanners(spanners = md("**Bounds**"))) %>% cols_label(
      term = md("**Term**"),
      value = md("**Value**"),
      se = md("**Std. Err.**"),
      lower = md("**Lower**"),
      upper = md("**Upper**"),
      `t-value` = md("**t-value**"),
      `p-value` = md("**p-value**")
    ) %>%
    tab_style(cell_fill(color = "gray85"), cells_row_groups(1)) %>% tab_style(cell_fill(color = "gray85"), cells_row_groups(2)) %>%
    tab_footnote(footnote = "These values do not include the intercept and have no applicable p-value or t-value", cells_row_groups("Random effects"))

  return(tble)
}

# Driver
#pacman::p_load(targets, tidyverse, lme4, gt, lmerTest)

#tar_load(threeway_model)
#tab <- create_coef_table(threeway_model)
