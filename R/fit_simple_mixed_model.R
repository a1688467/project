fit_simple_mixed_model <- function(cleaned_data) {
  m_simple <- lmer(gene_expression ~ conc+cell_line+treatment+(1|name), data = cleaned_data)
  return(m_simple)
}



# # Driver
pacman::p_load(tidyverse,targets, gglm, lme4, lmerTest, pbkrtest)
tar_load(cleaned_data)
M1 <- fit_simple_mixed_model(cleaned_data)

(aov <- anova(M1))
show_tests(aov, fractions = TRUE)$Product
if(requireNamespace("pbkrtest", quietly = TRUE))
  anova(M1, type=2, ddf="Kenward-Roger")

ranova(model = M1)

drop1(M1)

(lsm <- ls_means(M1))
#ls_means(m, which = "Product", pairwise = TRUE)

step_result <- step(M1)
step_result

final_simple_model <- get_model(step_result)
summary(final_model)

final_simple_model_keep_treament <- step(M1,keep = "treatment")
summary(get_model(ktm))

#manual_final_model <- lmer(gene_expression ~ conc + (1 | name) + conc:treatment, data = cleaned_data)
#summary(fm)

#AIC(manual_final_model, final_model)
