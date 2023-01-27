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
study6 <- merge(chinese7, korean7, all = TRUE)
chinese8 <-mean_df_res[11, ]
korean8 <-mean_df_res[14, ]
study7 <- merge(chinese8, korean8, all = TRUE)

studylist <- list(study1, study2, study3, study4, study5, study6, study7)
# 
# # filename function
# make_filename = function(label, number){
#   # these can be easily turned into parameters
#   suffix = ""
#   dir = "./"
#   
#   # doing this, putting it all on a single line or using pipe %>%
#   # is just matter of style
#   filename = paste(label, number, suffix, sep="_")
#   filename = paste0(filename, ".csv")
#   filename = file.path(dir, filename)
#   
#   filename
# }
# 
# combinations = expand.grid("label"=string_label, "number"=string_number)
# filenames = mapply(make_filename, combinations$label, combinations$number)
# 
# save_element = function(element, label, number){
#   filename = make_filename(label, number)
#   write.csv(element, filename,row.names=TRUE)
# }
# 
# combinations = expand.grid("label"=string_label, "number"=string_number)
# mapply(save_element, myelement, combinations$label, combinations$number)


summary_list <- list()
df <- data.frame(matrix(ncol = 8, nrow = 7))
colnames(df) <- c("study.ID", "p.value", "dgr.of.frd", "conf.int.lb", "conf.int.ub", "mean.diff", "std.err", "cohens.d")
i = 0
for (studies in studylist){
  i = i + 1
  # wide to long
  studies <- melt(studies, id.vars = "condition")
  studies <- arrange(studies, condition) #sorting by condition
  # paired t-test
  t_test <- t.test(value ~ condition, 
                   data = studies, 
                   paired = TRUE)
  # effect size
  efs <- cohensD(value ~ condition,
                 data   = studies,
                 method = "paired")
  summaries <- capture.output(print(t_test), print(efs))
  summary_list[[i]] <- summaries
  df[i, 1] <- i
  df[i, 2] <- t_test$p.value
  df[i, 3] <- t_test$parameter
  df[i, 4] <- t_test$conf.int[1]
  df[i, 5] <- t_test$conf.int[2]
  df[i, 6] <- t_test$estimate
  df[i, 7] <- t_test$stderr
  df[i, 8] <- efs
}

# exporting data
write_csv2(df, file = "./paired_t_result.csv")


