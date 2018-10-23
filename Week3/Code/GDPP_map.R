# making the world map and add the point of species's location to it
library("maps")
library("ggplot2")
load("../Data/GPDDFiltered.RData")
map("world")
attach(gpdd)
gpdd_map = ggplot(data=gpdd) + borders(colour='darkgrey') + geom_point(mapping =  aes(x=long,y=lat)) 
gpdd_map

# Most of filtered animals live in north hemisphere and concentrate in 50 degrees north latitude