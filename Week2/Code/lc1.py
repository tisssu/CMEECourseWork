
""" This script seperate the birds list into three different lists includiong the latin names , common names and mean body masses,
with the methods of list comprehensions and conventional loops respectively.
Author: Wang YuHeng (yuheng.wang18@imperial.ac.uk) """




birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )




#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

# (2) Now do the same using conventional loops (you can shoose to do this 
# before 1 !). 

# ANNOTATE WHAT EVERY BLOCK OR IF NECESSARY, LINE IS DOING! 

# ALSO, PLEASE INCLUDE A DOCSTRING AT THE BEGINNING OF THIS FILE THAT 
# SAYS WHAT THE SCRIPT DOES AND WHO THE AUTHOR IS.


## Using for loops
# latin name lists
latin_name_loops = list()
for species in birds:
    latin_name_loops.append(species[0])
print(latin_name_loops)

# common name lists
common_name_loops = list()
for species in birds:
    common_name_loops.append(species[1])
print(common_name_loops)

# mean body mass lists
mean_body_masses_loops = list()
for species in birds:
    mean_body_masses_loops.append(species[2])
print(mean_body_masses_loops)



## Using list comprehensions
# latin name lists
latin_name_lc=list([species[0] for species in birds])
print(latin_name_lc)

# common name lists
common_name_lc=list([species[1] for species in birds])
print(common_name_lc)

# mean body masses lists
mean_body_masses_lc=list([species[2] for species in birds])
print(mean_body_masses_lc)
