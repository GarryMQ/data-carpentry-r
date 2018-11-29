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

###### create intermeduate data frame #####
interviews2 <-filter (interviews, village == "God")

#selection for the columns and store in another data frame ### - with interviews 2 as the input ###
interviews_god <- select(interviews2, no_membrs, years_liv)

interviews_god <- select(filter(interviews, village == "God"),
                         no_membrs, years_liv)

## pipe is to fllow the arrow - first is the input data set - line break needs to be after the pipe symbol - does the filtering and selecting all in one go - it is cleaner than nesting the code ##

interviews %>% filter(village == "God") %>%
  select(no_membrs, years_liv)

interviews_Chirodzo2 <- interviews %>% filter(village == "Chirodzo") %>% select(no_membrs, years_liv)


##############EXERCISE ################


#Using pipes, subset the interviews data to include interviews 

#where respondents were members of an irrigation association (memb_assoc) #and retain only the columns affect_conflicts, liv_count, and no_meals.###

interviews %>% filter(memb_assoc == "yes") %>%
  select(affect_conflicts, liv_count, no_meals)

# Want to add some new variable that is derived from others - we may want to know the average number of occupants per room - data continas how many rooms and household members, but is not expressed the way that we want - therefore mutaute - which allows us to add new columns ##

########### Mutate #####

interviews <- interviews %>% mutate(people_per_room = no_membrs/rooms)




