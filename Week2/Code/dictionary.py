""" This script is to combine the same order in list and form a dictionary,
Author: Wang YuHeng (yuheng.wang18@imperial.ac.uk) """

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa. 
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc. 

# ANNOTATE WHAT EVERY BLOCK OR IF NECESSARY, LINE IS DOING! 

# ALSO, PLEASE INCLUDE A DOCSTRING AT THE BEGINNING OF THIS FILE THAT 
# SAYS WHAT THE SCRIPT DOES AND WHO THE AUTHOR IS

# Write your script here:

# creat an empty dictionary
taxa_dic={}

# seperate the species and order 
for species, order in taxa:
# if key not exist, building it, otherwise appending the key
        if order not in taxa_dic:
                taxa_dic[order] = [species]
        else: 
                taxa_dic[order].append(species)
print(taxa_dic)


# another solution

# # extract the label of species and combine it 
# label = list(set(list(species[1] for species in taxa)))
# # put every thing in dictionary
# for name in label:
#         for species in taxa:
#                 if species[1] == name:
#                         if name not in taxa_dic:
#                                taxa_dic[name]=[species[0]] ##used to be error because lack []
#                         else:
#                                 taxa_dic[name].append(species[0])
# print(taxa_dic)