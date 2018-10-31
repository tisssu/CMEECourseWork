MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")
library(lattice)
library(dplyr)
library(tidyr)

# Draw lattice graphes
pdf("../Results/Pred_Lattice.pdf",11.7,8.3)
densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=MyDF)
dev.off()
pdf("../Results/Prey_Lattice.pdf",11.7,8.3)
densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data = MyDF)
dev.off()
pdf("../Results/SizeRatio_Lattice.pdf",11.7,8.3)
densityplot(~log(Prey.mass/Predator.mass) | Type.of.feeding.interaction, data = MyDF)
dev.off()

# Calculating the logarithm of Prey mass, Predaotr mass and Pred_prey mass ratio
Pred_Prey_massratio=log(MyDF$Prey.mass/MyDF$Predator.mass)
MyDF = cbind(MyDF,Pred_Prey_massratio)
Pred_logarithm = log(MyDF$Predator.mass)
Prey_logarithm = log(MyDF$Prey.mass)
MyDF =cbind(MyDF,Pred_logarithm)
MyDF = cbind(MyDF,Prey_logarithm)

#calculate the logarithm prey mass, predator mass, pred_prey mass ratio median and mean by feed type
Predator_mean = MyDF %>% group_by(Type.of.feeding.interaction) %>% summarise(Predator_Mean = mean(Pred_logarithm)) 
Predator_median = MyDF %>% group_by(Type.of.feeding.interaction) %>% summarise(Predator_Median = median(Pred_logarithm))
Prey_mean = MyDF %>% group_by(Type.of.feeding.interaction) %>% summarise(Prey_Mean = mean(Prey_logarithm)) 
Prey_median = MyDF %>% group_by(Type.of.feeding.interaction) %>% summarise(Prey_Median = median(Prey_logarithm))
Massratio_mean = MyDF %>% group_by(Type.of.feeding.interaction) %>% summarise(Ratio_Mean = mean(Pred_Prey_massratio)) 
Massratio_median = MyDF %>% group_by(Type.of.feeding.interaction) %>% summarise(Ratio_Median = median(Pred_Prey_massratio))

#combine the table
Mean = dplyr::full_join(Massratio_mean,Predator_mean,by = "Type.of.feeding.interaction")
Mean = dplyr::full_join(Mean,Prey_mean,by = "Type.of.feeding.interaction")
Median = dplyr::full_join(Massratio_median,Predator_median,by = "Type.of.feeding.interaction")
Median = dplyr::full_join(Median,Prey_median,by = "Type.of.feeding.interaction")
pp_Results = dplyr::full_join(Mean,Median,by = "Type.of.feeding.interaction")

# output the results table
write.table(pp_Results,"../Results/PP_Results.csv",col.names = T,row.names = F)
