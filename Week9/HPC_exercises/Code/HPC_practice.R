rm(list = ls())
graphics.off()
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

# 4.generte 2 vector uniform distribution
choose_two = function(x)
{
  return(sample.int(x,size = 2, replace = F))
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

# 1.calculate species richness
species_richness = function(community)
{
  return(length(unique(community)))
}

# 3.generate initial state of minium species

initialise_min = function(size)
{
  return(array(1,size))
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

# run cluster
cluster_run = function(speciation_rate,size,wall_time,interval_rich,interval_oct,burn_in_generations,output_file_name)
{
  time_1 = proc.time()
  iters = 0
  rich_number = 0
  octa_number = 0
  octave_list = list()
  community = initialise_min(size)
  rich = c(0)
  time = 0
  time1 = proc.time()
  while (time <  wall_time) 
  {
  iters = iters + 1
  community = neutral_generation_speciation(community,speciation_rate)
  if (iters %% interval_rich  == 0 && iters <= burn_in_generations)
  {
    rich_number = rich_number+1
    rich[rich_number] = species_richness(community)
  }
  if (iters %% interval_oct == 0)
  {
    octa_number = octa_number +1
    abundance = species_abundance(community)
    octave_list[[octa_number]] = octaves(abundance)
  }
  time2 = proc.time()
  time = as.numeric(time2[3])-as.numeric(time1[3])
  }
  time_2 = proc.time()
  time_consumed = as.numeric(time_2[3]) - as.numeric(time_1[3])
  save(rich,octave_list,community,time_consumed,speciation_rate,size,wall_time,interval_rich,interval_oct,burn_in_generations,output_file_name,file = output_file_name)
}

#cluster_run(speciation_rate = 0.1,size = 100,wall_time = 60,interval_rich = 1,interval_oct = 10,burn_in_generations =200,output_file_name = "my_test_file_1.rda")
  

iter = as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
set.seed(iter)
if (iter %% 4 == 1)
{
  size = 500
} else if (iter %% 4 ==2)
{
  size = 1000
} else if (iter %% 4 ==3)
{
  size = 2500
} else if (iter %% 4 == 0)
{
  size = 5000
}
#cluster_run(speciation_rate = 0.1,size = size,wall_time = 11.5,interval_rich = 1,interval_oct = size/10,burn_in_generations = 8*size,output_file_name = paste("HPC_result_test",iter,".rda",sep = ""))
cluster_run(speciation_rate = 0.1,size = size,wall_time = 11.5 * 60 * 60,interval_rich = 1,interval_oct = size/10,burn_in_generations = 8*size,output_file_name = paste("HPC_results",iter,".rda",sep = ""))

test_iter = function(iter)
{
  if (iter %% 4 == 1)
  {
    size = 500
  } else if (iter %% 4 ==2)
  {
    size = 1000
  } else if (iter %% 4 ==3)
  {
    size = 2500
  } else if (iter %% 4 == 0)
  {
    size = 5000
  }
  cluster_run(speciation_rate = 0.1,size = size,wall_time = 11.5,interval_rich = 1,interval_oct = size/10,burn_in_generations = 8*size,output_file_name = paste("HPC_result_test",iter,".rda",sep = ""))
}
  
#test_iter(1)
#test_iter(2)
#test_iter(3)
