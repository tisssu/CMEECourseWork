#calaulate wing repeatability
rm(list=ls())
graphics.off()
d<-read.table("../Data/SparrowSize.txt", header=TRUE)

d1<-subset(d, d$Wing!="NA")
model3<-lm(Wing~as.factor(BirdID), data=d1) 
anova(model3)

require(dplyr)
d1 %>% group_by(BirdID) %>% summarise (count=length(BirdID))
d1 %>% group_by(BirdID) %>% summarise (count=length(BirdID)) %>% summarise (length(BirdID))
d1 %>%  group_by(BirdID) %>% summarise (count=length(BirdID)) %>% summarise (sum(count))
d1 %>% group_by(BirdID) %>% summarise (count=length(BirdID)) %>% summarise (sum(count^2))
model3<-lm(Wing~as.factor(BirdID), data=d1)
anova(model3)

#calculate fraction
((13.20-1.62)/2.74)/(1.62+(13.20-1.62)/2.74)


#calculate mass repeatility
rm(list=ls())
graphics.off()
d<-read.table("../Data/SparrowSize.txt", header=TRUE)
d_mass<-subset(d, d$Mass!="NA")
model_Mass<-lm(Mass~as.factor(BirdID), data=d_mass) 
anova(model_Mass)

require(dplyr)
d_mass %>% group_by(BirdID) %>% summarise (count=length(BirdID))
d_mass %>% group_by(BirdID) %>% summarise (count=length(BirdID)) %>% summarise (length(BirdID))
d_mass %>% group_by(BirdID) %>% summarise (count=length(BirdID)) %>% summarise (sum(count))
d_mass %>% group_by(BirdID) %>% summarise (count=length(BirdID)) %>% summarise (sum(count^2))

#calculate repeatility
(1/632)*(1704 - 1704/7226)
((8.84-1.92)/2.70)/(1.92+(8.84-1.92)/2.70)
