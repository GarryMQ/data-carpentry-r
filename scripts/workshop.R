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

#inspect data - 131 rows and 14 columns #
dim(interviews)
nrow(interviews)
ncol(interviews)

# shows the first 6 rows #
head(interviews)
head(as.data.frame(interviews))
tail(as.data.frame(interviews))

# to show charachter vector of all the column names #
names(interviews)

# summary of the data - brief string represtation - brief summary - useful for dealing with complex objects - what R sees#
str(interviews)

# ask R for a summary - look at each column and summarise for you. Where you have numeric data, then it tells you the min, mean, max - this can be useful for numeric - character data - will tell you what it is#
summary(interviews)

# data frame each column is a vector, that means that each vector can only be one data type - accessing parts is accessing a vecotr - you need two coordinates#

# this gives you information for the first row and the first column #
interviews[1, 1]

interviews[1,6]

#first 5 rows of the 6th column #
interviews[1:5, 6]

#sometimes entire row or column - all the data for the first subject #
interviews[1, 1:14]

#when you dont know how many rows there are...#
interviews[1, 1:ncol(interviews)]

interviews[, 6]

#you can select more than one column #
interviews[1:6]

# you can select column by name #
interviews["respondent_wall_type"]

# you can use negative to drop vectors - this does not have the key id - you can create a smaller data frame ##

interviews[, -1]

#exercise ###
#Create a data frame (interviews_100) containing only the data in row 100 of the interviews dataset#
#give me row 100 and all the columns #

interviews_100 <- interviews[100, ]

nrow(interviews_100)

# by checking the head and the tail, I have confirmed that I've just oulled out 100 as they are both the same #

head(interviews_100)
tail(interviews_100)

nrow(interviews)

#pull our the last row using nrow #

interviews_last <- interviews[131, ]
interview_last <- interviews[nrow(interviews) ,]

##middle row ###
n_row <- nrow(interviews)

n_row
n_row/2

#if you tell to halve, how can you have row 65.5? It will treat as whole number and eliminate after the decimal#
# but what we want is 66 - so how do we get that ##
interviews[round(n_row/2) , ]

#celining will always round up #
interviews[ceiling(n_row/2),]

#first 6 give me everything except those after 7 ##
interviews[-(7:nrow(interviews)),]

###### post morning tea session ######
######################################
######################################

#special data type categorical variables - factors ##

respondent_floor_type <- factor(c("earth", "cement", "cement", "earth"))

respondent_floor_type

levels(respondent_floor_type)

#factors will convert to nmbers and only store the names of the levels"
nlevels(respondent_floor_type)

# you can specify the levels - they have been changed in order#
respondent_floor_type <- factor(respondent_floor_type, levels = c("earth", "cement"))

respondent_floor_type

# if you wanted to change cement to brick...##
levels(respondent_floor_type)[2] <- "brick"

respondent_floor_type

# where is was cement, it is now brick #

#convert back to a character and there are no levels###
###character will do things alphanetically rather than as levels - you need factors for levels ##
as.character(respondent_floor_type)

#factor for years ##
year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))

# so as you can see from the readout, it is storing them a levels in a numeric order, not as the values themselves #
as.numeric(year_fct)

# to get back, convert to character ##
as.numeric(as.character(year_fct))

as.numeric(levels(year_fct))[year_fct]

#whtehr farm has been effected by conlict
affect_conflict <- interviews$affect_conflicts
## this is the same as the $ sign ##
affect_conflict <- interviews [["affect_conflict"]]

affect_conflict <- factor(affect_conflict)
affect_conflict

#number of times each level appears in this factor ##
#notice that plot names are in alphabetical order ##
plot(affect_conflict)

affect_conflicts <- interviews$affect_conflicts

#use is.na to find missing values in the varaible. It is a subset into the new variable and assign only the missing to undertermined
affect_conflicts[is.na(affect_conflicts)] <- "undetermined"
affect_conflicts

affect_conflicts <- factor(affect_conflicts)

plot(affect_conflicts)

###### EXERCISE ##########
### wanted to change the title of level 2 which was more_once to more than once ####

levels(affect_conflicts)[2] <- "more than once"


### this was an additional test for me
levels(affect_conflicts)[3] <- "never"

plot(affect_conflicts)

### reordered the levels of the graph to place them into a relevant display - specify the order that you want them to be ####

affect_conflicts <- factor(affect_conflicts, levels = c("never", "once", "more than once", "frequently", "undetermined"))

plot(affect_conflicts)

############### Dates ####################
str(interviews)

#want to extract the year, month and date ####
library(lubridate)

dates <- interviews$interview_date
head(dates)

dates <- ymd(dates)
dates

### create a new variable into the data frame ####
# a new variable that will be day ###
interviews$day <- day(dates)
interviews$month <- month(dates)
interviews$year <- year(dates)

str(interviews)

descr(respondent_wall_type)

desc(interviews)
