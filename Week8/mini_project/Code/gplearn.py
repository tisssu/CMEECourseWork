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
x_train = sc.concatenate((Nutrient,Population),axis = 1)

#make function
gplearn.functions.make_function(expoenet, exponent, arity = 1)
def exponent(x):
    "define exponent"
    return sc.exp(x)


est_gp = SymbolicRegressor(population_size=5000, generations=20, metric = 'mse',p_crossover=0.75, \
p_subtree_mutation=0.1,p_hoist_mutation=0.05, p_point_mutation=0.05,p_reproduction = 0.05 \
max_samples=0.9, verbose=1,parsimony_coefficient='auto', random_state=0)

est_gp.fit(x_train, dp_dt)

#compare with random forest and decision tree
est_tree = DecisionTreeRegressor()
est_tree.fit(x_train, dp_dt)
est_rf = RandomForestRegressor()
est_rf.fit(x_train, dp_dt)

y_gp = est_gp.predict(np.c_[x0.ravel(), x1.ravel()]).reshape(x0.shape)
score_gp = est_gp.score(X_test, y_test)
y_tree = est_tree.predict(np.c_[x0.ravel(), x1.ravel()]).reshape(x0.shape)
score_tree = est_tree.score(X_test, y_test)
y_rf = est_rf.predict(np.c_[x0.ravel(), x1.ravel()]).reshape(x0.shape)
score_rf = est_rf.score(X_test, y_test)

fig = plt.figure(figsize=(12, 10))

for i, (y, score, title) in enumerate([(y_truth, None, "Ground Truth"),
                                       (y_gp, score_gp, "SymbolicRegressor"),
                                       (y_tree, score_tree, "DecisionTreeRegressor"),
                                       (y_rf, score_rf, "RandomForestRegressor")]):

    ax = fig.add_subplot(2, 2, i+1, projection='3d')
    ax.set_xlim(-1, 1)
    ax.set_ylim(-1, 1)
    surf = ax.plot_surface(x0, x1, y, rstride=1, cstride=1, color='green', alpha=0.5)
    points = ax.scatter(X_train[:, 0], X_train[:, 1], y_train)
    if score is not None:
        score = ax.text(-.7, 1, .2, "$R^2 =\/ %.6f$" % score, 'x', fontsize=14)
    plt.title(title)
plt.show()


