#' @title: switch_plot_qq

library(tidyverse)
switch_plot_qq <- function(df, compareList){
  if(is.null(compareList)){
      p <- 
        ggplot(data = subset(df, df$group %in% c("fuel", "vehicle")))+
        stat_qq(aes(sample=log(sales)), color = "blue") +
        #theme(plot.title = element_text(hjust = 0.5, color = "purple", size = 13))+
        ggtitle("fuel VS vehicle")+
        theme_bw()
    } else{
        plot_df <- df %>%
        filter(group %in% compareList)
        
      p <-
        ggplot(data = plot_df)+
        stat_qq(aes(sample=log(sales)), color = "blue") +
        #theme(plot.title = element_text(hjust = 0.5, color = "purple", size = 13))+
        ggtitle(paste(sep = " VS ", compareList[1], compareList[2]))+
        theme_bw()
     
    }
  return(p)
}
