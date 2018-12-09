#!/usr/bin/env python3 
"""   """
import csv 
import scipy as sc
import gplearn as gp

paradata = []
with open("../Data/ParameciumIsolation.csv") as f:
    next(f)
    csvread = csv.reader(f)
    for  line in csvread:
        paradata += line

paradata = sc.array(paradata)
paradata = paradata.reshape(56,4)

time = paradata[:,0]
Nutrient = paradata[:,1]
Population  = paradata[:,2]
dp_dt = paradata[:,3]

est_gp = SymbolicRegressor(population_size=5000, generations=20, metric = 'mse',p_crossover=0.75, \
p_subtree_mutation=0.1,p_hoist_mutation=0.05, p_point_mutation=0.05,p_reproduction = 0.05 \
max_samples=0.9, verbose=1,parsimony_coefficient='auto', random_state=0)