rm(list = ls())
graphics.off()
require(ggplot2)
require(reshape2)

# load log data from symbolic regression
sym_log = read.table("../Data/regression_log.csv",skip = 3)
pdf("../Results/log_of_regression.pdf")
layout(matrix(c(1:3,3),2,2, byrow = TRUE)) 
plot(sym_log$V1,sym_log$V6, main = "Learning curve a", col = "red", type  = "line",
     xlab = "The number of generations", ylab = "Out-of-bag fitness for best individual")
plot(sym_log$V1,sym_log$V5, col = "blue", type = "line", 
     main = "Learning curve b", xlab = "The number of generations", ylab = "Penalized fitness for best individual")
plot(sym_log$V1,sym_log$V4, main = "Learning curve of individual length", col = "brown",
     type = "line", xlab = "The number of generations", ylab = "length of the best individual")
dev.off()



#load regression result
result_mat = read.csv("../Data/sym_result.csv",header = F)
result_mat = t(result_mat)

# delete the sample with worst results
result_mat = subset(result_mat, result_mat[,3] < 1)
result_mat = data.frame(result_mat)
names(result_mat) = c("depth","length", "penalized_fitness","raw_fitness","out-of-bag_fitness")
result_mat <- melt(result_mat, id=c( "depth", "length"), variable.name = "type_of_fitness", 
                   value.name = "value_of_fitness")
result_mat <- melt(result_mat, id=c( "type_of_fitness", "value_of_fitness"), 
                   variable.name = "depth_or_length", value.name = "model_depth_and_length")



#plot the model fitness
#par(mfrow = c(3,2))
plot = ggplot(result_mat,  aes(x =model_depth_and_length, y = -log(value_of_fitness))) + 
  geom_jitter(size = 0.75) + facet_grid(type_of_fitness ~ depth_or_length, scales = "free")
pdf("../Results/model_fitness.pdf")
plot
dev.off()





