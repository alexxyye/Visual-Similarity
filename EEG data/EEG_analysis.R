library(readr)

raw_df <- read_csv("/Users/alex/Documents/GitHub/Visual-Similarity/EEG data/Raw Data.csv")

# calculate difference between word and symbol
word_1 <- raw_df$Late.word_1 - raw_df$Early.word_1
word_2 <- raw_df$Late.word_2 - raw_df$Early.word_2
word_3 <- raw_df$Late.word_3 - raw_df$Early.word_3
word_4 <- raw_df$Late.word_4 - raw_df$Early.word_4
word_5 <- raw_df$Late.word_5 - raw_df$Early.word_5
word_6 <- raw_df$Late.word_6 - raw_df$Early.word_6
word_7 <- raw_df$Late.word_7 - raw_df$Early.word_7

symbol_1 <- raw_df$Late.symbol_1 - raw_df$Early.symbol_1
symbol_2 <- raw_df$Late.symbol_2 - raw_df$Early.symbol_2
symbol_3 <- raw_df$Late.symbol_3 - raw_df$Early.symbol_3
symbol_4 <- raw_df$Late.symbol_4 - raw_df$Early.symbol_4
symbol_5 <- raw_df$Late.symbol_5 - raw_df$Early.symbol_5
symbol_6 <- raw_df$Late.symbol_6 - raw_df$Early.symbol_6
symbol_7 <- raw_df$Late.symbol_7 - raw_df$Early.symbol_7

# comparison 
word <- cbind(word_1, word_2, word_3, word_4, word_5, word_6, word_7)
symbol <- cbind(symbol_1, symbol_2, symbol_3, symbol_4, symbol_5, symbol_6, symbol_7)
# get a summary df
df <- data.frame(matrix(data = NA, nrow = 7, ncol = 6))
colnames(df) <- c("word.mean", "word.n", "word.sd", "symbol.mean", "symbol.n", "symbol.sd")
for (i in 1:7){
  w <- as.vector(word[, i])
  w_mean <- mean(w, na.rm = TRUE)
  w_n <- sum(!is.na(symbol[, i]))
  w_sd <- sd(w, na.rm = TRUE)
  
  s <- as.vector(symbol[, i])
  s_mean <- mean(s, na.rm = TRUE)
  s_n <- sum(!is.na(symbol[, i]))
  s_sd <- sd(s, na.rm = TRUE)
  
  df[i, 1] <- w_mean
  df[i, 2] <- w_n
  df[i, 3] <- w_sd
  df[i, 4] <- s_mean
  df[i, 5] <- s_n
  df[i, 6] <- s_sd
}

# meta analysis dataframe
meta_ori <- read_excel("/Volumes/Data/Alex/meta.xlsx")
meta_ori <- meta_ori[, -c(3:30)] # get what I want

# final meta_excel
meta <- cbind(meta_ori, df)
