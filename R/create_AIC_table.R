create_AIC_table <- function(simple_model,
                             twoway_model,
                             threeway_model) {
  `Oneway model` <- simple_model
  `Twoway model` <- twoway_model
  `Threeway model` <- threeway_model


  table_model <- AIC(simple_model, twoway_model, threeway_model) %>% as_tibble(rownames = "Model") %>%
    mutate(
      Model = recode(
        Model,
        "simple_model" = "Model 1",
        "twoway_model" = "Model 2",
        "threeway_model" = "Model 3"
      )
    ) %>% gt %>% tab_header(title = "Comparison of models by their AIC and df") %>% cols_label(
      Model = md("**Model**"),
      df = md("**df**"),
      AIC = md("**AIC**")
    ) #%>% gtsave(here::here("figs/model_comp."))

  table_model %>%  fmt_number(columns = 3, decimals = 3)
  return(table_model)
}

# Driver
# pacman::p_load(targets, tidyverse, lme4, gt, lmerTest)
#
# tar_load(simple_model)
# tar_load(twoway_model)
# tar_load(threeway_model)
#
# tab <- create_AIC_table(simple_model, twoway_model, threeway_model)
