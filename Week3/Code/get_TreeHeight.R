# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

TreeHeight <- function(degrees, distance){
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  print(paste("Tree height is:", height))
  
  return (height)
}

# get the argument from command line
args=commandArgs()
MyData <- read.csv(args[6], header = TRUE) # import with headers
Tree.Height.m = array(0,dim(MyData[1]))
for (i in 1:dim(MyData)[1])
{
  Tree.Height.m[i]=TreeHeight(MyData[i,3],MyData[i,2])
}

# combine the dataframe and new height data
MyData=cbind(MyData,Tree.Height.m)

#extract the file name without suffix and path
File_name = substr(basename(args[6]),1,nchar(basename(args[6]))-4)

# output the dataframe with height column to InputFileName_treeheights.csv file
write.csv(MyData, paste("../Results/",File_name,"_treeheights.csv"),row.names = FALSE) # write row names
