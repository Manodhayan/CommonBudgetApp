#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(googlesheets)

URL<-"https://docs.google.com/spreadsheets/d/13JkqUGNbjojz6pGKTUwkB_YyRHHU4i-RqdsxzDitRkw/edit?usp=sharing"
# Define server logic required to draw a histogram
updateData<-function(data)
{
  URL<-"https://docs.google.com/spreadsheets/d/13JkqUGNbjojz6pGKTUwkB_YyRHHU4i-RqdsxzDitRkw/edit?usp=sharing"
  budgetSheet<-gs_url(URL)
  data<-strsplit(data,split= ";")[[1]]
  gs_add_row(budgetSheet,ws=1,input=data)
  print(data) 
}

PaymentPurpose=as.character('')
ContrubutedAmount=0
PaidPerson=as.character('')
BlacklistedPerson<- as.character('')


shinyServer(function(input, output) {
  output$validate<-renderText({
    PaymentPurpose=input$purpose
    ContrubutedAmount=input$amount
    PaidPerson=input$contributedBy
    BlacklistedPerson<- as.character(input$blacklisted)
    if(PaymentPurpose!='' && ContrubutedAmount!=0)
    {
      data<-paste(input$date,weekdays(as.POSIXct(input$date)),PaymentPurpose,PaidPerson,ContrubutedAmount,BlacklistedPerson,sep=";")
      #print(data)
      updateData(data)
      return(paste("Your Entry",data,sep=";"))
    }
    else
    {
      return ("")
    }
    
  })
  # output$oPurpose<-renderText({
  #                         PaymentPurpose<-input$purpose
  #                         })
  # 
  # output$oPaidBy<-renderText({
  #   PaidPerson<-input$contributedBy
  # })
  # 
  # output$oAmount<-renderText({
  #   ContrubutedAmount<-input$amount
  # })
  # 
  # output$oBlacklist<-renderText({BlacklistedPerson<-input$blacklisted})
  # 
  # output$validate<-renderText({
  # data<-c(input$date,PaymentPurpose,PaidPerson,ContrubutedAmount,BlacklistedPerson)
  # updateData(data)
  # return ("validate")
  # })
})
