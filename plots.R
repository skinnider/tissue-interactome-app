plot_protein = function(accessions, tidy) {
  dat = filter(tidy, protein %in% accessions)
  ggplot(dat, aes(x = fraction, y = ratio, color = protein, group = protein)) + 
    geom_point(size = 1) + 
    geom_line() + 
    facet_wrap(~ tissue, ncol = 4, scales = 'free_y') + 
    scale_color_viridis('Protein accession', option = 'magma', discrete = T, 
                        begin = 0.15, end = 0.85) +
    labs(x = "Fraction", y = "Isotopologue ratio") + 
    theme_bw() + 
    theme(legend.position = 'top')
} 

plot_gene = function(names, tidy) {
  dat = filter(tidy, gene_name %in% names)
  ggplot(dat, aes(x = fraction, y = ratio, color = gene_name, 
                  group = gene_name)) + 
    geom_point(size = 1) + 
    geom_line() + 
    facet_wrap(~ tissue, ncol = 4, scales = 'free_y') + 
    scale_color_viridis('Gene name', option = 'magma', discrete = T, 
                        begin = 0.15, end = 0.85) +
    labs(x = "Fraction", y = "Isotopologue ratio") + 
    theme_bw() + 
    theme(legend.position = 'top')
}