library(metasens)
library(meta)
library(metafor)
library(dplyr)
library(readr)

# import data
meta <- read_csv("/Users/alex/Documents/GitHub/Visual-Similarity/analysis/meta.csv")

# call the metacont
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


# forest plot mod
forest(mod)

# Random-effect model
dat <- escalc("SMD",
              m1i = mean.early.E64,
              m2i = mean.late.E64,
              sd1i = sd.early.E64,
              sd2i = sd.late.E64,
              n1i = n.early,
              n2i = n.late,
              data = meta,
              slab = meta$author
)

# subgroup
dat.pos <- head(dat, 3)
dat.neg <- tail(dat, 4)

meta.RE = rma(yi, vi, data = dat, slab = dat$author)
meta.RE.pos = rma(yi, vi, data = dat.pos, dat.pos$author)
meta.RE.neg = rma(yi, vi, data = dat.neg, dat.neg$author)

# Moderators
metaReg = rma(yi, vi, mods = ~visual.similarity + writing.system, data = dat, dat$author)

wi = 1/(dat$vi+metaReg$tau2)
vsReg <- lm(formula = yi ~ visual.similarity, data = dat, weights = wi)

regression <- metareg(dat,formula = yi ~ visual.similarity)

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