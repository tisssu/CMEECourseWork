rm(list=ls())
graphics.off()

d<-read.table("../Data/SparrowSize.txt", header=TRUE) 
d1<-subset(d, d$Tarsus!="NA") 
d_Mass<-subset(d, d$Mass!="NA") 
d_Wing<-subset(d, d$Wing!="NA") 
d_Bill<-subset(d, d$Bill!="NA") 

#tarsus
seTarsus<-sqrt(var(d1$Tarsus)/length(d1$Tarsus)) 
seTarsus
#Mass
seMass<-sqrt(var(d_Mass$Mass)/length(d_Mass$Mass)) 
seMass
#Wing
seWing<-sqrt(var(d_Wing$Wing)/length(d_Wing$Wing)) 
seWing
#Bill same as Wing

#only for 2001
d12001<-subset(d1, d1$Year==2001)
seTarsus2001<-sqrt(var(d12001$Tarsus)/length(d12001$Tarsus)) 
seTarsus2001

#2001 for mass
d_Mass2001<-subset(d_Mass, d_Mass$Year==2001)
seMass2001<-sqrt(var(d_Mass2001$Mass)/length(d_Mass2001$Mass)) 
seMass2001

#2001 for wing 
#same
#2001 for bill length
#same