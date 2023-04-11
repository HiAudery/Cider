# Load libraries
library(shinydashboard)
library(shiny)
library(ggplot2)
library(tidyverse) 
library(rvest)
library(reshape)
library(readxl)
library(zoo)
library(dygraphs)
library(reshape2)
library("viridisLite") 
library("viridis") 
library(openxlsx)
library("TTR")
library("forecast")
library(grid)

# Source helper functions
source("www/functions/switch_plot.R")
source("www/functions/switch_plot_qq.R")
source("www/functions/data_process.R")
source("www/functions/subset_groups.R")
source("www/functions/ts_groups.R")
source("www/functions/ts1.R")
source("www/functions/ts2.R")
source("www/functions/ts3.R")
source("www/functions/ts4.R")

header <- dashboardHeader(title = "US Monthly Retail Trade (Jan1992-Jan2023)", 
                          titleWidth = 400)


sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("History", tabName = "dashboard", icon = icon("chart-bar")),
    menuItem("Overview", tabName = "historytrends",
             fluidRow(
               basicPage(sliderInput("year_range", "Select month year", 
                                     min = min(df$dt),
                                     max =max(df$dt),
                                     value=c(min(df$dt),max(df$dt)),
                                     timeFormat="%b %Y"),
                         uiOutput("range")
               )),
             fluidRow(
               basicPage(checkboxGroupInput(width = "100%",
                                            inputId = "grList1",
                                            label = "Select business kinds",
                                            choices = unique(df$group) 
               ),
               uiOutput("group")
               )
             )
    ),
    menuItem("Comparison", tabName = "compare",
             fluidRow(
               basicPage(checkboxGroupInput(width = "100%",
                                            inputId = "compareList",
                                            label = "Select two business",
                                            choices = unique(df$group) 
               ),
               uiOutput("compare")
               
               ))),
    menuItem("Forecast", tabName = "forecast", icon = icon("chart-line")),
    menuItem("Business", tabName = "select",
             fluidRow(
               basicPage(radioButtons(width = "100%",
                                            inputId = "forecastbusiness",
                                            label = "Select one business",
                                            choices = unique(df$group)
               ),
               uiOutput("forcast")
               
               ))),
    menuItem("Source Code", icon = icon("grin-beam"),
             href = "https://github.com/HiAudery/Cider"
    )

    # actionButton(
    #   inputId = "reset",
    #   label = "Clear all",
    #   icon = icon("refresh"),
    #   width = "50%"
    # ),
    # verbatimTextOutput("aaa")
    
    
  )
)



body <- dashboardBody(
  tabItems(
    tabItem("dashboard",
            fluidRow(
              box(
                title = "Overall Distribution",
                status = "primary",
                plotOutput("plot2", height = 340),
                height = 400
              ),
              box(
                title = "History Trends",
                status = "primary",
                plotOutput("plot1", height = 340),
                height = 400
              )
              
            ),
            fluidRow(
              box(
                title = "Overall Comparison",
                status = "primary",
                plotOutput("plot3", height = 240),
                height = 300
              ),
              box(
                title = "Compare Two Business Kinds",
                status = "primary",
                plotOutput("plot4", height = 240),
                height = 300
              )
            )
            
    ),
    tabItem("forecast",
            fluidRow(
              box(
                title = "",
                status = "primary",
                plotOutput("p1", height = 340),
                height = 400
              ),
              box(
                title = "",
                status = "primary",
                plotOutput("p2", height = 340),
                height = 400
              )
              
            ),
            fluidRow(
              box(
                title = "",
                status = "primary",
                plotOutput("p3", height = 240),
                height = 300
              ),
              box(
                title = "",
                status = "primary",
                plotOutput("p4", height = 240),
                height = 300
              )
            )
            
    )
  )
)


skin <- Sys.getenv("DASHBOARD_SKIN")
skin <- tolower(skin)
if (skin == "")
  skin <- "blue"


ui <- dashboardPage(header, sidebar, body, skin = skin)
