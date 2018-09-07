function(input, output, session) {
  tidy = readRDS('tidy.rds')
  source("plots.R")
  
  output$protein_plot = renderPlot({
    plot_protein(input$proteins, tidy)
  })
  
  output$genename_plot = renderPlot({
    plot_gene(input$gene_names, tidy)
  })
  
  output$download_gene = downloadHandler(
    filename = function() {
      names = input$gene_names[order(input$gene_names)]
      paste0(paste(names, collapse = "-"), ".csv")
    },
    content = function(file) {
      dat = filter(tidy, gene_name %in% input$gene_names)
      write.csv(dat, file, row.names = F)
    }
  )
  
  output$download_protein = downloadHandler(
    filename = function() {
      accessions = input$proteins[order(input$proteins)]
      paste0(paste(accessions, collapse = "-"), ".csv")
    },
    content = function(file) {
      dat = filter(tidy, protein %in% input$proteins)
      write.csv(dat, file, row.names = F)
    }
  )
}