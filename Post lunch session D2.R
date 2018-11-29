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
# this has added new column to the interviews data set ####

interviews <- interviews %>% mutate(people_per_room = no_membrs/rooms)


# want the average number per household
# does not tell you if there are differences between villages ##
mean(interviews$no_membrs)

#so, there needds to be group_by ###
# varaible that distonguished between differnet groups
# shows as grouped by village

interviews %>% group_by(village)

# take grup data and pass through summarize

interviews %>%
  group_by(village) %>%
  summarize(mean_no_membrs = mean(no_membrs))

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs))

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs),
            min_membrs = min(no_membrs))

##### conunt how many entries - count how often you see different values for village #####

interviews %>%
  count(village)     

#if you want the count to be from largest to smallest ###
interviews %>% count(village, sort = TRUE)


###################### EXERCISE ##################

interviews %>%
  group_by(village) %>%
  summarize(mean_no_membrs = mean(no_membrs))

interviews %>%
  group_by(village) %>%
  summarize(mean_no_membrs = min(no_membrs))

interviews %>%
  group_by(village) %>%
  summarize(mean_no_membrs = max(no_membrs))

## in summary you can add n ####

interviews %>% group_by(village) %>%
  summarise (mean_membrs = mean (no_membrs),
            min_membrs=min(no_membrs),
            max_membrs = max(no_membrs),
            n=n())

################### After afternoon tea ################

# Reshaping - wall type might want to have one colum for this respondent or not. 

# tidyverse uses spread, then the key column, and that is the colum that will provide with the names of the new we want to create - to hold information for the new count, then another column that holds the data you want to spread out to. So what we are talking about and what is associaed with the value. Each occurance will be translated into TRUE. With mutated data frame, we can use this as value

interviews <- interviews %>%
  mutate(wall_type_logical = TRUE) %>%
  spread(key = respondent_wall_type, value = wall_type_logical, fill = FALSE)

# to undo the above, use gather ####
# will ask for a key column which will be the names of the column to create - to complress into a single column - going to be called respondent wall type - which od the three that was true

# burnt briacks to sunbriack captires all of them

interviews <- interviews_spread %>%
  gather(key = respondent_wall_type, value = "wall_type_logical",
         burntbricks:sunbricks)
 #### each respondent now has 4 entries for the wall-type ####

### reshaping is good for reprganising the data
# you might it want it in a differentt form from analysis to presentaiton ####

################# PRESENTATION  #####################

interviews <- read_csv("data/SAFI_clean.csv", na="NULL")

#Items owned  - not useful for plotting, so needed to split up with mutuate #
interviews_items_owned <- interviews %>%
  mutate(split_items = strsplit(items_owned, ";")) %>%
  unnest() %>%
  mutate(items_owned_logical=TRUE) %>%
  spread(key = split_items, value = items_owned_logical, fill = FALSE) %>%
  rename(no_listed_items= '<NA>') %>%
  mutate(split_months=strsplit(months_lack_food, ";")) %>%
  unnest() %>%
  mutate(months_lack_food_logical=TRUE) %>%
  spread(key=split_months, value=months_lack_food_logical, fill=FALSE) %>%
  mutate(number_month_lack_food=rowSums(select(., Apr:Sept))) %>%
  mutate(number_items=rowSums(select(.,bicycle:television)))

#########
### write_csv(interviews_plotting, )


            