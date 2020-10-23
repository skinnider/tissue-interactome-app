options(stringsAsFactors = FALSE)
library(shiny)
library(tidyverse)
library(magrittr)
library(shinythemes)
library(RColorBrewer)

# read all chromatograms
tidy = readRDS('chromatograms.rds') %>%
  map(~ reshape2::melt(., varnames = c('protein', 'fraction'),
                       value.name = 'ratio', as.is = TRUE)) %>%
  bind_rows(.id = 'replicate') %>%
  separate(replicate, into = c('tissue', 'replicate'), sep = '\\|') %>%
  mutate(fraction = as.integer(gsub("^.* ", "", fraction)))
proteins = unique(tidy$protein)

# load plotting functions
source("plots.R")

################################################################################
### Server
################################################################################
server = function(input, output, session) {
  output$chromatogram_plot = renderPlot({
    chromatogram_plot(input$proteins, tidy)
  })
  
  output$download = downloadHandler(
    filename = function() {
      names = input$proteins[order(input$proteins)]
      paste0(paste(names, collapse = "-"), ".csv")
    },
    content = function(file) {
      dat = filter(tidy, protein %in% input$proteins)
      write.csv(dat, file, row.names = F)
    }
  )
}

################################################################################
### UI
################################################################################
ui = navbarPage("Mouse tissue interactome explorer",
                theme = shinytheme("flatly"),
                tabPanel(
                  "Plot",
                  sidebarLayout(
                    sidebarPanel(
                      helpText("Specify one or more proteins for which to",
                               "plot mouse tissue interactome profiles."),
                      selectizeInput(
                        inputId = 'proteins', 
                        label = 'Protein(s)', 
                        choices = proteins,
                        multiple = TRUE,
                        selected = c('Psma1'), # default
                        options = list(maxOptions = 8)),
                      downloadButton("download", "Download data")
                    ),
                    mainPanel(
                      plotOutput("chromatogram_plot", height = "500px")
                    )
                  )
                ),
                tabPanel(
                  "About",
                  fluidRow(
                    shinydashboard::box(width = 6, 
                                        includeMarkdown("About.md"))
                  )
                )
)

shinyApp(ui, server)
