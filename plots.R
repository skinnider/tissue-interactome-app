app_theme = theme_bw() + 
  theme(legend.position = 'top',
        strip.background = element_rect(color = NA, 
                                        fill = alpha('grey90', 0.5)),
        strip.text = element_text(size = 12, 
                                  margin = margin(0.3, 0.3, 0.3, 0.3, 'cm')),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 15),
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 12, face = 'bold'))

chromatogram_plot = function(accessions, tidy) {
  dat = filter(tidy, protein %in% accessions) %>%
    mutate(replicate = paste('Replicate', replicate))
  pal = brewer.pal(10, 'Paired')
  ggplot(dat, aes(x = fraction, y = ratio, color = protein, group = protein)) + 
    geom_point(size = 1.2) + 
    geom_line() + 
    facet_grid(replicate ~ tissue, scales = 'free_y') + 
    scale_color_manual('Protein', values = pal) +
    labs(x = "Fraction", y = "Isotopologue ratio") + 
    app_theme
}
