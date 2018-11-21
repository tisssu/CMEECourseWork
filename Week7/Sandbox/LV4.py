#!/user/bin/env python3

""" This script is to do integrate in the Lotka_Volterra model with prey density dependence and plot the relation between consumer and resource,
Author YuHeng Wang (yuheng.wang18@imperial.ac.uk) """

import scipy.integrate as integrate
import scipy as sc
import sys
import scipy.stats


r = 1.
a = 0.1
z = 1.5
e = 0.75
K = 1000000000

R = 10
C = 5 
t = 15

pops = sc.zeros((t+1,2))
pops[0,0] = R
pops[0,1] = C

for i in range(t):
    R_t = R
    C_t = C
    R = R_t *  (1 + scipy.stats.norm.rvs(size = 1) + r*(1 - R_t/K) - a * C_t)
    pops[i+1,0] = R
    C = C_t*(1-z + e*a*R_t + scipy.stats.norm.rvs(size = 1))
    pops[i+1,1] = C

t = sc.arange(16)

# import matplotlib.pylab as p 
# f1 = p.figure()

# p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
# p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
# p.grid()
# p.legend(loc='best')
# p.xlabel('Time')
# p.ylabel('Population density')
# p.title('Consumer-Resource population dynamics')
# p.text(3,20,"r="+str(r)+",a="+str(a)+",z="+str(z)+",e="+str(e)+",k="+str(K),fontsize = 12)
# f1.savefig('../Results/LV3_model1.pdf')


# f2 = p.figure()
# p.plot(pops[:,0],pops[:,1],'r-')
# p.grid()
# p.xlabel("Resource density")
# p.ylabel("Consumer density")
# p.title("Consumer-Resource population dynamics")
# p.text(3,20,"r="+str(r)+",a="+str(a)+",z="+str(z)+",e="+str(e)+",k="+str(K),fontsize = 12)
# f2.savefig("../Results/LV3_model2.pdf")

# print("The final resource density is ",  pops[-1,0])
# print("THe final consumer density is ",  pops[-1,1])