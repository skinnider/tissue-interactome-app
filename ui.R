library(shiny)
library(tidyverse)
library(viridis)
library(shinythemes)

tidy = readRDS('tidy.rds')
uniprot_ids = unique(tidy$protein)
gene_names = unique(tidy$gene_name)

source("plots.R")

ui = navbarPage("Mouse tissue interactome explorer",
                theme = shinytheme("flatly"),
                tabPanel(
                  "Gene name",
                  sidebarLayout(
                    sidebarPanel(
                      helpText("Specify one or more gene names for which to",
                               "plot mouse tissue interactome profiles."),
                      selectizeInput(
                        inputId = 'gene_names', 
                        label = 'Gene name', 
                        choices = gene_names,
                        multiple = T,
                        selected = 'Psma1', # default
                        options = list(maxOptions = 10))
                    ),
                    mainPanel(
                      plotOutput("genename_plot", height = "500px")
                    )
                  )
                ),
                tabPanel(
                  "Accession",
                  sidebarLayout(
                    sidebarPanel(
                      helpText("Specify one or more protein accessions",
                               "(UniProt IDs) for which to",
                               "plot mouse tissue interactome profiles."),
                      selectizeInput(
                        inputId = 'proteins', 
                        label = 'Protein', 
                        choices = uniprot_ids,
                        multiple = T,
                        selected = 'Q9R1P4', # default
                        options = list(maxOptions = 10))
                    ),
                    mainPanel(
                      plotOutput("protein_plot", height = "500px")
                    )
                  )
                )
)