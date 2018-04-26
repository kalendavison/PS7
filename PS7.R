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

#5)
plot_data = read.csv("March2018.csv") 
plot_data$date = strptime(plot_data$DateOccur, "%m/%d/%Y %H:%M")
plot_data$date = as.Date(plot_data$date, "%m/%d/%Y")
plot_data$date = as.character(plot_data$date)
plot_data = plot_data %>% 
  group_by(date) %>%
  summarise(count=n()) 

ggplot(data = plot_data, mapping = aes(x = date, y = count)) + 
  geom_point() +
  labs(title = "Total Crime over Time") +
  ylab("Total Number of Crimes") +
  xlab("Days") 
  
#6)
plot_data = read.csv("March2018.csv") 
plot_data$date = strptime(plot_data$DateOccur, "%m/%d/%Y %H:%M")
plot_data$date = as.Date(plot_data$date, "%m/%d/%Y")
plot_data$date = as.character(plot_data$date)
plot_data = plot_data %>% 
  group_by(date, District) %>%
  summarise(count=n()) 

ggplot(data = plot_data, mapping = aes(x = date, y = count)) + 
  geom_point(aes(color = as.factor(District))) + #as.factor makes the colors unrelated. Colors otherwise of same shade.
  labs(title = "Crimes over Time by District", color = "Districts") + #Add title and label legend
  ylab("Total Number of Crimes") +  #Label y axis
  xlab("Days") #Label x axis "Days." Hard to read because many of these crimes occurred before March.

# The sudden increase in times is because most of the crimes, but not all of them,
# occurred in March.
