#
# Create the table of coefficients
# VERY delicate
# Look complicated but mostly renaming/rearranging
#
create_coef_table <- function(mixed_model) {
  # Extract and format the fixed effects
  fixed_eff <- mixedup::extract_fixed_effects(mixed_model)
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
  ) %>%
    rename(
      `t-value` = t,
      "p-value" = p_value,
      lower = lower_2.5,
      upper = upper_97.5
    ) %>%
    add_column(type = "Fixed effects", .before = "term")

  # Extract and format the random effects WITHOUT the intercept included
  # Importantly, we don't get p or t-values for these
  # But gt needs the column and can't be blank by default so we call them NA
  random_eff_without_int <- mixedup::extract_random_effects(mixed_model)
  random_eff_without_int <- random_eff_without_int %>%
    dplyr::select(-one_of("group_var")) %>%
    dplyr::select(-one_of("effect"))  %>%
    rename(lower = lower_2.5, upper = upper_97.5) %>%
    rename(term = group) %>%
    add_column(type = "Random effects", .before = "term") %>%
    add_column(`p-value` = NA, .before = "se") %>%
    add_column(`t-value` = NA, .before = "se")


  # Combine and create the table
  # It's minimal since I couldn't decide on how fancy to make it
  components <- rbind(fixed_eff, random_eff_without_int)
  co_table <- components %>% group_by(type) %>%
    gt %>%
    tab_header(title = "Summary of fixed and random effects coefficients") %>%
    tab_spanner(label = md("**Bounds**"),
                columns = c("lower", "upper")) %>%
    tab_footnote(footnote = "Note that the lower-bound is 2.5% and upper-bound is 97.5%",
                 locations = cells_column_spanners(spanners = md("**Bounds**"))) %>%
    cols_label(
      term = md("**Term**"),
      value = md("**Value**"),
      se = md("**Std. Err.**"),
      lower = md("**Lower**"),
      upper = md("**Upper**"),
      `t-value` = md("**t-value**"),
      `p-value` = md("**p-value**")
    ) %>%
    tab_style(cell_fill(color = "gray85"), cells_row_groups(1)) %>% tab_style(cell_fill(color = "gray85"), cells_row_groups(2)) %>%
    tab_footnote(footnote = "These values do not include the intercept and have no applicable p-value or t-value",
                 cells_row_groups("Random effects"))

  gtsave(co_table, here::here("tabs/coef_table.png"))

  return(co_table)
}

# Driver
# pacman::p_load(targets, tidyverse, lme4, gt, lmerTest)
# tar_load(threeway_model)
# tab <- create_coef_table(threeway_model)
# tab
