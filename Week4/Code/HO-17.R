rm(list=ls())
graphics.off()
hairEyes<-matrix(c(34,59,3,10,42,47),ncol=2,dimnames=list(Hair=c("Black","Brown","Blond"),Eyes=c("Brown","Blue")))
hairEyes

rowTot <- rowSums(hairEyes)
colTot = colSums(hairEyes)
tabTot<-sum(hairEyes)
Expected<-outer(rowTot,colTot)/tabTot
Expected

#calculate X^2
cellChi=(hairEyes-Expected)^2/Expected
tabChi = sum(cellChi)
tabChi

1-pchisq(tabChi,df = 2)

hairChi = chisq.test(hairEyes)
print(hairChi)
