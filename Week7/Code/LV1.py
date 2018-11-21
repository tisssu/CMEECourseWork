#!/user/bin/env python3

""" This script is to do integrate in the Lotka_Volterra model and plot the relation between consumer and resource,
Author YuHeng Wang (yuheng.wang18@imperial.ac.uk) """

import scipy.integrate as integrate
import scipy as sc

def dCR_dt(pops, t=0):
    """ This function is equation of Lotka-Volterra model""" 
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return sc.array([dRdt, dCdt])

type(dCR_dt)

r = 1.
a = 0.1 
z = 1.5
e = 0.75

t = sc.linspace(0, 15,  1000)
R0 = 10
C0 = 5 
RC0 = sc.array([R0, C0])

pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
pops
type(infodict)

infodict.keys()

infodict['message']

import matplotlib.pylab as p 
f1 = p.figure()

p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
f1.savefig('../Results/LV_model1.pdf')

f2 = p.figure()
p.plot(pops[:,0],pops[:,1],'r-')
p.grid()
p.xlabel("Resource density")
p.ylabel("Consumer density")
p.title("Consumer-Resource population dynamics")
f2.savefig("../Results/LV_model2.pdf")

print("The final resource density is ",  pops[-1,0])
print("THe final consumer density is ",  pops[-1,1])