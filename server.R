function(input, output, session) {
  tidy = readRDS('tidy.rds')
  source("plots.R")
  
  output$protein_plot = renderPlot({
    plot_protein(input$proteins, tidy)
  })
  
  output$genename_plot = renderPlot({
    plot_gene(input$gene_names, tidy)
  })
}