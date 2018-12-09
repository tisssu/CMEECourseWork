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
plot(0:4,0:4,type = "n")
turtle(c(2,1),pi/2,2)

# draw elbow
elbow = function(st_posi,direc,len)
{
  end_posi = turtle(st_posi,direc,len)
  turtle(end_posi,direc-pi/4,0.95*len)
}
plot(0:4,0:4,type = "n")
elbow(c(2,1),pi/2,2)

# draw spiral
spiral = function(st_posi,direc,len)
{
  st_posi = turtle(st_posi,direc,len)
  spiral(st_posi,direc-pi/4,0.95*len)
}
plot(0:4,0:4,type = "n")
spiral(c(2,1),pi/2,1)

# draw spiral
spiral_2 = function(st_posi,direc,len)
{
  if (len > 0.01)
  {
  st_posi = turtle(st_posi,direc,len)
  spiral_2(st_posi,direc-pi/4,0.95*len)
  }
}
plot(0:4,0:4,type = "n")
spiral_2(c(2,1),pi/2,1)


# draw tree
tree = function(st_posi,direc,len)
{
  if (len > 0.01)
  {
    st_posi = turtle(st_posi,direc,len)
    tree(st_posi,direc+pi/4,0.65*len)
    tree(st_posi,direc-pi/4,0.65*len)
  }
}

plot(0:4,0:4,type = "n")
tree(c(2,1),pi/2,1)

# draw fern
fern = function(st_posi,direc,len)
{
  if (len > 0.01)
  {
    st_posi = turtle(st_posi,direc,len)
    fern(st_posi,direc+pi/4,0.38*len)
    fern(st_posi,direc,0.87*len)
  }
}

plot(0:4,0:4,type = "n")
fern(c(2,1),pi/2,1)

# draw fern
fern_2 = function(st_posi,direc,len)
{
  if (len > 0.01)
  {
    st_posi = turtle(st_posi,direc,len)
    fern(st_posi,direc+pi/4,0.38*len)
    fern(st_posi,direc,0.87*len)
  }
}

plot(0:4,0:4,type = "n")
fern(c(2,0),pi/2,1)


