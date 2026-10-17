#installed.packages("tidyverse")
#metti in markdown e in markup
#copi link della folder su github
library(tidyverse)
head(who)
#Step 1:Gather
who1<-who %>%
  pivot_longer(cols=new_sp_m014:newrel_f65,names_to="key",values_to="cases",values_drop_na=TRUE)
who1

#Step 2:replace
who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, " newrel", "new_rel"))
who2

#Step 3: separate
#1)
#Separate the values in each code with three passes of separate(). 
#First, separate key after underscore character in three new variables: 
#new, type, and sexage
#sintassi:separate(colonan che voglio dividere,into=c("nome col 1",..., "nome col n"), sep="carattere")
who3 <- who2 %>% 
  separate(key, into = c("new","type","sexage"), sep = "_")
who3

#2) Next separate sexage into sex and age by splitting after the first character:
# cambia solo il modo di separare: sep=n divide dopo il carattere n
who4 <- who3 %>% 
  separate(sexage, into = c("sex","age"), sep = 1)
who4

#3) Finally separate age into age_low and age_high by splitting after the second
#   character (first replace “014” with “0014” and “65” with “65100”):
who5 <- who4 %>% 
  mutate(age = stringr::str_replace(age, "014", "0014")) %>%
  mutate(age = stringr::str_replace(age, "65", "65100")) %>%
  separate(age, into = c("age_low","age_high"), sep = 2)
who5

#Step 4: drop
#Check that the new column is constant in this dataset. 
#Hence drop column new as well as iso2 and iso3 since they’re redundant.
# check that new is constant
who5 %>% distinct(new)

# drop redundant columns
who6 <- who5 %>% 
  select(-new, -iso2, -iso3)
who6

#Step 5: use pipe
#You have written the code a piece at a time, assigning each interim result
#to a new variable. Instead, gradually build up a complex pipe.

