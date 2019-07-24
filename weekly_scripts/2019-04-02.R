#### 2 Apr 2019 Bike traffic ####

library(tidytuesdayR)
library(tidyverse)
library(lubridate)

# download this week's data
tt_data<-tt_load("2019-04-02")
print(tt_data)

# extract data of interest
bike_traffic  <- tt_data$bike_traffic 

unique(bike_traffic$crossing) # 7 crossings

# manipulate dates
bike_traffic$date <- mdy_hms(bike_traffic$date)
bike_traffic <- bike_traffic %>%
  mutate(year = year(date)) %>%
  mutate(month = month(date))

monthly_bike <- bike_traffic %>%
  unite(year_month, c(year, month)) %>%
  group_by(year_month, crossing) %>%
  tally(bike_count)

monthly_ped <- bike_traffic %>%
  unite(year_month, c(year, month)) %>%
  group_by(year_month, crossing) %>%
  tally(ped_count)

#### Data Viz ####

# line plot for bikes
ggplot(monthly_bike, aes(x=year_month, y=n, group=crossing)) +
  geom_line(aes(color=crossing)) +
  xlab("year and month") +
  ylab("number of bicycles") +
  theme(axis.text.x=element_text(angle = 90))
ggsave("figures/2Apr2019bike.jpg")
# line plot for peds
ggplot(monthly_ped, aes(x=year_month, y=n, group=crossing)) +
  geom_line(aes(color=crossing)) +
  xlab("year and month") +
  ylab("number of bicycles") +
  theme(axis.text.x=element_text(angle = 90))
ggsave("figures/2Apr2019ped.jpg")
