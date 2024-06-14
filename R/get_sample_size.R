#
# Generate minimum sample size for Karl's new data
# NOT for the model we're using
#
get_sample_size <- function() {
  # From Karl
  r2 <- 0.1

  # Standard ES
  ess <- pwr::cohen.ES("f2", "small")$effect.size
  esm <- pwr::cohen.ES("f2", "medium")$effect.size
  esl <- pwr::cohen.ES("f2", "large")$effect.size

  # Not bothering with a map for such a small number of effect sizes
  sample_sizes <- tibble(
    `Effect sizes` = c(ess, r2, esm, esl),
    `Min sample size` = c(
      get_sample_size_from_effect_size(ess),
      get_sample_size_from_effect_size(r2),
      get_sample_size_from_effect_size(esm),
      get_sample_size_from_effect_size(esl)
    )
  )
  return(sample_sizes)
}

# Helper function to actually find the sizes
# Using the pwr documentation
get_sample_size_from_effect_size <- function(effect_size) {
  coef <- 5 # Wrong? # coef
  power <- 0.9
  sl <- 0.05
  v <- pwr.f2.test(
    f2 = effect_size,
    u = coef,
    power = power,
    sig.level = sl
  )$v
  n = v + coef + 1
  return(ceiling(n))
}

# Driver
#pacman::p_load(pwr)
#ss <- get_sample_size()
#ss
