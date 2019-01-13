rm(list = ls())
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
plot(0:4,0:4,type = "n")
turtle(c(2,1),pi/2,2)

#24. draw elbow
elbow = function(st_posi,direc,len)
{
  end_posi = turtle(st_posi,direc,len)
  turtle(end_posi,direc-pi/4,0.95*len)
}
plot(0:4,0:4,type = "n")
elbow(c(2,1),pi/2,2)

#25. draw spiral
spiral = function(st_posi,direc,len)
{
  st_posi = turtle(st_posi,direc,len)
  spiral(st_posi,direc-pi/4,0.95*len)
}
plot(0:4,0:4,type = "n")
spiral(c(2,1),pi/2,1)

#26. draw spiral
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

plot(0:4,0:4,type = "n")
tree(c(2,1),pi/2,1)

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

plot(0:12,0:12,type = "n")
fern(c(6,3),pi/2,1)

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
plot(0:12,0:12,type = "n")
fern_2(c(6,3),pi/2,1,1)

#29. draw fern
fern_2 = function(st_posi,direc,len,dir)
{
  if (len > 0.01)
  {
    st_posi = turtle(st_posi,direc,len)
    fern_2(st_posi,direc+dir*(pi/4),0.38*len,dir)
    fern_2(st_posi,direc,0.87*len,dir*(-1))
  }
}
plot(0:12,0:12,type = "n")
fern_2(c(6,3),pi/2,1,1)

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




#chanllege question F. color turtle
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
plot(0:4,0:4,type = "n")
turtle_color(c(2,1),pi/2,2)

#chanllege question F. draw color tree
challenge_F = function(st_posi,direc,len)
{
  if (len > 0.01)
  {
    st_posi = turtle_color(st_posi,direc,len)
    tree(st_posi,direc+pi/6,0.7*len)
    tree(st_posi,direc-pi/6,0.7*len)
  }
}

plot(-1:5,-1:5,type = "n")
challenge_F(c(2,1),pi/2,1)

#chanllege question F : Draw color fern
challenge_F2 = function(st_posi,direc,len,dir)
{
  if (len > 0.01)
  {
    st_posi = turtle_color(st_posi,direc,len)
    challenge_F2(st_posi,direc+dir*(pi/4),0.38*len,dir)
    challenge_F2(st_posi,direc-pi/400,0.87*len,dir*(-1))
  }
}
plot(0:12,0:12,type = "n")
challenge_F2(c(6,3),pi/2,1,1)


#chanllege question G 
A = c(.5,0)
plot(0:1,0:1,type = "n")
for (i in 1:1000)
{
  points(A[1],A[2],cex = 0.1)
  x = runif(1)
  
  if (x < .3)
  {
    A[1] = 0.17*A[1]-0.215*A[2]+0.408
    A[2] = 0.222*A[1]+0.176*A[2]+0.0893
  }
  else if (x>= .3)
  {
    A[1] = 0.781*A[1]+0.034*A[2]+0.1075
    A[2] = -0.032*A[1]+0.739*A[2]+0.27
  }
}

g = function(s, d, l, c)
{
  if(l > .01)
  {
  e = c(0,0)
  e[1] = s[1] + l*cos(d)
  e[2] = s[2] + l*sin(d)
  X = c(s[1],e[1])
  Y = c(s[2],e[2])
  lines(X,Y)
  s = e
  g(s, d + c * pi/4, .4*l, c)
  g(s, d, .8*l, -1 *c )
  }
}
plot(0:6,0:6, type = "n")
g(c(3,1),pi/2,1,1)



turtle = function(st_posi,direc,len)
{
  if (len > 0.01)
  {
  end_posi = c(NA,NA)
  end_posi[1] = st_posi[1] + len*cos(direc)
  end_posi[2] = st_posi[2] + len*sin(direc)
  X = c(st_posi[1],end_posi[1])
  Y = c(st_posi[2],end_posi[2])
  lines(X,Y)
  st_posi = end_posi
  turtle(st_posi,direc+ (pi/4),0.38*len)
  turtle(st_posi, direc, 0.87*len)
  }
}
plot(0:12,0:12,type = "n")
turtle(c(6,3),pi/2,1)
