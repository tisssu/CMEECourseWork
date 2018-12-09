rm(list=ls())
graphics.off()
d<-read.table("../Data/SparrowSize.txt", header=TRUE)

# remove NA in wing data
d1<-subset(d, d$Wing!="NA")
summary(d1$Wing)
hist(d1$Wing)

#liner model of wing and sex
model1<-lm(Wing~Sex.1,data=d1)
summary(model1)

boxplot(d1$Wing~d1$Sex.1, ylab="Wing length (mm)")

# do anova
anova(model1)

#do t_test
t.test(d1$Wing~d1$Sex.1, var.equal=TRUE)

boxplot(d1$Wing~d1$BirdID, ylab="Wing length (mm)")

# modify format of form, calculate frequency of bird measured
require("dplyr")

tbl_df(d1)
glimpse(d1)

d$Mass %>% cor.test(d$Tarsus, na.rm=TRUE)
d1 %>% group_by(BirdID) %>% summarise (count=length(BirdID))
d1 %>% group_by(BirdID) %>% summarise (count=length(BirdID))
d1 %>% group_by(BirdID) %>% summarise (count=length(BirdID)) %>%  count(count)

# birdID vs wing length
model3<-lm(Wing~as.factor(BirdID), data=d1)
anova(model3)

boxplot(d$Mass~d$Year)

#birdid vs mass
m2<-lm(d$Mass~as.factor(d$Year))
anova(m2)
summary(m2)

t(model.matrix(m2))
summary(m2)
