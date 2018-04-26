# Kalen Davison
# Professor Montgomery
# Due 4/26/18

library(dplyr)
library(ggplot2)
setwd("/Users/kalendavison/Desktop/Applied Statistical Programming/GitHub/PS7")
crime_data = read.csv("March2018.csv")

#2)
install.packages("lubridate")
library(lubridate)

crime_data$date = strptime(crime_data$DateOccur, "%m/%d/%Y %H:%M")
crime_data$date = as.Date(crime_data$date, "%m/%d/%Y")
crime_data$date = as.character(crime_data$date)

crime_data = crime_data %>%
  group_by(Description, date)  %>%
  summarise(count=n())

which.max(crime_data$count)
crime_data$count[1125]
crime_data$Description[1125]

### Leaving the scene of an accident was the most common crime in March, occurring 24 times.

#3)
crime_data_neighborhood = read.csv("March2018.csv")
library(lubridate)
crime_data_neighborhood$date = strptime(crime_data_neighborhood$DateOccur, "%m/%d/%Y %H:%M")
crime_data_neighborhood$date = as.Date(crime_data_neighborhood$date, "%m/%d/%Y")
crime_data_neighborhood$date = as.character(crime_data_neighborhood$date)
crime_data_neighborhood = crime_data_neighborhood %>%
  group_by(Description, Neighborhood)  %>%
  summarise(count=n())

which.max(crime_data_neighborhood$count)
crime_data_neighborhood$count[1335] 
#Neighborhood 47 has the most crime with 1335 crimes in March.


#4)

crime_data_robbery = read.csv("March2018.csv")
crime_data_robbery = crime_data_robbery %>%
mutate(robbery = as.numeric(grepl("ROBBERY", Description, ignore.case=T)),
       District = District)

crime_data_robbery = crime_data_robbery %>%
  group_by(District) %>%
  filter(robbery == 1) %>%
  summarise(count=n())
View(crime_data_robbery)        

crime_data_district = read.csv("March2018.csv")
crime_data_district = crime_data_district %>% 
  group_by(District) %>%
  summarise(count=n())
crime_data_district = crime_data_district[2:7,]
View(crime_data_district)
proportion_robbery = crime_data_robbery$count/crime_data_district$count
which.max(proportion_robbery) #Returns indexed 5, equivalent to district 5
#District 5 has the largest proportion of crime related to robbery.



#5. Visualize changes of all types of crime over time using ggplot2. Write appropriate labels and titles.
#6. Visualize changes of all types of crime over time by district using ggplot2. Choose different color to indicate each district. Write ap- propriate legend, labels and titles.