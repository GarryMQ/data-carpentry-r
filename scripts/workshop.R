## Use this file to follow along with the live coding exercises.
## The csv file containing the data is in the 'data/' directory.
## If you want to save plots you created, place them in the 'figures/' directory.
## You can create additional R files in the 'scripts/' directory.

library(tidyverse)

# to get the data from csv file ##
##need to tell R waht missing values look like - they are coded as NULL - it is good to say what you are thinking missing values are#

interviews <- read_csv("data/SAFI_clean.csv", na="NULL")

#read csv2 for differnt file where comma is not the separator ##
# data was imported and it made assumptions about what the data type is - as can be seen they are col_character ###

interviews

as.data.frame(interviews)

# this is for a speadsheet view of the data in a new tab 
# Can be useful to explore the data##
View(interviews)

