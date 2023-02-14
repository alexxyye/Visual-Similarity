vars <- c("obj_num", "disc_strk", "strk_sum", "junc_sum", "PC")

flatten <- function(df){
  df_new <- data.frame(matrix(data = NA, nrow = 1))
  for (col in 1:ncol(df)){
    a <- paste(df[ ,col], collapse = ', ')
    df_new[, col] <- a
  }
  return(df_new)
}
    
final_combinations <- list()
for (n_Para in 2:4){
  df <- combn(vars, n_Para)
  df_flt <- flatten(df)
  final_combinations[[n_Para]] <- t(df_flt)
}

final_df <- do.call(rbind, final_combinations)
final_df <- as.data.frame(final_df)
rownames(final_df) <- (1:25)
