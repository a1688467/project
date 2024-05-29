create_karls_plot <- function(raw_data) {

  # ## Add font
  # font_add(
  #   family = "times",
  #   regular = here::here(
  #     "Times New Roman.ttf"
  #   )
  # )
#
#   showtext_auto()
#   showtext_opts(dpi = 500)


  col_pal <- c("#78a8d1", "#d5bf98")
  #tiff(filename = "plot.tiff", width = 9, height = 6, units = "in", res = 500)

  pWild <- raw_data %>% filter(cell_line == "Wild-type") |>
    ggplot(aes(conc, gene_expression, col=Treatment))+
    geom_point(color='black', shape=21, size=4,aes(fill=Treatment)) +
    ggtitle("Wild-type") +
    geom_label_repel(
      data=raw_data %>% filter(conc == 10 & cell_line == "Wild-type"), # Filter data first
      aes(label=name, fill = Treatment),
      show.legend = FALSE,
      #ylim =c(0,60),
      xlim =c(10.15,11.1),
      nudge_x = -0.5,
      colour="black", segment.colour="black",
      min.segment.length = 0,
      #hjust = 1,
    )+  scale_color_manual(values = col_pal)

  p101 <- raw_data %>% filter(cell_line != "Wild-type") |>
    ggplot(aes(conc, gene_expression, col=Treatment))+
    geom_point(color='black', shape=21, size=4,aes(fill=Treatment)) +
    ggtitle("Cell-type 101") +
    geom_label_repel(
      data=raw_data %>% filter(conc == 10 & cell_line != "Wild-type"), # Filter data first
      aes(label=name, fill = Treatment),
      show.legend = FALSE,
      #ylim =c(0,60),
      xlim =c(10,11.27),
      colour="black", segment.colour="black",
      hjust = 1,
      nudge_x = 0.2
    )+  scale_color_manual(values = col_pal)


  combined <- pWild+ p101 + plot_annotation(tag_levels = 'A') &
    labs(y = "Gene Expression", x = "ug/ml", col = "Treatment") &
    theme_bw() &
    harrypotter::scale_fill_hp_d("Ravenclaw") &
    theme(legend.position="bottom", panel.border=element_rect(size=1.1)) &
    scale_x_continuous(limits = c(0,12),breaks = c(0,1,2,3,4,5,6,7,8,9, 10)) &  scale_fill_manual(values = col_pal) & scale_color_manual(values = col_pal) &
    theme(text = element_text(family = "times"))

  cc <- combined + plot_layout(guides = "collect") + labs(col = "Treatment") +  scale_fill_manual(values = col_pal) + scale_color_manual(values = col_pal)

  ggsave(filename = here::here("figs/KarlsPlot.pdf"))

}

#
# # Driver
pacman::p_load(tidyverse,targets, showtext,ggrepel,patchwork)
d_file <- tar_load(cleaned_data)
create_karls_plot(cleaned_data)
