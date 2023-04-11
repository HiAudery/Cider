
ts2 <- function(group, ts_list){
  if (is.null(group)){
    group <- "ts_df_art"} else{
      group <- paste("ts_df_", group, sep = "")}
  
  timeseries <- log(ts_list[[group]])
  fit <- HoltWinters(timeseries)
  forcast <- forecast(fit, h=24)
  p2 <- plot(forcast)
  lines(forcast$fitted, lty=2, col="purple")
  return(p2)
}
