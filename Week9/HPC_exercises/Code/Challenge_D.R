# 14.bin the abundance of species
octaves = function(abundance)
{
  abundance = floor(log2(sort(abundance)))
  bin = tabulate(abundance+1)
  return(bin)
}

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

challenge_D = function(J,v)
{
  time1 = proc.time()
  octaves_sum = array(0,1)
  for ( iter in 1:100)
  {
  J =100
  v =0.1
  num = 0
  #initialise vector
  lineages = array(1,J)
  #initialize abundance
  abundance = array(NA)
  N = J
  sita = v* (J-1)/(1-v)
  # do neutral simulation when N>1
while (N > 1)
 {
  # choose i, j randomly
  vec = sample.int(N,2,replace = F)
  j = vec[1]
  i = vec[2]
  randnum = runif(1)
  if( randnum < sita/(sita + N -1))
  {
    num = num+1
    abundance[num]= lineages[j]
  } else 
  {
    lineages[i] = lineages[j]+lineages[i]
  }
  lineages = lineages[-j]
  N = N-1
  }
  abundance[num+1] = lineages
  octaves_col = octaves(abundance)
  octaves_sum = sum_vect(octaves_col,octaves_sum)
  }
  octaves_average = octaves_sum/100
  
  time2 = proc.time()
  # claculate time
  time = as.numeric(time2[3])-as.numeric(time1[3])
  print(time)
  barplot(octaves_average,xlab = "species abundance", ylab = "species count", main = "coalescence simulation species distribution")
  return(abundance)
}

challenge_D(100,0.1)
