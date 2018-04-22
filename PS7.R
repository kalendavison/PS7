# Kalen Davison
# Professor Montgomery
# Due 4/26/18

library(dplyr)
library(ggplot2)
setwd("/Users/kalendavison/Desktop/Applied Statistical Programming/GitHub/PS7")
crime_data = read.csv("March2018.csv")

#2)
substr(c)
crime_data = crime_data %>%
  group_by(Description)  %>%
  summarise(total=n())
crime_data = mutate(crime_data, crimes_per_day = (total/31))


#3)
neighborhood_crime <- crime_data %>% 
  group_by(Neighborhood) %>% 
  summarise(total=n())
neighborhood_crime<-mutate(neighborhood_crime, crimes_per_day=(total/31))
neighborhood_crime<-select(neighborhood_crime, Neighborhood, crimes_per_day)

neighborhood_crime %>%
  summarise(max(crimes_per_day))
  

  

#For this problem set, you will need to use dplyr and ggplot2 R packages to summarize a given dataset and create an appropriate visualization. You will
#have to only use the functions within dplyr (ex. filter(),select(),summarise(), and mutate()) and pipe operator (%>%) to work with data. Please complete
#the following tasks in order:
 # 1. Go to this link and download March2018 crime dataset: http://www. slmpd.org/Crimereports.shtml
#2. Compute the number of crimes per day by the type of crime (Hint: clean Description variable and use it). 
#Which types of crime happened the most in March?
#3. Compute the number of crime per day by neighborhood. Which neigh- borhood has the most number of crime?

#4. Compute the proportion of crime related to robbery by district. Which district has the largest proportion of crime related to robbery?
#5. Visualize changes of all types of crime over time using ggplot2. Write appropriate labels and titles.
#6. Visualize changes of all types of crime over time by district using ggplot2. Choose different color to indicate each district. Write ap- propriate legend, labels and titles.