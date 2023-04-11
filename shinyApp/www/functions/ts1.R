
ts1 <- function(group, ts_list){
  if (is.null(group)){
    group <- "ts_df_art"} else{
      group <- paste("ts_df_", group, sep = "")}
  
  timeseries <- log(ts_list[[group]])
  # p1
  # plot decomposing Seasonal Data
  p1 <- plot(decompose(timeseries))
  return(p1)
}
