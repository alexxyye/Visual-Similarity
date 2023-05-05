library(readr)
setwd('/Users/alex/Documents/GitHub/Visual-Similarity/analysis')
multi.meta <- read_csv('./multi_meta.csv')
poss1 <- read_csv('./poss1_diff.csv')
poss2 <- read_csv('./poss2_diff.csv')
poss3 <- read_csv('./poss3_diff.csv')

a <- cbind(multi.meta, poss1[2:6])
b <- cbind(multi.meta, poss2[2:6])
c <- cbind(multi.meta, poss3[2:6])

library(meta)
library(metafor)
# import data
word_symbol <- read_csv("/Users/alex/Documents/GitHub/Visual-Similarity/EEG data/meta_word-symbol.csv")
early_late <- read_csv("/Users/alex/Documents/GitHub/Visual-Similarity/EEG data/meta_early-late.csv")

# call the metacont random effect model
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

ely_lt_mod = metacont(
  early.n,
  early.mean,
  early.sd,
  late.n,
  late.mean,
  late.sd,
  data = early_late,
  studlab = early_late$author,
  method.smd = "Hedges",
  method.bias = "Egger")
# forest plot mod
forest(wd_sym_mod)
forest(ely_lt_mod)

## multiple regression
yi <- wd_sym_mod$TE
vi <- ely_lt_mod$seTE
a$yi <- yi
b$yi <- yi
c$yi <- yi
a$vi <- vi
b$vi <- vi
c$vi <- vi

m_multi <- rma(yi = yi,
               vi = vi,
               mods = ~obj_num, 
               data = c)


