#!/usr/bin/python
""" This script is to load the csv file and do symbolic regression,
Author: YuHeng Wang (yuheng.wang18@imperial.ac.uk) """



import csv
import scipy as sc
import numpy as np 
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import sklearn
from gplearn import genetic
from sklearn.model_selection import train_test_split
from sklearn import preprocessing
import sys
#from IPython.display import Image
import pydotplus

# load file
with open("../Data/ParameciumIsolation.csv") as f:
    reader = csv.reader(f)
    grow_curve = []
    for item in reader:
        if reader.line_num == 1:
            continue
        grow_curve.append(item)

# print(grow_curve)

#change list to array
grow_curve = sc.array(grow_curve)
grow_curve = grow_curve.astype(np.float64)
# print(grow_curve)

# normalise
min_max_scaler = preprocessing.MinMaxScaler()
grow_curve = min_max_scaler.fit_transform(grow_curve)



# split the dataset into training set and test set 
grow_curve_train, grow_curve_test = train_test_split(grow_curve, test_size = 0.3, random_state = 0)

# print(grow_curve_test)
# print(grow_curve_train)

# Using Symbolic regression
sym_fit = genetic.SymbolicRegressor(population_size=6000, generations=25, 
                                    tournament_size=20, stopping_criteria=0.003, 
                                    const_range=(-1.0, 1.0), init_depth=(3, 6), 
                                    init_method='half and half', function_set=('add', 'sub', 'mul', 'div'), 
                                    metric='mse', parsimony_coefficient= 0.0005, 
                                    p_crossover=0.7, p_subtree_mutation=0.08, p_hoist_mutation=0.07, 
                                    p_point_mutation=0.1, p_point_replace=0.05, max_samples=0.95, 
                                    warm_start=False, n_jobs=1, verbose=1, random_state= 0)

savedStdout = sys.stdout  #save output stream 


print("Please wait for about 3 minutes")
# output log data to file
with open('../Data/regression_log.csv', 'w+') as file: 
    sys.stdout = file  
    sym_fit.fit(grow_curve_train[:,1:3], grow_curve_train[:,3])
    
sys.stdout = savedStdout  

# sort data with fitness
est_fit = sorted(sym_fit._programs[-1], key=lambda x: x.fitness_)


# save the result to list
pro_depth = []
for depth in est_fit:
    pro_depth.append(depth.depth_)

pro_raw_fitness = []
for i in est_fit:
    pro_raw_fitness.append(i.raw_fitness_)

pro_oob_fitness = []
for i in est_fit:
    pro_oob_fitness.append(i.oob_fitness_)

pro_fitness = []
for i in est_fit:
    pro_fitness.append(i.fitness_)

pro_length = []
for i in est_fit:
    pro_length.append(i.length_)

#combine the list
result_mat = [pro_depth,pro_length,pro_fitness,pro_raw_fitness,pro_oob_fitness]

# output the result to csv file
with open("../Data/sym_result.csv","w") as g:
    csvwrite = csv.writer(g)
    for row in result_mat:
        csvwrite.writerow(row)

print(sym_fit._program)
print(sym_fit._program.fitness_)
print(sym_fit._program.raw_fitness_)
print(sym_fit._program.oob_fitness_)
score_gp = sym_fit.score(grow_curve_test[:,1:3], grow_curve_test[:,3])

y_gp = sym_fit.predict(grow_curve[:,1:3])

graph = sym_fit._program.export_graphviz()
graph = pydotplus.graph_from_dot_data(graph)
graph.write_pdf('../Results/Syntax_tree.pdf')


# using decision tree and random forest
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.datasets import make_regression
# fit dision tree
tree_fit = DecisionTreeRegressor(criterion='mse', max_depth=None, max_features=None,
                                max_leaf_nodes=None, min_impurity_decrease=0.0,
                                min_impurity_split=None, min_samples_leaf=1,
                                min_samples_split=2, min_weight_fraction_leaf=0.0,
                                presort=False, random_state= 0,  splitter='best')
tree_fit.fit(grow_curve_train[:,1:3], grow_curve_train[:,3])

score_tree = tree_fit.score(grow_curve_test[:,1:3], grow_curve_test[:,3])

y_tree = tree_fit.predict(grow_curve[:,1:3])


#fit random forest
rf_fit = RandomForestRegressor(bootstrap=True, criterion='mse', max_depth=None,
                                max_features='auto', max_leaf_nodes=None,
                                min_impurity_decrease=0.0, min_impurity_split=None,
                                min_samples_leaf=1, min_samples_split=2,
                                min_weight_fraction_leaf=0.0, n_estimators=10, n_jobs=None,
                                oob_score=False, random_state= 0, verbose=0, warm_start=False)
rf_fit.fit(grow_curve_train[:,1:3], grow_curve_train[:,3])

score_rf = rf_fit.score(grow_curve_test[:,1:3], grow_curve_test[:,3])

y_rf = rf_fit.predict(grow_curve[:,1:3])


# Draw the fitting picture
fig = plt.figure(figsize=(12, 10))

for i, (y, score, title) in enumerate([(grow_curve[:,3], None, "Ground Truth"),(y_gp, score_gp, "SymbolicRegressor"),(y_tree, score_tree, "DecisionTreeRegressor"),(y_rf, score_rf, "RandomForestRegressor")]):
    ax = fig.add_subplot(2, 2, i+1, projection='3d')
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    surf = ax.plot_trisurf(grow_curve[:, 1], grow_curve[:, 2], y)
    points = ax.scatter(grow_curve[:,1], grow_curve[:,2], grow_curve[:,3],c = "r")
    if score is not None:
        score = ax.text(-.7, 1, .2, "$R^2 =\/ %.6f$" % score, 'x', fontsize=14)
    plt.title(title)
plt.savefig("../Results/gp_vs_rf_dt.pdf")


