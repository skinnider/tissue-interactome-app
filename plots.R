app_theme = theme_bw() + 
  theme(legend.position = 'top',
        strip.background = element_rect(color = 'grey80', fill = 'grey80'),
        strip.text = element_text(size = 12, 
                                  margin = margin(0.3, 0, 0.3, 0, 'cm')),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 15),
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 12, face = 'bold'))

plot_protein = function(accessions, tidy) {
  dat = filter(tidy, protein %in% accessions)
  ggplot(dat, aes(x = fraction, y = ratio, color = protein, group = protein)) + 
    geom_point(size = 1.2) + 
    geom_line() + 
    facet_wrap(~ tissue, ncol = 4, scales = 'free_y') + 
    scale_color_viridis('Protein accession', option = 'magma', discrete = T, 
                        begin = 0.15, end = 0.85) +
    labs(x = "Fraction", y = "Isotopologue ratio") + 
    app_theme
} 

plot_gene = function(names, tidy) {
  dat = filter(tidy, gene_name %in% names)
  ggplot(dat, aes(x = fraction, y = ratio, color = gene_name, 
                  group = gene_name)) + 
    geom_point(size = 1.2) + 
    geom_line() + 
    facet_wrap(~ tissue, ncol = 4, scales = 'free_y') + 
    scale_color_viridis('Gene name', option = 'magma', discrete = T, 
                        begin = 0.15, end = 0.85) +
    labs(x = "Fraction", y = "Isotopologue ratio") + 
    app_theme
}