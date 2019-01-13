# challenge C
###########################
rm(list = ls())
graphics.off()

challenge_C =function()
{
# define vector to store abundance
sum_size1 = array(0,4000)
sum_size2 = array(0,8000)
sum_size3 = array(0,20000)
sum_size4 = array(0,40000)

#read results throughly
for (i in 1:100)
{
  load(paste("../Data/result_rda/HPC_results",i,".rda",sep = ""))
  #calculate results for different size
  if (i %% 4 == 1)
  {
    sum_size1 = sum_size1 + rich
  }
  else if (i %% 4 == 2)
  {
    sum_size2 = sum_size2+rich
  }
  else if (i %% 4 == 3)
  {
    sum_size3 = sum_size3 + rich
  }
  else if (i %% 4 == 0)
  {
    sum_size4 = sum_size4 + rich
  }
}

mean_size1 = sum_size1/25
mean_size2 = sum_size2/25
mean_size3 = sum_size3/25
mean_size4 = sum_size4/25

plot(mean_size4,type = "line",col="blue",xlab = "generation", ylab = "mean species richness", main = "Mean species richness against simulation generation")
points(mean_size1,type = "line",col="yellow")
points(mean_size2,type = "line",col="red")
points(mean_size3,type = "line",col="green")
legend("bottomright", inset = .05, c("J = 500", "J = 1000", "J = 2500", "J = 5000"), lwd = c(1,1,1,1), col = c("yellow", "red", "green", "blue"))

plot(mean_size4,type = "line",col="blue",xlim = range(0:1500),xlab = "generation", ylab = "mean species richness", main = "Mean species richness against simulation generation")
points(mean_size1,type = "line",col="yellow")
points(mean_size2,type = "line",col="red")
points(mean_size3,type = "line",col="green")
legend("bottomright", inset = .05, c("J = 500", "J = 1000", "J = 2500", "J = 5000"), lwd = c(1,1,1,1), col = c("yellow", "red", "green", "blue"))
abline(v = 600, col = "blue")
abline(v = 400, col = "green")
abline(v = 260, col = "red")
abline(v = 180, col = "yellow")

}

challenge_C()
