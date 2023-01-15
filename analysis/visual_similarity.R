# packages needed
library(readr)
library(reshape2)
library(dplyr)
library(lsr)
# set cd
setwd("/Users/alex/Documents/GitHub/Visual-Similarity/analysis")
## get data
mean_df_res <- read_csv("mean_df_res.csv", col_types = cols(sum_of_square = col_skip()))
names(mean_df_res)[1] <- "condition" #change 1st column name
## compare between 2 conditions within each study
#get data
symbol1 <- mean_df_res[1, ]
german1 <- mean_df_res[4, ]
study1 <- merge(symbol1, german1, all = TRUE)
symbol2 <- mean_df_res[2, ]
english2 <- mean_df_res[6, ]
study2 <- merge(symbol2, english2, all = TRUE)
symbol3 <- mean_df_res[3, ]
english3 <- mean_df_res[7, ]
study3 <- merge(symbol3, english3, all = TRUE)
falsefont4 <-mean_df_res[8, ]
german4 <- mean_df_res[5, ]
study4 <- merge(falsefont4, german4, all = TRUE)
chinese5 <-mean_df_res[9, ]
korean5 <-mean_df_res[12, ]
study5 <- merge(chinese5, korean5, all = TRUE)
chinese7 <-mean_df_res[10, ]
korean7 <-mean_df_res[13, ]
study7 <- merge(chinese7, korean7, all = TRUE)
chinese8 <-mean_df_res[11, ]
korean8 <-mean_df_res[14, ]
study8 <- merge(chinese8, korean8, all = TRUE)

## make a function
batch <- function(study1){
  # wide to long
  study1 <- melt(study1, id.vars = "condition")
  study1 <- arrange(study1, condition) #sorting by condition
  # paired t-test
  t_test <- t.test(value ~ condition, 
         data = study1, 
         paired = TRUE)
  # effect size
  efs <- cohensD(value ~ condition,
          data   = study1,
          method = "paired")
  # exporting data
  #nm1 <- paste0(deparse(substitute(study1)),'.csv')
  summaries <- capture.output(print(t_test), print(efs))
  writeLines(summaries, con = file("default.csv"))
}

