
""" This script is made to filter months that raining greater than 100, or less than 50 seperately, 
using conventional loops and list comprehension.
Author : Wang YuHeng (yuheng.wang18@imperial.ac.uk)"""

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
 
# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

# ANNOTATE WHAT EVERY BLOCK OR IF NECESSARY, LINE IS DOING! 

# ALSO, PLEASE INCLUDE A DOCSTRING AT THE BEGINNING OF THIS FILE THAT 
# SAYS WHAT THE SCRIPT DOES AND WHO THE AUTHOR IS

## list comprehension 
# month and rainfall tuple with rainfall greater than 100 mm.
rainfall_largerthan100_lc = list (month for month in rainfall if month[1]>100)
print(rainfall_largerthan100_lc)

# month with rain less than 50 mm
rainfall_lessthan50_lc = list (month[0] for month in rainfall if month[1]<50)
print(rainfall_lessthan50_lc)

## conventional loops 
# month and rainfall tuple with rainfall greater than 100 mm.
rainfall_largerthan100_loops = list()
for month in rainfall:
    if month[1]>100:
        rainfall_largerthan100_loops.append(month)
print(rainfall_largerthan100_loops)

# month with rain less than 50 mm
rainfall_lessthan50_loops = list()
for month in rainfall:
    if month[1]<50:
        rainfall_lessthan50_loops.append(month[0])
print(rainfall_lessthan50_loops)
