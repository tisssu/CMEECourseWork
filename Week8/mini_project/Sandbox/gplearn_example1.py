#!/usr/bin/python

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn.utils import check_random_state
from gplearn import genetic
import pickle

# x0 = np.arange(-1, 1, 1/10.)
# x1 = np.arange(-1, 1, 1/10.)
# x0, x1 = np.meshgrid(x0, x1)

# y_truth = x0**2 - x1**2 + x1 - 1
# ax = plt.figure().gca(projection='3d')
# ax.set_xlim(-1, 1)
# ax.set_ylim(-1, 1)
# surf = ax.plot_surface(x0, x1, y_truth, rstride=1, cstride=1, color='green', alpha=0.5)
# plt.show()

rng = check_random_state(0)           

# Training samples
X_train = rng.uniform(-1, 1, 100).reshape(50, 2)
y_train = X_train[:, 0]**2 - X_train[:, 1]**2 + X_train[:, 1] - 1

# Testing samples
X_test = rng.uniform(-1, 1, 100).reshape(50, 2)
y_test = X_test[:, 0]**2 - X_test[:, 1]**2 + X_test[:, 1] - 1

est_gp = genetic.SymbolicRegressor(population_size=50,
                           generations=200, stopping_criteria=0.01,
                           p_crossover=0.7, p_subtree_mutation=0.1,
                           p_hoist_mutation=0.05, p_point_mutation=0.1,
                           max_samples=0.9, verbose=1,
                           parsimony_coefficient=0.01, random_state=0)
est_gp.fit(X_train, y_train)

print(est_gp._program)

with open("../Data/programs_test", "w") as f:
    for i in est_gp._programs[-1]:
        f.write(i)
        f.write("\n")

for i in est_gp._programs[-1]:
    print(i)


print(est_trans)

est = sorted(est_gp._programs[-1], key=lambda x: x.fitness_)
est_dep = sorted(est_gp._programs[-1], key=lambda x: x.depth_)

for i in est_dep:
    print(i)



def printlist(a):
    for i in a:
        if type(i) is list:
            printlist(i)
        else:
            print (i)