get_prediction_interval_plot <- function(model, data) {
  new <- data
  new %>%
    mutate(pred = predict(model, re.form = NULL)) %>% #compute mean predictions form mixed effects model
    ggplot(aes(nap, lrichness, col = name)) + #plot the data
    geom_point(show.legend = FALSE) +
    geom_line(aes(nap, pred), show.legend = FALSE) + #plot the mixed effects model predictions
    facet_wrap(~name) +
    theme_bw()
  make_individual_preds <- function(model, new){
    # predict function for bootstrapping
    predfn <- function(.) {
      predict(., newdata=new, re.form=NULL)
    }
    # summarise output of bootstrapping
    sumBoot <- function(merBoot) {
      return(
        data.frame(model = apply(merBoot$t, 2, function(x) as.numeric(quantile(x, probs=.5, na.rm=TRUE))),
                   lwr = apply(merBoot$t, 2, function(x) as.numeric(quantile(x, probs=.025, na.rm=TRUE))),
                   upr = apply(merBoot$t, 2, function(x) as.numeric(quantile(x, probs=.975, na.rm=TRUE)))
        )
      )
    }
    #get samples
    boot <- lme4::bootMer(model, predfn, nsim=500, use.u=TRUE, type="parametric")
    #save predictions in the tibble
    preds <- new %>%
      bind_cols(sumBoot(boot))
    #return the predictions

    return(preds)
  }
  new_individual_preds <- make_individual_preds(model,new)

  new_individual_preds %>%
    ggplot(aes(nap, lrichness, col = name, fill = name)) +
    geom_point(show.legend = FALSE) +
    geom_line(aes(nap, model), show.legend = FALSE) +
    geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.3, show.legend = FALSE) +
    facet_wrap(~name) +
    theme_bw()


}

# Driver
# pacman::p_load(tidyverse,targets, lme4)
# tar_load(cleaned_data)
# tar_load(fitted_model)
# get_prediction_interval_plot(fitted_model, cleaned_data)
