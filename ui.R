library(shiny)

shinyUI(fluidPage(
  titlePanel(h3("Generate New Data for SNBS npMap:")),
  
     br(),
     br(),

  sidebarLayout(
    sidebarPanel(
      
      radioButtons("animalID", label = "Select an animalID:", choices = list("S295", "S349", "S344", "S365", "S366",
                                                                             "S367", "S368", "S370", "S371", "S372",
                                                                             "S373", "S375"), selected = "S375"),          

      dateRangeInput("dates", label = "Select a date range:",
                     min = "2015-03-28",  max = "2016-12-31",
                     start = "2015-04-01", end = "2015-04-30"),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),

      submitButton("Create Files")
                    
    ),
    

    mainPanel(tableOutput("table"))
  )
))