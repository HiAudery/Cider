
ts3 <- function(group, ts_list){
  if (is.null(group)){
    group <- "ts_df_art"} else{
      group <- paste("ts_df_", group, sep = "")}
  
  timeseries <- log(ts_list[[group]])
  fit <- HoltWinters(timeseries)
  forcast <- forecast(fit, h=24)
  p3 <- acf(forcast$residuals, lag.max=20, na.action=na.pass)
  return(p3)
}
