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
mod = metacont(
  n.early,
  mean.early,
  sd.early,
  n.late,
  mean.late,
  sd.late,
  data = multi.meta,
  studlab = multi.meta$author,
  method.smd = "Hedges",
  method.bias = "Egger")

yi <- mod$TE
vi <- mod$seTE
a$yi <- yi
b$yi <- yi
c$yi <- yi
a$vi <- vi
b$vi <- vi
c$vi <- vi

m_multi <- rma(yi = yi,
               vi = vi,
               mods = ~strk_sum+obj_num+disc_strk+PC, 
               data = c)
m_multi

