library(tidyverse)
setwd("./")
temp = list.files(pattern="*.csv")
for (file in temp) {
  file_name <- gsub(".csv", "", file)
  assign(file_name, read.csv(file)) 
}
