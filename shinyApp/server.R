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

server <- function(input, output) {
  # Data set
  df <- data_process()
  df_list <- subset_groups(df, group, "sales")
  ts_list <- ts_groups(df_list)
  
  # Reactive values ----
  values <- reactiveValues(year_range = NULL,
                           grList1 = NULL,
                           compareList = NULL,
                           forecastbusiness = NULL)
  
  # Output chart types using created function ()
  observe({
    values$year_range <- input$year_range
    values$grList1 <- input$grList1
    output$plot1 <- renderPlot({
      switch_plot(df, values$year_range, values$grList1)      
    }) 
  }) 
  
  # Output chart types using created function ()
  observe({
    # if (length(input$compareList) == 2) {
    #   # updateCheckboxGroupInput(session, "compareList",
    #   #                          choices = unique(df$group),
    #   #                          selected = input$compareList)
    #   
    #   disable_choices <- setdiff(unique(df$group), input$compareList)
    #   updateCheckboxGroupInput(session, "compareList",
    #                            choices = c(input$compareList, disable_choices),
    #                            selected = input$compareList,
    #                            disable = disable_choices)
    #   
    # }
    values$compareList <- input$compareList
    output$plot4 <- renderPlot({
      switch_plot_qq(df, values$compareList)      
    }) 
  })
  
  # Output chart types using created function ()
  observe({
    values$forecastbusiness <- input$forecastbusiness
    output$p1 <- renderPlot({
      ts1(values$forecastbusiness, ts_list)     
    }) 
  })
  
  # Output chart types using created function ()
  observe({
    values$forecastbusiness <- input$forecastbusiness
    output$p2 <- renderPlot({
      ts2(values$forecastbusiness, ts_list)   
    }) 
  }) 
  
  # Output chart types using created function ()
  observe({
    values$forecastbusiness <- input$forecastbusiness
    output$p3 <- renderPlot({
      ts3(values$forecastbusiness, ts_list)     
    }) 
  }) 
  
  # Output chart types using created function ()
  observe({
    values$forecastbusiness <- input$forecastbusiness
    output$p4 <- renderPlot({
      ts4(values$forecastbusiness, ts_list)     
    }) 
  }) 
  
  output$plot2 <- renderPlot({
    ggplot(data = df, mapping = aes(x = reorder(group,log(sales)), y = log(sales),fill=reorder(group,-log(sales)))) +
      geom_boxplot(notch = TRUE, position = "dodge2", outlier.colour = "red", outlier.shape = 1)+
      #ggtitle(label = "Box: US Monthly business salses. Jan1992-Nov2022") +
      xlab("Kind of Business") +
      ylab("Sales(log)") +
      coord_flip() +
      #theme_bw() +
      theme_classic()+
      labs(fill = "Business") +
      # scale_color_viridis(discrete = TRUE, option = "D")+
      # scale_fill_viridis(discrete = TRUE) 
      scale_color_brewer(palette = "Paired")+
      scale_fill_brewer(palette = "Paired")
  })
  
  output$plot3 <- renderPlot({
    # this is same with the above but show all history
    ggplot(data = subset(df), mapping = aes(x = year, y = log(sales), color = reorder(group,-log(sales))))+
      geom_point(size = 0.01) +
      geom_smooth(method = 'loess', formula = 'y ~ x') +
      #ggtitle(label = "Facet: US Monthly business salses. 1992-2022") + 
      #theme(plot.title = element_text(hjust = 0.5, color = "red", size = 13)) +
      facet_wrap( ~ group, nrow = 2)+
      xlab("Year") +
      ylab("Sales(log)") +
      #theme_bw() +
      theme_classic()+
      theme(legend.position = "none")+
      # scale_color_viridis(discrete = TRUE, option = "D")+
      # scale_fill_viridis(discrete = TRUE) +
      # theme(
      #   legend.background = element_rect(fill = "white")
      # )
      scale_color_brewer(palette = "Paired")+
      scale_fill_brewer(palette = "Paired")
  })
  # output$plot4 <- renderPlot({  
  # # looks like some business kinds have same trends
  # ggplot(data = subset(df, df$group %in% c("fuel", "vehicle")))+
  #   stat_qq(aes(sample=log(sales)), color = "purple") +
  #   #ggtitle(label = "QQ: Salses on Fuel vs Vehicle. 1992-2022") + 
  #   theme(plot.title = element_text(hjust = 0.5, color = "purple", size = 13))+
  #   theme_bw()
  # })  
  
  # Create a reactive object that filters the data based on the user input
  # filtered_data <- reactive({
  #   my_data[input$subset[1]:input$subset[2], c(input$var)]
  # })
  
  
  
  
  
  # Widget RESET ----
  # hint: set widget to NULL, then widget will disappear ----
  observeEvent(input$reset, {
    values$year_range <- NULL
    output$range <- NULL
    values$grList1 <- NULL
    output$group <- NULL
    # input$group <- NULL
    # input$range <- NULL
  })
  
  # Widget for DEBUG any specific values, default is the obs1 ----
  # You may comment it up ----
  output$aaa <- renderPrint({
    values$range
  })
  
  
  
}