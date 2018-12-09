rm(list = ls())
graphics.off()
d = read.table("../Data/SparrowSize.txt",header = T)
boxplot(d$Mass~d$Sex.1, col = c("red", "blue"), ylab="Body mass (g)")

#t-test
t.test1 <- t.test(d$Mass~d$Sex.1)
t.test1

d1<-as.data.frame(head(d, 50))
length(d1$Mass)

t.test2 <- t.test(d1$Mass~d1$Sex) 
t.test2

# sex vs tarsus
d2 = subset(d,d$Sex!= "NA")
d2 = subset(d2,d2$Tarsus!= "NA")
test_sex_tarsus <- t.test(d2$Tarsus~d2$Sex)
test_sex_tarsus

# length 2001 vs total
d3 = subset(d, d$Wing != "NA")
d3_2001 = subset(d3,d3$Year == "2001")

test3 = t.test(d3$Wing,d3_2001$Wing)
test3
