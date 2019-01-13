rm(list = ls())
graphics.off()

# 15.sum two vectors
sum_vect = function(x,y)
{
  if(length(x)>length(y))
  {
    y[(length(y)+1):length(x)]=0
  }
  else if(length(y)>length(x))
  {
    x[(length(x)+1):length(y)]=0
  }
  return(x+y)
}

# question 20
question_20 = function()
{
# define vector to store abundance
sum_size1 = array(0,1)
sum_size2 = array(0,1)
sum_size3 = array(0,1)
sum_size4 = array(0,1)

#read results throughly
for (i in 1:100)
{
  sum_octave = array(0,1)
  load(paste("../Data/result_rda/HPC_results",i,".rda",sep = ""))
  # calculate mean species abundance for each result
  for (j in 81:length(octave_list))
  {
    sum_octave = sum_vect(sum_octave,octave_list[[i]])
  }
  mean_octave = sum_octave/(length(octave_list)-80)
#calculate results for different size
if (i %% 4 == 1)
  {
    sum_size1 = sum_vect(sum_size1,mean_octave)
  }
else if (i %% 4 == 2)
  {
    sum_size2 = sum_vect(sum_size2,mean_octave)
  }
else if (i %% 4 == 3)
  {
    sum_size3 = sum_vect(sum_size3,mean_octave)
  }
else if (i %% 4 == 0)
  {
    sum_size4 = sum_vect(sum_size4,mean_octave)
  }
}
mean_size1 = sum_size1/25
mean_size2 = sum_size2/25
mean_size3 = sum_size3/25
mean_size4 = sum_size4/25

par(mfrow = c(2,2))
barplot(mean_size1,xlab = "species abundance", ylab =  "species count", main = "Species abundance for size 500")
barplot(mean_size2,xlab = "species abundance", ylab =  "species count", main = "Species abundance for size 1000")
barplot(mean_size3,xlab = "species abundance", ylab =  "species count", main = "Species abundance for size 2500")
barplot(mean_size4,xlab = "species abundance", ylab =  "species count", main = "Species abundance for size 5000")
par(mfrow = c(1,1))
}
question_20()
