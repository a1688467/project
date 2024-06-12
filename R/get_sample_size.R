get_sample_size <- function() {
  # TODO Make all bounds and turn into table
  r2 <- 0.1
  coef <- 5 # Wrong?
  power <- 0.9
  sl <- 0.05
  v <- pwr.f2.test(
    f2 = r2,
    u = coef,
    power = power,
    sig.level = sl
  )$v
  n = v + coef + 1
  return(ceiling(n))
}

# Driver
# pacman::p_load(pwr)
# ss <- get_sample_size()
# ss
