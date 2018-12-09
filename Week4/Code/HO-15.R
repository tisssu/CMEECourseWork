rm(list=ls())
graphics.off()

daphnia <- read.delim("../Data/daphnia.txt")
summary(daphnia)

# plot growth for datergent and daphnia
par(mfrow = c(1, 2))
plot(Growth.rate ~ Detergent, data = daphnia)
plot(Growth.rate ~ Daphnia, data = daphnia)

require(dplyr)
daphnia %>% group_by(Detergent) %>%summarise (variance=var(Growth.rate))

daphnia %>% group_by(Daphnia) %>% summarise (variance=var(Growth.rate))

hist(daphnia$Growth.rate)

seFun <- function(x) { sqrt(var(x)/length(x)) }
detergentMean <- with(daphnia, tapply(Growth.rate, INDEX = Detergent, FUN = mean))
detergentSEM <- with(daphnia, tapply(Growth.rate, INDEX = Detergent, FUN = seFun))
cloneMean <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = mean)) 
cloneSEM <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = seFun))

#barplot
par(mfrow=c(2,1),mar=c(4,4,1,1))
barMids <- barplot(detergentMean, xlab = "Detergent type", ylab = "Population growth rate", ylim = c(0, 5))
arrows(barMids, detergentMean - detergentSEM, barMids, detergentMean +detergentSEM, code = 3, angle = 90)
barMids <- barplot(cloneMean, xlab = "Daphnia clone", ylab = "Population growth rate", ylim = c(0, 5))
arrows(barMids, cloneMean - cloneSEM, barMids, cloneMean + cloneSEM, code = 3, angle = 90)

# liner regression
daphniaMod <- lm(Growth.rate ~ Detergent + Daphnia, data = daphnia)
anova(daphniaMod)
summary(daphniaMod)

# fits anova model
daphniaANOVAMod <- aov(Growth.rate ~ Detergent + Daphnia, data = daphnia)
summary(daphniaANOVAMod)

daphniaModHSD <- TukeyHSD(daphniaANOVAMod)
daphniaModHSD

par(mfrow=c(2,1),mar=c(4,4,1,1))
plot(daphniaModHSD)

# check residual distribution
par(mfrow=c(2,2))
plot(daphniaMod)


# multiple regression
rm(list=ls())
graphics.off()
timber <- read.delim("../Data/timber.txt")
summary(timber)

par(mfrow = c(2, 2))
boxplot(timber$volume) 
boxplot(timber$girth)
boxplot(timber$height)

#standrize data
t2<-as.data.frame(subset(timber, timber$volume!="NA"))
t2$z.girth<-scale(timber$girth)
t2$z.height<-scale(timber$height) 
var(t2$z.girth)

# check data distribution
par(mfrow = c(2, 2))
hist(t2$volume) 
hist(t2$girth) 
hist(t2$height)


# liner regression
summary(lm(girth ~ height, data = timber))
pairs(timber)
pairs(t2)


timberMod <- lm(volume ~ girth + height, data = timber)
anova(timberMod)
summary(timberMod)
plot(timberMod)

#timberMod <- lm(volume ~ girth * height, data = timber)
#anova(timberMod)
#summary(timberMod)
#plot(timberMod)
