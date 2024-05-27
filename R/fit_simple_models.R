fit_simple_models <- function(cleaned_data) {
  model1 <- lm(gene_expression ~  cell_line + treatment + name + conc + gene_expression, data = cleaned_data)
  model2 <- lm(gene_expression ~  cell_line + treatment + conc + gene_expression + (name*conc), data = cleaned_data)
  model3 <- lm(gene_expression ~  cell_line + treatment + conc + gene_expression, data = cleaned_data)
  return(list(model1,model2,model3))
}

## Driver
# pacman::p_load(tidyverse,targets)
# tar_load(cleaned_data)
# models <- fit_simple_models(cleaned_data)
