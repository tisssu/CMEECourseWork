# Observer repeatability
rm(list = ls())
graphics.off()
a<-read.table("../Data/ObserverRepeatability.txt", header=T)

require(dplyr)

a %>% group_by(StudentID) %>% summarise (count=length(StudentID))

a %>% group_by(StudentID) %>% summarise (count=length(StudentID)) %>% summarise (length(StudentID))

a %>% group_by(StudentID) %>% summarise (count=length(StudentID)) %>% summarise (sum(count))

length(a$StudentID)

a %>% group_by(StudentID) %>% summarise (count=length(StudentID)) %>% summarise (sum(count^2))

mod<-lm(Tarsus~StudentID,data=a)
anova(mod)

mod<-lm(Tarsus~Leg+Handedness+StudentID,data=a)
anova(mod)

require(Ime4)
lmm<-lmer(Tarsus~Leg+Handedness+(1|StudentID),data=a)
summary(lmm)