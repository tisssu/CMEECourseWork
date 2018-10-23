library("dplyr")
library("tidyr")

# input the dataset
MyData <- as.matrix(read.csv("../Data/PoundHillData.csv",header = F,  stringsAsFactors = F))
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T,  sep=";", stringsAsFactors = F)
class(MyData)

# head the data
dplyr::tbl_df(MyData)

#change the "" with 0
MyData[MyData == ""] = 0

MyData <- t(MyData)
colnames(MyData)

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F)
colnames(TempData) <- MyData[1,] # assign column names from original data
rownames(TempData) <- NULL
MyWrangledData = tidyr::gather(TempData,k=Species,value=Count,-Cultivation,-Block,-Plot,-Quadrat)
head(TempData)
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])
str(MyWrangledData)