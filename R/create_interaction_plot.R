#
# Create interaction plot
# Originally requested by Karl
# We also use this for the report
# geom_label_repel code is horrible and mostly based of trial and error
# to get it to look the same as Jono's
#
create_interaction_plot <- function(raw_data) {
  # Colour's taken from Jono's plot
  col_pal <- c("#78a8d1", "#d5bf98")

  # Wild-type plot
  wild_plot <- raw_data %>% filter(cell_line == "Wild-type") |>
    ggplot(aes(conc, gene_expression, col = Treatment)) +
    geom_point(
      color = 'black',
      shape = 21,
      size = 4,
      aes(fill = Treatment)
    ) +
    ggtitle("Wild-type") +
    geom_label_repel(
      data = raw_data %>% filter(conc == 10 &
                                   cell_line == "Wild-type"),
      aes(label = name, fill = Treatment),
      show.legend = FALSE,
      xlim = c(10.15, 12.1),
      nudge_x = -0.5,
      colour = "black",
      segment.colour = "black",
      min.segment.length = 0.1,
    ) +  scale_color_manual(values = col_pal)

  # Cell-type 101 plot
  type101_plot <- raw_data %>% filter(cell_line != "Wild-type") |>
    ggplot(aes(conc, gene_expression, col = Treatment)) +
    geom_point(
      color = 'black',
      shape = 21,
      size = 4,
      aes(fill = Treatment)
    ) +
    ggtitle("Cell-type 101") +
    geom_label_repel(
      data = raw_data %>% filter(conc == 10 &
                                   cell_line != "Wild-type"),
      aes(label = name, fill = Treatment),
      show.legend = FALSE,
      xlim = c(10, 17.27),
      colour = "black",
      segment.colour = "black",
      nudge_x = 1.5,
      nudge_y = 0.05,
      min.segment.length = 0.1,
    ) + scale_color_manual(values = col_pal)


  # Combined plot
  # plot_layout was really finicky, so it's been split off
  # might work on older/newer versions of R but this works now
  combined_initial <- wild_plot + type101_plot + plot_annotation(tag_levels = 'A') &
    labs(y = "Gene Expression", x = "ug/ml", col = "Treatment") &
    theme_bw() &
    harrypotter::scale_fill_hp_d("Ravenclaw") &
    theme(legend.position = "bottom",
          panel.border = element_rect(size = 1.1)) &
    scale_x_continuous(limits = c(0, 12),
                       breaks = c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)) &
    scale_fill_manual(values = col_pal) &
    scale_color_manual(values = col_pal)

  combined_final <- combined_initial + plot_layout(guides = "collect") +
    labs(col = "Treatment") +  scale_fill_manual(values = col_pal) +
    scale_color_manual(values = col_pal)

  # Save the final plot!
  ggsave(filename = here::here("figs/interactionPlot.svg"),
         plot = combined_final)
}

# Driver
# pacman::p_load(tidyverse, targets, showtext, ggrepel, patchwork, svglite)
# tar_load(cleaned_data)
# create_interaction_plot(cleaned_data)
