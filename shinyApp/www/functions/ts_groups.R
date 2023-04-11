#' @title: data_process for time series forcast

ts_groups <- function(df_list) {
  ts_list <- list()
  
  for (group in names(df_list)) {
    ts <- ts(df_list[[group]], frequency=12, start=c(1992,1))
    tsname <- paste('ts_', group, sep = "")
    ts_list[[tsname]] <- ts
  }
  
  return(ts_list)
}

#ts_list <- ts_groups(df_list)