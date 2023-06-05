library(readr)

raw_df <- read_csv("/Users/alex/Documents/GitHub/Visual-Similarity/EEG data/Raw Data.csv")
# # 
# # calculate difference between word and symbol
# word_1 <- raw_df$Late.word_1 - raw_df$Early.word_1
# word_2 <- raw_df$Late.word_2 - raw_df$Early.word_2
# word_3 <- raw_df$Late.word_3 - raw_df$Early.word_3
# word_4 <- raw_df$Late.word_4 - raw_df$Early.word_4
# word_5 <- raw_df$Late.word_5 - raw_df$Early.word_5
# word_6 <- raw_df$Late.word_6 - raw_df$Early.word_6
# word_7 <- raw_df$Late.word_7 - raw_df$Early.word_7
# 
# symbol_1 <- raw_df$Late.symbol_1 - raw_df$Early.symbol_1
# symbol_2 <- raw_df$Late.symbol_2 - raw_df$Early.symbol_2
# symbol_3 <- raw_df$Late.symbol_3 - raw_df$Early.symbol_3
# symbol_4 <- raw_df$Late.symbol_4 - raw_df$Early.symbol_4
# symbol_5 <- raw_df$Late.symbol_5 - raw_df$Early.symbol_5
# symbol_6 <- raw_df$Late.symbol_6 - raw_df$Early.symbol_6
# symbol_7 <- raw_df$Late.symbol_7 - raw_df$Early.symbol_7
# 
early_1 <- raw_df$Early.symbol_1 - raw_df$Early.word_1
early_2 <- raw_df$Early.symbol_2 - raw_df$Early.word_2
early_3 <- raw_df$Early.symbol_3 - raw_df$Early.word_3
early_4 <- raw_df$Early.symbol_4 - raw_df$Early.word_4
early_5 <- raw_df$Early.symbol_5 - raw_df$Early.word_5
early_6 <- raw_df$Early.symbol_6 - raw_df$Early.word_6
early_7 <- raw_df$Early.symbol_7 - raw_df$Early.word_7

late_1 <- raw_df$Late.symbol_1 - raw_df$Late.word_1
late_2 <- raw_df$Late.symbol_2 - raw_df$Late.word_2
late_3 <- raw_df$Late.symbol_3 - raw_df$Late.word_3
late_4 <- raw_df$Late.symbol_4 - raw_df$Late.word_4
late_5 <- raw_df$Late.symbol_5 - raw_df$Late.word_5
late_6 <- raw_df$Late.symbol_6 - raw_df$Late.word_6
late_7 <- raw_df$Late.symbol_7 - raw_df$Late.word_7
# 
# comparison
# word <- cbind(word_1, word_2, word_3, word_4, word_5, word_6, word_7)
# symbol <- cbind(symbol_1, symbol_2, symbol_3, symbol_4, symbol_5, symbol_6, symbol_7)
early <- cbind(early_1, early_2, early_3, early_4, early_5, early_6, early_7)
late <- cbind(late_1, late_2, late_3, late_4, late_5, late_6, late_7)
# 
# # Word / Symbol Comparison
# # get a summary df
# df <- data.frame(matrix(data = NA, nrow = 7, ncol = 6))
# colnames(df) <- c("word.mean", "word.n", "word.sd", "symbol.mean", "symbol.n", "symbol.sd")
# for (i in 1:7){
#   w <- as.vector(word[, i])
#   w_mean <- mean(w, na.rm = TRUE)
#   w_n <- sum(!is.na(symbol[, i]))
#   w_sd <- sd(w, na.rm = TRUE)
# 
#   s <- as.vector(symbol[, i])
#   s_mean <- mean(s, na.rm = TRUE)
#   s_n <- sum(!is.na(symbol[, i]))
#   s_sd <- sd(s, na.rm = TRUE)
# 
#   df[i, 1] <- w_mean
#   df[i, 2] <- w_n
#   df[i, 3] <- w_sd
#   df[i, 4] <- s_mean
#   df[i, 5] <- s_n
#   df[i, 6] <- s_sd
# }
# 
# 
## Early / Late Comparison
# get summary df2
df2 <- data.frame(matrix(data = NA, nrow = 7, ncol = 6))
colnames(df2) <- c("early.mean", "early.n", "early.sd", "late.mean", "late.n", "late.sd")
for (j in 1:7){
  e <- as.vector(early[, j])
  e_mean <- mean(e, na.rm = TRUE)
  e_n <- sum(!is.na(early[, j]))
  e_sd <- sd(e, na.rm = TRUE)

  l <- as.vector(late[, j])
  l_mean <- mean(l, na.rm = TRUE)
  l_n <- sum(!is.na(late[, j]))
  l_sd <- sd(l, na.rm = TRUE)

  df2[j, 1] <- e_mean
  df2[j, 2] <- e_n
  df2[j, 3] <- e_sd
  df2[j, 4] <- l_mean
  df2[j, 5] <- l_n
  df2[j, 6] <- l_sd
}


# meta analysis dataframe
meta_ori <- read_csv("/Users/alex/Documents/GitHub/Visual-Similarity/analysis/meta.csv")
meta_ori <- meta_ori[, -c(3:30)] # get what I want
df_early <- read_csv("/Users/alex/Documents/GitHub/Visual-Similarity/EEG data/raw_early.csv")
df_early <- df_early[, -1]
df_late <- read_csv("/Users/alex/Documents/GitHub/Visual-Similarity/EEG data/raw_late.csv")
df_late <- df_late[, -1]

# df_early <- data.frame(matrix(data = NA, nrow = 7, ncol = 6))
# colnames(df_early) <- c("word.mean", "word.n", "word.sd", "symbol.mean", "symbol.n", "symbol.sd")
# for (i in 1:7){
#   df_early[i, 1] <- raw_early[i, 2]
#   df_early[i, 2] <- raw_early[i, 3]
#   df_early[i, 3] <- raw_early[i, 4]
#   df_early[i, 4] <- raw_early[2*i, 2]
#   df_early[i, 5] <- raw_early[2*i, 3]
#   df_early[i, 6] <- raw_early[2*i, 4]
# }
# df_late <- data.frame(matrix(data = NA, nrow = 7, ncol = 6))
# colnames(df_late) <- c("word.mean", "word.n", "word.sd", "symbol.mean", "symbol.n", "symbol.sd")
# for (i in 1:7){
#   df_late[i, 1] <- raw_late[i, 2]
#   df_late[i, 2] <- raw_late[i, 3]
#   df_late[i, 3] <- raw_late[i, 4]
#   df_late[i, 4] <- raw_late[2*i, 2]
#   df_late[i, 5] <- raw_late[2*i, 3]
#   df_late[i, 6] <- raw_late[2*i, 4]
# }
# final meta_excel
meta_early <- cbind(meta_ori, df_early)
meta_late <- cbind(meta_ori, df_late)

meta <- cbind(meta_ori, df2)
meta_1 <- meta[1:4, ]
meta_2 <- meta[5:7, ]

library(meta)
library(metafor)

mod = metacont(
  early.n,
  early.mean,
  early.sd,
  late.n,
  late.mean,
  late.sd,
  data = meta,
  studlab = meta$author,
  method.smd = "Hedges",
  method.bias = "Egger")

dat <- escalc(measure="SMD", n1i=early.n, n2i=late.n, 
              m1i=early.mean, m2i=late.mean,
              sd1i=early.sd, sd2i=late.sd,
              data=meta,
              slab=paste(author, pubyear, sep=", "))
yi <- mod$TE
vi <- mod$seTE
res <- rma(yi, vi, data=dat)
### a little helper function to add Q-test, I^2, and tau^2 estimate info
mlabfun <- function(text, res) {
  list(bquote(paste(.(text),
                    " (Q = ", .(formatC(res$QE, digits=2, format="f")),
                    ", df = ", .(res$k - res$p),
                    ", p ", .(metafor:::.pval(res$QEp, digits=2, showeq=TRUE, sep=" ")), "; ",
                    I^2, " = ", .(formatC(res$I2, digits=1, format="f")), "%, ",
                    tau^2, " = ", .(formatC(res$tau2, digits=2, format="f")), ")")))}
### set up forest plot (with 2x2 table counts added; the 'rows' argument is
### used to specify in which rows the outcomes will be plotted)
forest(res, xlim=c(-16, 4.6), at=log(c(0.05, 0.25, 1, 4)), atransf=exp,
       ilab=cbind(early.n, early.mean, early.sd, late.n, late.mean, late.sd), 
       ilab.xpos=c(-15,-13.5, -12,-10,-8.5, -7), cex=1, 
       xlab = "Late N1 - Early N1 PTE",
       order=1:7, rows=c(1:4,5:7),
       mlab=mlabfun("RE Model for All Studies", res),
       psize=2, header="Author(s) and Year")

### set font expansion factor (as in forest() above) and use a bold font
op <- par(cex=0.75, font=2)

### add additional column headings to the plot
text(c(-9.5,-8,-6,-4.5), 26, c("TB+", "TB-", "TB+", "TB-"))
text(c(-8.75,-5.25),     27, c("Vaccinated", "Control"))

### switch to bold italic font
par(font=4)

### add text for the subgroups
text(-16, c(24,16,5), pos=4, c("Systematic Allocation",
                               "Random Allocation",
                               "Alternate Allocation"))

### set par back to the original settings
par(op)

### fit random-effects model in the three subgroups
res.s <- rma(yi, vi, subset=(alloc=="systematic"), data=dat)
res.r <- rma(yi, vi, subset=(alloc=="random"),     data=dat)
res.a <- rma(yi, vi, subset=(alloc=="alternate"),  data=dat)

### add summary polygons for the three subgroups
addpoly(res.s, row=18.5, mlab=mlabfun("RE Model for Subgroup", res.s))
addpoly(res.r, row= 7.5, mlab=mlabfun("RE Model for Subgroup", res.r))
addpoly(res.a, row= 1.5, mlab=mlabfun("RE Model for Subgroup", res.a))

### fit meta-regression model to test for subgroup differences
res <- rma(yi, vi, mods = ~ alloc, data=dat)

### add text for the test of subgroup differences
text(-16, -1.8, pos=4, cex=0.75, bquote(paste("Test for Subgroup Differences: ",
                                              Q[M], " = ", .(formatC(res$QM, digits=2, format="f")), ", df = ", .(res$p - 1),
                                              ", p = ", .(formatC(res$QMp, digits=2, format="f")))))

yi2 <- mod2$TE
vi2 <- mod2$seTE
mod_res2 <- rma(yi2, vi2, data=meta_2)
regtest(mod_res2, model="rma")

forest(mod_res, atransf=exp, at=log(c(.05, .25, 1, 4)), xlim=c(-16,6),
       ilab=cbind(mod_res$dat$early.n, mod_res$dat$early.mean, 
                  mod_res$dat$early.sd, mod_res$dat$late.n, 
                  mod_res$dat$late.mean, mod_res$dat$late.sd), 
       ilab.xpos=c(-9.5,-8,-6,-4.5,-2.5,-0.5),
       cex=.75, header="Author(s) and Year", mlab="")
op <- par(cex=.75, font=2)
text(c(-9.5,-8,-6,-4.5,-2.5,-0.5), mod_res$k+2, c("Early N", "Early Mean", "Early SD",
                                    "Late N", "Late Mean", "Late SD"))
text(c(-8,-2.5),     mod_res$k+3, c("Ealry N1 PTE", "Late N1 PTE"))

# call the metacont random effect model
wd_sym_early_mod = metacont(
  word.n,
  word.mean,
  word.sd,
  symbol.n,
  symbol.mean,
  symbol.sd,
  data = meta_early,
  studlab = meta_early$author,
  method.smd = "Hedges",
  method.bias = "Egger")
wd_sym_late_mod = metacont(
  word.n,
  word.mean,
  word.sd,
  symbol.n,
  symbol.mean,
  symbol.sd,
  data = meta_late,
  studlab = meta_late$author,
  method.smd = "Hedges",
  method.bias = "Egger")

setwd('/Users/alex/Documents/GitHub/Visual-Similarity/analysis')
multi.meta <- read_csv('./multi_meta.csv')
poss3 <- read_csv('./poss3_diff.csv')
c <- cbind(multi.meta, poss3[2:6])


yi <- wd_sym_early_mod$TE
vi <- wd_sym_early_mod$seTE
c$yi <- yi
c$vi <- vi
early_reg <- rma(yi = yi,
               vi = vi,
               mods = ~PC+obj_num+disc_strk, 
               data = c)

yi <- wd_sym_late_mod$TE
vi <- wd_sym_late_mod$seTE
c$yi <- yi
c$vi <- vi
late_reg <- rma(yi = yi,
               vi = vi,
               mods = ~PC+obj_num+disc_strk, 
               data = c)


