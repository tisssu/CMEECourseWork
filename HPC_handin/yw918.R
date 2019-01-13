rm(list = ls())
graphics.off()

# 1.calculate species richness
species_richness = function(community)
{
  return(length(unique(community)))
}

# 2.generate initial state of maximum species
initialise_max = function(size)
{
  return(seq(size))
}

# 3.generate initial state of minium species
initialise_min = function(size)
{
  return(array(1,size))
}

# 4.generte 2 vector uniform distribution
choose_two = function(x)
{
  return(sample.int(x,size = 2, replace = F))
}

# 5. single step of neutral simulation
neutral_step = function(community)
{
  index = choose_two(length(community))
  community[index[2]] = community[index[1]]
  return(community)
  #a = sample(community,length(community)-1)
  #a[length(community)] = a[length(community)-1]
  #a = sample(a)
  #return(a)
}

# 6.simulate several neutral steps 
neutral_generation = function(community)
{
  for (i in 1:round(length(community)/2))
  {
    community = neutral_step(community)
  }
  return(community)
}

# 7.retuern time series of species richness 
neutral_time_series = function(initial,duration)
{
  rich <- array(0,duration+1)
  for (i in 1:(duration+1))
  {
    rich[i] = species_richness(initial)
    initial = neutral_generation(initial)
  }
  return(rich)
}

# 8.plot species richness with generation
question_8 = function()
{
  generation = seq(201)
  plot(generation,neutral_time_series(initial = initialise_max(100),duration = 200),xlab = "generation",ylab = "species_richness",main = "neutral_time_series")
}

# 9.perform neutral step with speciation
neutral_step_speciation = function(community,v)
{
  if (runif(1)>v)
  {
    index = choose_two(length(community))
    community[index[2]] = community[index[1]]
    return(community)
  }
  else
  {
    index = sample.int(length(community),1)
    community[index[1]] = max(community)+1
    return(community)
  }
}

# 10.perform neutral generation with speciation
neutral_generation_speciation = function(community,v)
{
  for (i in 1:round(length(community)/2))
  {
    community = neutral_step_speciation(community,v)
  }
  return(community)
}

# 11.return time series of species with speciation
neutral_time_series_speciation = function(community,v,duration)
{
  rich = array(0,duration+1)
  for (i in 1:(duration+1))
  {
    rich[i] = species_richness(community)
    community = neutral_generation_speciation(community,v)
  }
  return(rich)
}

# 12.plot species richness with generation, including speciation 
question_12 = function()
{
  generation = seq(201)
  plot(generation,neutral_time_series_speciation(community = initialise_max(100),v = 0.1,duration = 200),col="blue",pch=19,cex= 0.5 ,xlab = "generation",ylab = "species_richness",main = "neutral_time_series_speciation")
  points(generation,neutral_time_series_speciation(community = initialise_min(100),v = 0.1,duration = 200),col="red",pch = 19,cex = 0.4)
}

# 13.species abundance
species_abundance = function(community)
{
  abundance = sort(as.numeric(table(community)),decreasing = T)
  return(abundance)
}

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

#16.neutral model simulation
question_16 = function()
{
  # simulating for max initial state
  community = initialise_max(100)
  for(i in 1:200)
  {
    community = neutral_generation_speciation(community,v=0.1)
  }
  # give octaves_neutral default value
  octaves_sum = c(0,0)
  for(i in 1:100)
  {
    for (j in 1:20)
    {
      community = neutral_generation_speciation(community,v=0.1)
    }
    abundance = species_abundance(community)
    octaves_sum = sum_vect(octaves(abundance),octaves_sum)
  }
  octaves_average = octaves_sum/100
  
  #simulating for min initial state
  time1 = proc.time()
  community_min = initialise_min(100)
  for(i in 1:200)
  {
    community_min = neutral_generation_speciation(community_min,v=0.1)
  }
  # give octaves_neutral default value
  octaves_sum_min = c(0,0)
  for(i in 1:100)
  {
    for (j in 1:20)
    {
      community_min = neutral_generation_speciation(community_min,v=0.1)
    }
    abundance_min = species_abundance(community_min)
    octaves_sum_min = sum_vect(octaves(abundance_min),octaves_sum_min)
  }
  octaves_average_min = octaves_sum_min/100
  # calculate time
  time2 = proc.time()
  time = as.numeric(time2[3])-as.numeric(time1[3])
  # plot the average species abundance
  par(mfrow = c(2,1))
  barplot(octaves_average, xlab = "species abundance", ylab =  "species count", main = "average species abundance for maximum initial state")
  barplot(octaves_average_min, xlab = "species abundance", ylab =  "species count", main = "average species abundance for minimum initial state")
  par(mfrow = c(1,1))
  return(time)
}

#chanllege question A
challenge_A = function()
{
  sp_richness = matrix(nrow = 100,ncol = 201)
  sp_richness_min = matrix(nrow = 100,ncol = 201)
  up_richness = array(0,200)
  down_richness = array(0,200)
  up_richness_min = array(0,200)
  down_richness_min = array(0,200)
  for (i in 1:100)
  {
    sp_richness[i,] = neutral_time_series_speciation(community = initialise_max(100),v= 0.1,duration = 200)
    sp_richness_min[i,] = neutral_time_series_speciation(community = initialise_min(100),v= 0.1,duration = 200)
  }
  
  # calculate mean
  mea_richness = apply(sp_richness, 2, mean)
  mea_richness_min = apply(sp_richness_min, 2, mean)
  # calculate confidence interval
  inteval_richness = apply(sp_richness[,2:201], 2, t.test, conf.level = 0.972)
  inteval_richness_min = apply(sp_richness_min[,2:201], 2, t.test, conf.level = 0.972)
  
  for (i in 1:200)
  {
    up_richness[i] = inteval_richness[[i]][["conf.int"]][1]
    down_richness[i] = inteval_richness[[i]][["conf.int"]][2]
    up_richness_min[i] = inteval_richness_min[[i]][["conf.int"]][1]
    down_richness_min[i] = inteval_richness_min[[i]][["conf.int"]][2]
  }
  plot(seq(1,201,1),mea_richness,type = "line", col = "red", xlim = range(0:100),ylim = range(0:72), lwd = 1,main = "mean species richness and confidence interval", xlab = "generation", ylab = "species richness")
  points(seq(1,201,1),mea_richness_min,type = "line", col = "green",  lwd = 1)
  points(seq(2,201,1),up_richness,type = "line", col = "red",  lwd = 0.5)
  points(seq(2,201,1),down_richness,type = "line", col = "red",  lwd = 0.5)
  points(seq(2,201,1),up_richness_min,type = "line", col = "green",  lwd = 0.5)
  points(seq(2,201,1),down_richness_min,type = "line", col = "green",  lwd = 0.5)
  legend("topleft", inset = .05, c("mean species richness max","mean species richness min", "richness interval max", "richness interval min"), lwd = c(1,1,0.5,0.5), col = c("red","green","red","green"))
}

#challenge_B
initialise_part = function(richness, size)
{
  community = array(1,size)
  order = sample.int(size,(richness-1),replace = F)
  for (i in 1:size)
  {
    if (is.element(i,order))
    {
      community[i] = i+1
    }
  }
  return(community)
}
#initialise_part(5,10)
#initialise_part(27,100)

challenge_B = function()
{
  #defalut value
  sp_richness = matrix(nrow = 100,ncol = 201)
  sp_richness_min = matrix(nrow = 100,ncol = 201)
  sp_richness_20 = matrix(nrow = 100, ncol = 201)
  sp_richness_40 = matrix(nrow = 100, ncol = 201)
  sp_richness_60 = matrix(nrow = 100, ncol = 201)
  sp_richness_80 = matrix(nrow = 100, ncol = 201)
  # calculate and store species richness
  for (i in 1:100)
  {
    sp_richness[i,] = neutral_time_series_speciation(community = initialise_max(100),v= 0.1,duration = 200)
    sp_richness_min[i,] = neutral_time_series_speciation(community = initialise_min(100),v= 0.1,duration = 200)
    sp_richness_20[i,] = neutral_time_series_speciation(community = initialise_part(20, 100),v= 0.1,duration = 200)
    sp_richness_40[i,] = neutral_time_series_speciation(community = initialise_part(40, 100),v= 0.1,duration = 200)
    sp_richness_60[i,] = neutral_time_series_speciation(community = initialise_part(60, 100),v= 0.1,duration = 200)
    sp_richness_80[i,] = neutral_time_series_speciation(community = initialise_part(80, 100),v= 0.1,duration = 200)
  }
  
  # calculate mean
  mea_richness = apply(sp_richness, 2, mean)
  mea_richness_min = apply(sp_richness_min, 2, mean)
  mea_richness_20 = apply(sp_richness_20, 2, mean)
  mea_richness_40 = apply(sp_richness_40, 2, mean)
  mea_richness_60 = apply(sp_richness_60, 2, mean)
  mea_richness_80 = apply(sp_richness_80, 2, mean)
  # draw mean species richness for different initial diversity
  plot(seq(1,201,1),mea_richness,type = "line", col = "red", xlim = range(0:200),ylim = range(0:100), lwd = 1,main = "mean species richness for range of initial diversity",xlab = "generation", ylab = "mean species richness")
  points(seq(1,201,1),mea_richness_min,type = "line", col = "green",  lwd = 1)
  points(seq(1,201,1),mea_richness_20,type = "line", col = "brown",  lwd = 1)
  points(seq(1,201,1),mea_richness_40,type = "line", col = "blue",  lwd = 1)
  points(seq(1,201,1),mea_richness_60,type = "line", col = "yellow",  lwd = 1)
  points(seq(1,201,1),mea_richness_80,type = "line", col = "black",  lwd = 1)
  # add legend
  legend("top", inset = .05, c("species richness max","species richness min", "species richness 20", "species richness 40","species richness 60","species richness 80"), col = c("red","green","brown","blue","yellow","black"), lwd = c(1,1,1,1,1,1))
}

#20. question 20
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


# Challenge C
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

#23. chaos game 
chaos_game = function()
{
  A = c(0,0)
  B = c(3,4)
  C = c(4,1)
  X = c(0,0)
  point_list = list(A,B,C)
  plot(0:4,0:4,type = "n")
  
  for ( i in 1:10000)
  {
    points(X[1],X[2],cex = 0.1)
    poi = unlist(sample(point_list,1))
    X[1] = (X[1]+poi[1])/2
    X[2] = (X[2]+poi[2])/2
  }
}

#challenge E
challenge_E = function()
{
  # equilateral triangle
  A = c(0,0)
  B = c(2,2*3^0.5)
  C = c(4,0)
  X = c(0,0)
  point_list = list(A,B,C)
  plot(0:4,0:4,type = "n")
  
  for ( i in 1:10000)
  {
    points(X[1],X[2],cex = 0.1)
    poi = unlist(sample(point_list,1))
    X[1] = (X[1]+poi[1])/2
    X[2] = (X[2]+poi[2])/2
  }
  
  # different initial point
  
  A = c(0,0)
  B = c(3,4)
  C = c(4,1)
  X = c(1,3.5)
  point_list = list(A,B,C)
  plot(0:4,0:4,type = "n")
  
  for ( i in 1:10000)
  {
    if (i < 500)
    {
      points(X[1],X[2],cex = 0.1,col = "red")
    }
    else{
      points(X[1],X[2],cex = 0.1)
    }
    
    poi = unlist(sample(point_list,1))
    X[1] = (X[1]+poi[1])/2
    X[2] = (X[2]+poi[2])/2
  }
  
  # different movement distance
  A = c(0,0)
  B = c(3,4)
  C = c(4,1)
  X = c(0,0)
  point_list = list(A,B,C)
  plot(0:4,0:4,type = "n")
  
  for ( i in 1:10000)
  {
    points(X[1],X[2],cex = 0.1)
    poi = unlist(sample(point_list,1))
    X[1] = (X[1]+poi[1])/3
    X[2] = (X[2]+poi[2])/3
  }
  
  # different movement distance
  A = c(0,0)
  B = c(3,4)
  C = c(4,1)
  X = c(0,0)
  point_list = list(A,B,C)
  plot(0:4,0:4,type = "n")
  
  for ( i in 1:10000)
  {
    points(X[1],X[2],cex = 0.1)
    poi = unlist(sample(point_list,1))
    # why distance 1.5 is like chaos
    X[1] = (X[1]+poi[1])/1.5
    X[2] = (X[2]+poi[2])/1.5
  }
}

#23. creating draw function called turtle
turtle = function(st_posi,direc,len)
{
  end_posi = c(NA,NA)
  end_posi[1] = st_posi[1] + len*cos(direc)
  end_posi[2] = st_posi[2] + len*sin(direc)
  X = c(st_posi[1],end_posi[1])
  Y = c(st_posi[2],end_posi[2])
  lines(X,Y)
  return(end_posi)
}

#24. draw elbow
elbow = function(st_posi,direc,len)
{
  end_posi = turtle(st_posi,direc,len)
  turtle(end_posi,direc-pi/4,0.95*len)
}

#25. draw spiral
spiral = function(st_posi,direc,len)
{
  st_posi = turtle(st_posi,direc,len)
  spiral(st_posi,direc-pi/4,0.95*len)
}

#26. draw spiral
spiral_2 = function(st_posi,direc,len)
{
  if (len > 0.01)
  {
    st_posi = turtle(st_posi,direc,len)
    spiral_2(st_posi,direc-pi/4,0.95*len)
  }
}

#27. draw tree
tree = function(st_posi,direc,len)
{
  if (len > 0.01)
  {
    st_posi = turtle(st_posi,direc,len)
    tree(st_posi,direc+pi/4,0.65*len)
    tree(st_posi,direc-pi/4,0.65*len)
  }
}

#28. draw fern
fern = function(st_posi,direc,len)
{
  if (len > 0.01)
  {
    st_posi = turtle(st_posi,direc,len)
    fern(st_posi,direc+pi/4,0.38*len)
    fern(st_posi,direc,0.87*len)
  }
}

#29. draw fern
fern_2 = function(st_posi,direc,len,dir)
{
  if (len > 0.01)
  {
    st_posi = turtle(st_posi,direc,len)
    fern_2(st_posi,direc+dir*(pi/4),0.38*len,dir*(-1))
    fern_2(st_posi,direc,0.87*len,dir*(-1))
  }
}


# challenge F
# color turtle 
turtle_color = function(st_posi,direc,len)
{
  end_posi = c(NA,NA)
  end_posi[1] = st_posi[1] + len*cos(direc)
  end_posi[2] = st_posi[2] + len*sin(direc)
  X = c(st_posi[1],end_posi[1])
  Y = c(st_posi[2],end_posi[2])
  if (len > 0.1)
  {
    lines(X,Y,col="red")
  }
  else if (len <= 0.05)
  {
    lines(X,Y,col="green" )
  }
  return(end_posi)
}

# color tree
challenge_F = function(st_posi,direc,len)
{
  if (len > 0.01)
  {
    st_posi = turtle_color(st_posi,direc,len)
    challenge_F(st_posi,direc+pi/6,0.7*len)
    challenge_F(st_posi,direc-pi/6,0.7*len)
  }
}

#Draw color fern
challenge_F2 = function(st_posi,direc,len,dir)
{
  if (len > 0.01)
  {
    st_posi = turtle_color(st_posi,direc,len)
    challenge_F2(st_posi,direc+dir*(pi/4),0.38*len,dir)
    challenge_F2(st_posi,direc-pi/400,0.87*len,dir*(-1))
  }
}

#Barnsley fern
challenge_F3 = function()
{
  A = c(0.5,0)
  plot(0:1,0:1,type = "n")
  for (i in 1:10000)
  {
    points(A[1],A[2],cex = 0.1)
    x = runif(1,0,1)
    
    if (x >= 0 && x <= 0.02)
    {
      A[1] = 0.5
      A[2] = 0.27*A[2]
    }
    else if (x> 0.02 && x <= 0.17)
    {
      A[1] = -0.139*A[1]+0.263*A[2]+0.57
      A[2] = 0.246*A[1]+0.224*A[2]-0.036
    }
    else if (x> 0.17 && x <= 0.30)
    {
      A[1] = 0.17*A[1]-0.215*A[2]+0.408
      A[2] = 0.222*A[1]+0.176*A[2]+0.0893
    }
    else if (x> 0.3 && x <= 1)
    {
      A[1] = 0.781*A[1]+0.034*A[2]+0.1075
      A[2] = -0.032*A[1]+0.739*A[2]+0.27
    }
  }
}

