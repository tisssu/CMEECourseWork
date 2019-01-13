rm(list = ls())
graphics.off()

community = c(1,4,4,5,5,3,4,5,7)

# 1.calculate species richness
species_richness = function(community)
{
  return(length(unique(community)))
}

species_richness(community)


# 2.generate initial state of maximum species

initialise_max = function(size)
{
  return(seq(size))
}

initialise_max(7)

# 3.generate initial state of minium species

initialise_min = function(size)
{
  return(array(1,size))
}

initialise_min(4)

# 4.generte 2 vector uniform distribution
choose_two = function(x)
{
  return(sample.int(x,size = 2, replace = F))
}

choose_two(4)

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

neutral_step(c(10,5,13))

# 6.simulate several neutral steps 
neutral_generation = function(community)
{
  for (i in 1:round(length(community)/2))
  {
    community = neutral_step(community)
  }
  return(community)
}

neutral_generation(c(10,13,4))

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
neutral_time_series(initial = initialise_max(7),duration = 20)


# 8.plot species richness with generation
question_8 = function()
{
  generation = seq(201)
  plot(generation,neutral_time_series(initial = initialise_max(100),duration = 200),xlab = "generation",ylab = "species_richness",main = "neutral_time_series")
}
question_8()

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

neutral_step_speciation(c(10,13,5),0.2)

# 10.perform neutral generation with speciation
neutral_generation_speciation = function(community,v)
{
  for (i in 1:round(length(community)/2))
  {
    community = neutral_step_speciation(community,v)
  }
  return(community)
}

neutral_generation_speciation(c(10,13,5),0.2)

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
neutral_time_series_speciation(community = initialise_max(7),v= 0.2,duration = 20)

 # 12.plot species richness with generation, including speciation 
question_12 = function()
{
  generation = seq(201)
  plot(generation,neutral_time_series_speciation(community = initialise_max(100),v = 0.1,duration = 200),col="blue",pch=19,cex= 0.5 ,xlab = "generation",ylab = "species_richness",main = "neutral_time_series_speciation")
  points(generation,neutral_time_series_speciation(community = initialise_min(100),v = 0.1,duration = 200),col="red",pch = 19,cex = 0.4)
}
question_12()

# 13.species abundance
species_abundance = function(community)
{
  abundance = sort(as.numeric(table(community)),decreasing = T)
  return(abundance)
}
species_abundance(c(1,3,4,4,5,6,6,9))

# 14.bin the abundance of species
octaves = function(abundance)
{
  abundance = floor(log2(sort(abundance)))
  bin = tabulate(abundance+1)
  return(bin)
}
octaves(c(100,64,63,6,5,4,3,2,2,2,1,1,1,1,1))

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
sum_vect(c(21,13,11,6,1),c(9,11,7,1,2,0))

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
  return(time)
}
question_16()

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
  
challenge_A()

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

challenge_B()













