#' @title: data_process for time series forcast

subset_groups <- function(df, group, column) {
  df_list <- list()
  groups <- unique(df$group)
  
  for (group in groups) {
    subdf <- df[df$group == group, column]
    subdfname <- paste('df_', group, sep = "")
    df_list[[subdfname]] <- subdf
  }
  
  return(df_list)
}

#df_list <- subset_groups(df, group, "sales")
