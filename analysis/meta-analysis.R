library(metasens)
library(meta)
library(metafor)
library(dplyr)
library(readr)

# import data
meta <- read_csv("/Users/alex/Documents/GitHub/Visual-Similarity/analysis/meta.csv")
colnames(meta)[30] <- "visual.similarity"
colnames(meta)[31] <- "writing.system"

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
  sm = "SMD")

######
# forest plot mod
forest(mod)
# 
# # Random-effect model
# dat <- escalc("SMD",
#               m1i = mean.early.E64,
#               m2i = mean.late.E64,
#               sd1i = sd.early.E64,
#               sd2i = sd.late.E64,
#               n1i = n.early,
#               n2i = n.late,
#               data = meta,
#               slab = meta$author
# )

# dat2 <-metagen(yi, sqrt(vi), studlab = author, data = dat, sm = "SMD")

# 
# 
# # subgroup
# dat.pos <- head(dat, 3)
# dat.neg <- tail(dat, 4)
# 
# meta.RE = rma(yi, vi, data = dat, slab = dat$author)
# meta.RE.pos = rma(yi, vi, data = dat.pos, dat.pos$author)
# meta.RE.neg = rma(yi, vi, data = dat.neg, dat.neg$author)

# Moderators
# sei <- dat %>% select(n.early, n.late, yi) %>% mutate(sei = sqrt(((n.early+n.late)/(n.early*n.late))+(yi^2/2*(n.early+n.late))))
# dat$sei <- sqrt(((dat$n.early+dat$n.late)/(dat$n.early*dat$n.late))+(dat$yi^2/2*(dat$n.early+dat$n.late)))
# 
# metaReg = rma(yi, vi, sei, data = dat, dat$author, mods = ~`visual similarity` + writing.system)
# 
# wi = 1/(dat$vi+metaReg$tau2)
# vsReg <- lm(formula = yi ~ visual.similarity, data = dat, weights = wi)
# 
# regression <- metareg(dat,formula = yi ~ visual.similarity)
######
# Meta regression
MetaReg.vs <- metareg(mod, formula = ~ visual.similarity, method.tau = "REML", hakn = TRUE)
MetaReg.ws <- metareg(mod, formula = ~ writing.system, method.tau = "REML", hakn = TRUE)


# save summaries
setwd("/Volumes/Data/Alex/Analysis/")
sink("Random-efect model summaries-E64.txt")
mod
meta.RE
meta.RE.pos
meta.RE.neg
sink()

# save plots
png("/Volumes/Data/Alex/Analysis/forest plot-E64.png", width = 1000, height = 300, units = "px")
forest(mod)
dev.off()