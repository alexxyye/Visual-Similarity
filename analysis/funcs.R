library(readr)
library(reshape2)
library(dplyr)
library(lsr)
library(ggplot2)
library(meta)
library(metafor)

# set cd
setwd("/Users/alex/Documents/GitHub/Visual-Similarity/results/final2/")

filelist <- list.files("./", pattern = "*.csv")
n = 0
df.filelist <- list()

for (file_n in filelist){
  n = n + 1
  df <- read_csv(file_n, col_types = cols(file_loc = col_skip()))
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

normalize_df <- function(df) {
  # Find the maximum and minimum values for each column in the dataframe
  max_vals <- apply(df, 2, max)
  min_vals <- apply(df, 2, min)
  # Subtract the minimum value from each column
  df_sub <- sweep(df, 2, min_vals, `-`)
  # Divide each column by its range
  range_vals <- max_vals - min_vals
  df_normalized <- sweep(df_sub, 2, range_vals, `/`)
  return(df_normalized)
}

possibility1 <- function(df.filelist){
  # split raw data by condition
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
  
  # prepare a null mean list
  mean_list <- data.frame(matrix(ncol = 6, nrow = 14))
  colnames(mean_list) <- c("condition", "obj_num", "disc_strk", "strk_sum", "junc_sum", "PC")
  mean_list$condition <- c('symbol1', 'german1', 'symbol2', 'english2', 'symbol3', 'english3', 
                           'falsefont4', 'german4', 'chinese5', 'korean5', 
                           'chinese6', 'korean6', 'chinese7', 'korean7')
  
  # put all data together by condition
  cond_list <- list(symbol1, german1, symbol2, english2, symbol3, english3, 
                    falsefont4, german4, chinese5, korean5, 
                    chinese6, korean6, chinese7, korean7)
  
  for (cond_i in 1:14){
    for (col_j in 2:6){
      mean_ij <- mean(cond_list[[cond_i]][[col_j]])
      mean_list[cond_i, col_j] <- mean_ij
    }
  }
  
  # make a null normalized mean list
  norm_mean_list <- data.frame(matrix(data = NA, nrow = 14, ncol = 6))
  norm_mean_list[, 2:6] <- normalize_df(mean_list[ , 2:6])
  colnames(norm_mean_list) <- c("condition", "obj_num", "disc_strk", "strk_sum", "junc_sum", "PC")
  norm_mean_list$condition <- c('symbol1', 'german1', 'symbol2', 'english2', 'symbol3', 'english3', 
                                'falsefont4', 'german4', 'chinese5', 'korean5', 
                                'chinese6', 'korean6', 'chinese7', 'korean7')
  return(norm_mean_list)
}

possibility2 <- function(df.filelist){
  norm_study_list <- list()
  for (study_i in 1:7){
    ori <- df.filelist[[study_i]][, 1]
    norm_dat <- normalize_df(df.filelist[[study_i]][, 2:6])
    norm_study_list[[study_i]] <- cbind(ori, norm_dat)
  }
  
  # split into conditions
  symbol1_norm <- split_into_2(norm_study_list[[1]], 60, 1)
  german1_norm <- split_into_2(norm_study_list[[1]], 60, 2)
  symbol2_norm <- split_into_2(norm_study_list[[2]], 60, 1)
  english2_norm <- split_into_2(norm_study_list[[2]], 60, 2)
  symbol3_norm <- split_into_2(norm_study_list[[3]], 59, 1)
  english3_norm <-split_into_2(norm_study_list[[3]], 59, 2)
  falsefont4_norm <-split_into_2(norm_study_list[[4]], 84, 1)
  german4_norm <- split_into_2(norm_study_list[[4]], 84, 2)
  chinese5_norm <- split_into_2(norm_study_list[[5]], 60, 1)
  korean5_norm <- split_into_2(norm_study_list[[5]], 60, 2)
  chinese6_norm <- split_into_2(norm_study_list[[6]], 40, 1)
  korean6_norm <- split_into_2(norm_study_list[[6]], 40, 2)
  chinese7_norm <- split_into_2(norm_study_list[[7]], 120, 1)
  korean7_norm <- split_into_2(norm_study_list[[7]], 120, 2)
  # make a normalized list
  norm_cond_list <- list(symbol1_norm, german1_norm, symbol2_norm, english2_norm, symbol3_norm, english3_norm, falsefont4_norm, german4_norm, chinese5_norm, korean5_norm, chinese6_norm, korean6_norm, chinese7_norm, korean7_norm)
  
  norm_mean_list <- data.frame(matrix(data = NA, nrow = 14, ncol = 6))
  colnames(norm_mean_list) <- c("condition", "obj_num", "disc_strk", "strk_sum", "junc_sum", "PC")
  norm_mean_list$condition <- c('symbol1', 'german1', 'symbol2', 'english2', 'symbol3', 'english3', 
                                'falsefont4', 'german4', 'chinese5', 'korean5', 
                                'chinese6', 'korean6', 'chinese7', 'korean7')
  # calculate mean
  for (cond_i in 1:14){
    for (col_j in 2:6){
      mean_ij <- mean(norm_cond_list[[cond_i]][[col_j]])
      norm_mean_list[cond_i, col_j] <- mean_ij
    }
  }
  return(norm_mean_list)
}

possibility3 <- function(df.filelist){
  # split raw data by condition
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
  
  # put all data together by condition
  cond_list <- list(symbol1, german1, symbol2, english2, symbol3, english3, 
                    falsefont4, german4, chinese5, korean5, 
                    chinese6, korean6, chinese7, korean7)
  
  # make a null normalized mean list
  norm_mean_list <- data.frame(matrix(data = NA, nrow = 14, ncol = 6))
  colnames(norm_mean_list) <- c("condition", "obj_num", "disc_strk", "strk_sum", "junc_sum", "PC")
  norm_mean_list$condition <- c('symbol1', 'german1', 'symbol2', 'english2', 'symbol3', 'english3', 
                                'falsefont4', 'german4', 'chinese5', 'korean5', 
                                'chinese6', 'korean6', 'chinese7', 'korean7')
  
  for (cond_i in 1:14){
    cond_raw_i <- (cond_list[[cond_i]])
    a <- normalize_df(cond_raw_i[, 2:6])
    b <- cond_raw_i[, 1]
    norm_cond_i <- cbind(b,a)
    for (col_j in 2:6){
      mean_i <- mean(norm_cond_i[, col_j])
      norm_mean_list[cond_i, col_j] <- mean_i
    }
  }
  return(norm_mean_list)
}

# Gather Data by Study & select Parameters
get_studylist <- function(para_name, norm_mean_list){
  study1 <- norm_mean_list[1:2, ]
  study2 <- norm_mean_list[3:4, ]
  study3 <- norm_mean_list[5:6, ]
  study4 <- norm_mean_list[7:8, ]
  study5 <- norm_mean_list[9:10, ]
  study6 <- norm_mean_list[11:12, ]
  study7 <- norm_mean_list[13:14, ]
  studylist <- list(study1, study2, study3, study4, study5, study6, study7)
  n = 0
  for (stdy_n in studylist){
    n = n + 1
    stdy_n <- stdy_n %>% select(condition, para_name) # !!!select columns you want!!!
    studylist[[n]] <- stdy_n}
  return(studylist)
}

g_t.test <- function(studylist){
  # paired t-test
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
  return(df)
}

g_diff <- function(studylist){
  df <- data.frame(matrix(ncol = 2, nrow = 7))
  colnames(df) <- c("study.ID", "diff")
  for (n in 1:7){
    diff <- studylist[[n]][2, 2]-studylist[[n]][1, 2]
    df[n, 1] <- n
    df[n, 2] <- diff
  }
  return(df)
}

get_mod <- function(df){
  
meta <- read_csv("/Users/alex/Documents/GitHub/Visual-Similarity/analysis/meta.csv")
colnames(meta)[30] <- "visual.similarity"
colnames(meta)[31] <- "writing.system"

# replace Visual Similarity Index with results from VS analysis
meta[30] <- rev(df$cohens.d)
# meta[30] <- rev(df$diff)

# call the metacont random effect model
mod = metacont(
  n.early,
  mean.early.E64,
  sd.early.E64,
  n.late,
  mean.late.E64,
  sd.late.E64,
  data = meta,
  studlab = meta$author,
  method.smd = "Hedges",
  method.bias = "Egger")
return(mod)
}

get_pval.vs <- function(mod){
  MetaReg.vs <- metareg(mod, formula = ~ visual.similarity, method.tau = "REML", hakn = TRUE)
  return(MetaReg.vs$pval[2])
}

get_pval.ws <- function(mod){
  MetaReg.ws <- metareg(mod, formula = ~ writing.system, method.tau = "REML", hakn = TRUE)
  return(MetaReg.ws$pval[2])
}


all_in1 <- function(para_name, possibility){
  if (possibility == 'possibility1'){
    studylist <- get_studylist(para_name, possibility1(df.filelist))
  }
  else if (possibility == 'possibility2'){
    studylist <- get_studylist(para_name, possibility2(df.filelist))
  }
  else if (possibility == 'possibility3'){
    studylist <- get_studylist(para_name, possibility3(df.filelist))
  }
  else{
    print('wrong input')
  }
  df <- g_t.test(studylist)
  mod <- get_mod(df)
  pval <- get_pval.vs(mod)
  return(pval)
}


## combination reference
v <- read_csv('/Users/alex/Documents/GitHub/Visual-Similarity/analysis/25ParaCombinations.csv')

pvallist <- list()
poss_list <- c('possibility1', 'possibility2', 'possibility3')
temp <- data.frame(matrix(data = NA, nrow = 3, ncol = 3)) 
colnames(temp) <- c('parameters', 'possibility', 'pval')

for (combi in 1:length(v[[1]])){
  para_name <- eval(parse(text = v[[1]][combi]))
  for (i in 1:length(poss_list)){
    temp[i, 1] <- v[[1]][combi]
    temp[i, 2] <- poss_list[i]
    temp[i, 3] <- all_in1(para_name, poss_list[i])
    pvallist[[combi]] <- temp
  }
}
pvals <- do.call(rbind, pvallist)
