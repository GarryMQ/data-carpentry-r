#### dplr and tidyr ####

#import data ###

library(tidyverse)

interviews <- read_csv("data/SAFI_clean.csv", na="NULL")

#Data frame with three columns ##
select(interviews, village,  no_membrs, years_liv)

select(interviews, village:rooms)

####filtering is where you select rows #####
#give me all the information on village that relates to the village of 'God' ##

filter(interviews, village == "God")

filter(interviews, village == "God", rooms > 2)
