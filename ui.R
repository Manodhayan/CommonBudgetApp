#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
roomies<-c("Mano","Partha","Mugunth","Naveen")
blacklists<-c(roomies,c("None","Mano & Mugunth","Mano & Naveen","Mano & Partha","Partha & Naveen","Naveen & Mugunth","Partha & Mugunth"))
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Common Budget Web App"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       dateInput("date","Date",value = Sys.Date(),format = "dd-mm-yyyy"),
       textInput("purpose",label ="Purpose",value = ""),
       selectInput("contributedBy", "Paid By",roomies),
       numericInput("amount","Amount Paid",value=0),
       selectInput("blacklisted","Blacklist",choices=blacklists,selected=blacklists[5]),
       submitButton("Submit Entry"),width=10
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       textOutput("validate"),
       textOutput("oPurpose"),
       textOutput("oAmount"),
       textOutput("oPaidBy")
    )
  )
))
