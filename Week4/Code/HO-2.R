rm(list=ls())
d<-read.table("../Data/SparrowSize.txt", header=TRUE)
str(d)
length(d$Tarsus)
# making a histgram
hist(d$Tarsus)

mean(d$Tarsus, na.rm = TRUE)
median(d$Tarsus, na.rm = TRUE)
mode(d$Tarsus)

par(mfrow = c(2, 2))
hist(d$Tarsus, breaks = 3, col="grey") 
hist(d$Tarsus, breaks = 10, col="grey") 
hist(d$Tarsus, breaks = 30, col="grey") 
hist(d$Tarsus, breaks = 100, col="grey")

require(modeest)

mlv(d$Tarsus)

d2<-subset(d, d$Tarsus!="NA")
length(d$Tarsus)
length(d2$Tarsus)
mlv(d2$Tarsus)

#Range, variance and standard deviation
range(d$Tarsus, na.rm = TRUE)
range(d2$Tarsus, na.rm = TRUE)
var(d$Tarsus, na.rm = TRUE)
var(d2$Tarsus, na.rm = TRUE)

sum((d2$Tarsus - mean(d2$Tarsus))^2)/(length(d2$Tarsus) - 1)

sqrt(var(d2$Tarsus))

zTarsus <- (d2$Tarsus - mean(d2$Tarsus))/sd(d2$Tarsus)
hist(zTarsus)

set.seed(123)
znormal = rnorm(1e+06) 
hist(znormal, breaks = 100)


par(mfrow = c(1, 2))
hist(znormal, breaks = 100)
abline(v = qnorm(c(0.25, 0.5, 0.75)), lwd = 2)
abline(v = qnorm(c(0.025, 0.975)), lwd = 2, lty = "dashed") 
plot(density(znormal))
abline(v = qnorm(c(0.25, 0.5, 0.75)), col = "gray")
abline(v = qnorm(c(0.025, 0.975)), lty = "dotted", col = "black") 
abline(h = 0, lwd = 3, col = "blue")
text(2, 0.3, "1.96", col = "red", adj = 0)
text(-2, 0.3, "-1.96", col = "red", adj = 1)

#boxplot
boxplot(d$Tarsus~d$Sex.1, col = c("red", "blue"), ylab="Tarsus length (mm)")

