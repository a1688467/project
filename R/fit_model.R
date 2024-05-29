fit_model <- function(data) {
  m_interaction <- lmer(gene_expression ~ treatment:conc+treatment:cell_line+conc:cell_line+conc+cell_line+treatment+(1|name), data = cleaned_data)
  return (m_interaction)
}



# # Driver
pacman::p_load(tidyverse,targets, gglm, lme4)
d_file <- tar_load(cleaned_data)
M2 <- fit_model(cleaned_data)


(aov <- anova(M2))
show_tests(aov, fractions = TRUE)$Product
if(requireNamespace("pbkrtest", quietly = TRUE))
  anova(M2, type=2, ddf="Kenward-Roger")

ranova(model = M2)

drop1(M2)

(lsm <- ls_means(M2))
#ls_means(m, which = "Product", pairwise = TRUE)

step_result <- step(M2)
step_result

final_model <- get_model(step_result)
summary(final_model)

final_model_keep_treament <- step(M2,keep = "treatment")
summary(get_model(final_model_keep_treament))

manual_final_model <- lmer(gene_expression ~ conc + (1 | name) + conc:treatment, data = cleaned_data)
summary(manual_final_model)

#AIC(manual_final_model, final_model)
