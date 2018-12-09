rm(list = ls())
graphics.off()
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

# equilateral triangle
rm(list = ls())
graphics.off()
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
rm(list = ls())
graphics.off()
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
rm(list = ls())
graphics.off()
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
  X[1] = (X[1]+poi[1])/3
  X[2] = (X[2]+poi[2])/3
}




