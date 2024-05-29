fit_simple_mixed_model <- function(cleaned_data) {
  fit <- lmer(gene_expression ~ treatment:conc+treatment:cell_line+conc+cell_line+treatment+(1|name), data = cleaned_data)
  return (fit)
}



# # Driver
pacman::p_load(tidyverse,targets, gglm, lme4, lmerTest, pbkrtest)
tar_load(cleaned_data)
m <- fit_simple_mixed_model(cleaned_data)

(aov <- anova(m))
show_tests(aov, fractions = TRUE)$Product
if(requireNamespace("pbkrtest", quietly = TRUE))
  anova(m, type=2, ddf="Kenward-Roger")

ranova(model = m)

drop1(m)

(lsm <- ls_means(m))
#ls_means(m, which = "Product", pairwise = TRUE)

step_result <- step(m)
step_result

final_model <- get_model(step_result)
summary(final_model)

ktm <- step(m,keep = "treatment")
summary(get_model(ktm))

fm <- lmer(gene_expression ~ conc + (1 | name) + conc:treatment, data = cleaned_data)
summary(fm)

AIC(fm, final_model)
