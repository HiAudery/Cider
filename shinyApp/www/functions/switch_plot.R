#' @title: switch_plot
#hint: use aes_string to deal with string names when mapping.

library(tidyverse)
switch_plot <- function(df, year_range, grList1){
  if(is.null(year_range) & is.null(grList1)){
      p <- 
        ggplot(data = df, mapping = aes(x = dt_month_year, y = log(sales), color=reorder(group,-log(sales)))) +
        #geom_point(size=0.1) +
        geom_line() +
        xlab("Year") +
        ylab("Sales(log)") +
        #theme_bw() +
        theme_classic()+
        labs(color = "Business") +
        theme(axis.text.x = element_text(hjust = 1))+
        guides(colour = guide_legend(override.aes = list(size=6)))+
        # scale_color_viridis(discrete = TRUE, option = "D")+
        # scale_fill_viridis(discrete = TRUE)
        scale_color_brewer(palette = "Paired")+
        scale_fill_brewer(palette = "Paired")
    } else{
      if(is.null(grList1)){
        plot_df <- df %>%
        filter(dt >= year_range[1] & dt <= year_range[2])} else if(is.null(year_range)){
          plot_df <- df %>%
            filter(df$group %in% grList1)} else{
              plot_df <- df %>%
                filter(df$group %in% grList1, dt >= year_range[1] & dt <= year_range[2])
            }
      p <-
        ggplot(data = plot_df, mapping = aes(x = dt_month_year, y = log(sales), color=reorder(group,-log(sales)))) +
        #geom_point(size=0.1) +
        geom_line() +
        xlab("Year") +
        ylab("Sales(log)") +
        #theme_bw() +
        theme_classic()+
        labs(color = "Business") +
        theme(axis.text.x = element_text(hjust = 1))+
        guides(colour = guide_legend(override.aes = list(size=6)))+
        # scale_color_viridis(discrete = TRUE, option = "D")+
        # scale_fill_viridis(discrete = TRUE)
        scale_color_brewer(palette = "Paired")+
        scale_fill_brewer(palette = "Paired")
    }
  return(p)
}
