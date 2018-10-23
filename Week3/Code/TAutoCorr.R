load("../Data/KeyWestAnnualMeanTemperature.Rdata")
attach(ats)
plot(ats)
#calculate the successive correlation
r_successive = cor(Temp[1:99],Temp[2:100])

# calculate the random permutation correlation
set.seed(001)
r_random = rep(NA, 10000)
for (i in 1:length(r_random))
{
  random_yearTemp = sample(Temp, length(Year), replace = FALSE)
  r_random[i] = cor(random_yearTemp[1:99],random_yearTemp[2:100])
}
 
p_position=0 
for (i in 1:length(r_random))
{
  if (r_successive<r_random[i])
  {
    p_position = p_position+1
  }
}
p_value = p_position/length(r_random)

hist_correlation=hist(r_random, probability = T)
print (p_value)
