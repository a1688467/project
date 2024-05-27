get_transformed_EDA <- function(data) {
  # Plot trans response
  cleaned_data %>% ggplot(aes(x=log(gene_expression))) + geom_histogram()
  ggsave(here::here("figs/loggene.pdf"))

  # Plot trans response vs a few
  cleaned_data %>% ggplot(aes(y = log(gene_expression), x = log(1+conc))) + geom_point()
  ggsave(here::here("figs/loggeneVslogconc.pdf"))


}

# Driver
