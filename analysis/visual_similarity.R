# packages needed
library(readr)
library(reshape2)
library(dplyr)
library(lsr)
library(ggplot2)
# set cd
setwd("/Users/alex/Documents/GitHub/Visual-Similarity/results/final2/new_normalization/")

filelist <- list.files("./", pattern = "*.csv")
n = 0
df.filelist <- list()

for (file_n in filelist){
  n = n + 1
  df <- read_csv(file_n)
  df.filelist[[n]] <- df
}

split_into_2 <- function(df, loc, which_half){
  if (which_half == 1){
    df1 <- df[row.names(df) %in% 1:loc, ]
    return(df1)
  }
  else if (which_half == 2) {
    df2 <- df[row.names(df) %in% (loc+1):nrow(df), ]
    return(df2)
  }
  else {
    print("No Valid which_half input")
  }
}

symbol1 <- split_into_2(df.filelist[[1]], 60, 1)
german1 <- split_into_2(df.filelist[[1]], 60, 2)
symbol2 <- split_into_2(df.filelist[[2]], 60, 1)
english2 <- split_into_2(df.filelist[[2]], 60, 2)
symbol3 <- split_into_2(df.filelist[[3]], 59, 1)
english3 <-split_into_2(df.filelist[[3]], 59, 2)
falsefont4 <-split_into_2(df.filelist[[4]], 84, 1)
german4 <- split_into_2(df.filelist[[4]], 84, 2)
chinese5 <- split_into_2(df.filelist[[5]], 60, 1)
korean5 <- split_into_2(df.filelist[[5]], 60, 2)
chinese6 <- split_into_2(df.filelist[[6]], 40, 1)
korean6 <- split_into_2(df.filelist[[6]], 40, 2)
chinese7 <- split_into_2(df.filelist[[7]], 120, 1)
korean7 <- split_into_2(df.filelist[[7]], 120, 2)

mean_list <- data.frame(matrix(ncol = 6, nrow = 14))
colnames(mean_list) <- c("id", "obj_num", "disc_strk", "strk_sum", "junc_sum", "PC")

cond_list <- list(symbol1, german1, symbol2, english2, symbol3, english3, 
                  falsefont4, german4, chinese5, korean5, 
                  chinese6, korean6, chinese7, korean7)

for (cond_num in 1:14){
  for (col in 1:6){
    mean_list[cond_num, col] <- mean(cond_list[[cond_num]][[col]])
  }
}

colnames(mean_list)[1] <- 'condition' 
mean_list$condition <- c('symbol1', 'german1', 'symbol2', 'english2', 'symbol3', 'english3', 
'falsefont4', 'german4', 'chinese5', 'korean5', 
'chinese6', 'korean6', 'chinese7', 'korean7')

study1 <- mean_list[1:2, ]
study2 <- mean_list[3:4, ]
study3 <- mean_list[5:6, ]
study4 <- mean_list[7:8, ]
study5 <- mean_list[9:10, ]
study6 <- mean_list[11:12, ]
study7 <- mean_list[13:14, ]

# # 
# # ## get data
# # mean_df_res <- read_csv("mean_df_res.csv", col_types = cols(sum_of_square = col_skip()))
# # names(mean_df_res)[1] <- "condition" #change 1st column name
# # ## compare between 2 conditions within each study
# # #get data
# symbol1 <- mean_df_res[1, ]
# german1 <- mean_df_res[4, ]
# study1 <- merge(symbol1, german1, all = TRUE)
# symbol2 <- mean_df_res[2, ]
# english2 <- mean_df_res[6, ]
# study2 <- merge(symbol2, english2, all = TRUE)
# symbol3 <- mean_df_res[3, ]
# english3 <- mean_df_res[7, ]
# study3 <- merge(symbol3, english3, all = TRUE)
# falsefont4 <-mean_df_res[8, ]
# german4 <- mean_df_res[5, ]
# study4 <- merge(falsefont4, german4, all = TRUE)
# chinese5 <-mean_df_res[9, ]
# korean5 <-mean_df_res[12, ]
# study5 <- merge(chinese5, korean5, all = TRUE)
# chinese7 <-mean_df_res[10, ]
# korean7 <-mean_df_res[13, ]
# study6 <- merge(chinese7, korean7, all = TRUE)
# chinese8 <-mean_df_res[11, ]
# korean8 <-mean_df_res[14, ]
# study7 <- merge(chinese8, korean8, all = TRUE)


studylist <- list(study1, study2, study3, study4, study5, study6, study7)
n = 0
for (stdy_n in studylist){
  n = n + 1
  # stdy_n <- stdy_n %>% select(condition, stroke_sum, PC) # select columns you want
  studylist[[n]] <- stdy_n
}

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

# plots

j <- ggplot(df, aes(cohens.d, study.ID, xmin = cohens.d-std.err, xmax = cohens.d+std.err)) 
j + geom_errorbar(aes(xmin=cohens.d-std.err, xmax=cohens.d+std.err), width=.2,
              position=position_dodge(0.05)) + 
  geom_point() + 
  scale_x_continuous(breaks = seq(-1, 3, 0.5)) + 
  scale_y_continuous(breaks = seq(1, 7, 1))

# exporting data
write_csv2(df, file = "./paired_t_result.csv")


