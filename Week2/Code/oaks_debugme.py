#!/user/bin/env python3

""" This script is to test the function of is_an_oak, listing all of the species and finding the oak,
Author: Wang YuHeng (yuheng.wang18@imperial.ac.uk)  """

import csv
import sys
import doctest
import re
#Define function
def is_an_oak(name):
    
    """ find whether a species is an oak
    >>> is_an_oak('Fagus sylvatica')
    False
    
    >>> is_an_oak('quercus')
    True
    
    >>> is_an_oak('Quercus')
    True

    >>> is_an_oak('quercuss')
    False

    """  
  
    return name.lower().endswith("quercus",) #bug is wrong spelling of quercus/  ##improving non-strict match with regexp.
""" Returns True if name is starts with 'quercus' """ 
   
""" main function to find the oak and list the species"""
def main(argv): 
    f = open('../Data/TestOaksData.csv','r')
    g = open('../Data/JustOaksData.csv','w')
    next(f)
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    csvwrite.writerow(["Ginus"," Species"])
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod()