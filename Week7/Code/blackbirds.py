import re
import scipy as sc
""" This script is to find kingdom, phylum, species for all species in dataset,
Author: YuHeng Wang (yuheng.wang18@imperial.ac.uk) """


# Read the file
f = open('../Data/blackbirds.txt', 'r')
text = f.read()
f.close()

# remove \t\n and put a space in:
text = text.replace('\t',' ')
text = text.replace('\n',' ')

# note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform
# to ASCII:
text = text.encode('ascii', 'ignore').decode() #will not work in python 3

# Now extend this script so that it captures the Kingdom, 
# Phylum and Species name for each species and prints it out to screen neatly.

# Hint: you may want to use re.findall(my_reg, text)...
# Keep in mind that there are multiple ways to skin this cat! 
# Your solution may involve multiple regular expression calls (easier!), or a single one (harder!)




# find them seperately
find_kin = sc.array(re.findall(r'Ki\w+\s+\w+',text))
find_phy = sc.array(re.findall(r'Ph\w+\s+\w+',text))
find_spe = sc.array(re.findall(r'Sp\w+\s+\w+\s+\w+',text))

#combine the results
find_match = sc.concatenate((find_kin,find_phy,find_spe),axis=0).reshape(3,4)
print(find_match)