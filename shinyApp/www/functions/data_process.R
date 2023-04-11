#' @title: data_process

data_process <- function(){
  path <- "www/data/mrtssales92-present.xlsx"
  #path <- "~/Users/audrey/Documents/0_NEU/IE6600/FinalProject/shinyApp/www/data/mrtssales92-present.xlsx"
  # data_url <- "https://www.census.gov/retail/mrts/www/mrtssales92-present.xlsx"
  # df_xlsx = read.xlsx(data_url)
  sheet = excel_sheets(path)
  df_nd = lapply(setNames(sheet, sheet), 
                 function(x) read_excel(path, sheet=x, range = 'c80:n110', col_names = paste(month.abb, x, sep = " ")))
  
  df_nd = bind_cols(df_nd)
  dim(df_nd)
  
  # remove nan cols
  #df_nd = subset(df_nd, select = -c(`Dec 2022`))
  dim(df_nd)
  
  # no nans
  sum(is.na(df_nd))
  
  # save orignal col order
  df_nd_old_order <- df_nd
  
  dim(df_nd)
  dim(df_nd_old_order)
  
  # reorder cols
  new_order = as.character(sort(as.yearmon(colnames(df_nd)), decreasing=FALSE))
  df_nd <- df_nd[, new_order]
  head(df_nd, 3)
  
  df_nd = df_nd[1:(length(df_nd)-11)]
  
  #remove nan rows
  df_nd[] <- lapply(df_nd, function(x) as.numeric(as.character(x)))
  df_nd <- na.omit(df_nd)
  dim(df_nd)
  
  # label
  group <- c('vehicle',
             'vehicle',
             'vehicle',
             'furniture',
             'furniture',
             'furniture',
             'furniture',
             'furniture',
             'grocery',
             'grocery',
             'grocery',
             'health',
             'health',
             'fuel',
             'clothing',
             'clothing',
             'clothing',
             'clothing',
             'art',
             'general',
             'general',
             'general',
             'general',
             'general',
             'general',
             'eshop',
             'eshop',
             'fuel',
             'restaurant')
  
  # grouping
  df_nd <- data.frame(group = group, df_nd)
  df_nd <- aggregate(. ~ group, df_nd, sum)
  
  # info
  dim(df_nd)
  str(df_nd)
  df_nd_series <- names(df_nd)
  head(df_nd)
  
  
  sum(is.na(df_nd))
  #is.na(df_nd)
  #which(is.na(df_nd))
  #colSums(is.na(df_nd))
  
  #summary(df_nd)
  
  
  # for plot use
  
  # unpivot
  df_nd_before_unpivot <- df_nd
  df_nd <- melt(df_nd, id.vars = "group")
  
  # rename cols
  colnames(df_nd) <- c("group", "month_year", "sales")
  
  # plot sliced dataset to see details
  df_m <- cbind(df_nd, colsplit(df_nd$month_year, "\\.", c("month", "year")))
  
  
  df <- cbind(df_nd, colsplit(df_nd$month_year, "\\.", c("month", "year")))
  df$month_num <- match(df$month, month.abb)
  df$dt <- as.Date(paste("01", df$month_num, df$year, sep = "-"), format = "%d-%m-%Y")
  df$dt_month_year <- as.yearmon(df$dt, "%m-%Y")
  return(df)
}
