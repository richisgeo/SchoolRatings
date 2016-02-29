

library(shiny)
library(DT)
jsp <- read.csv("schooloutput_v2.csv")
jsp$r <- as.factor(jsp$r)
choices = c(names(jsp[,5:11]))
districts = c(unique(jsp$dis))

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Ratings by Race"),
  
  # Sidebar with controls to select the variable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    

    selectInput("Race", "Select your choice",  choices),
    checkboxGroupInput("district", 
                       label = h3("Schools Districts"), 
                       choices = levels(jsp$dis),
                       selected = 1) 
  ),

  mainPanel(

    
    tabsetPanel(type = "tabs", 
                tabPanel("Plot", plotOutput("racePlot")), 
                tabPanel("Pretty Summary", tableOutput("prettysumm")),
                tabPanel("Schools Table", DT::dataTableOutput("view"))
               
    
    
    )
  )
))