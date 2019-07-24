#### 26 Feb 2019 Media franchise revenues ####

library(tidyverse)
library(tidytuesdayR)

# download this week's data
tt_data<-tt_load("2019-07-02")
print(tt_data)

# extract data of interest
media_franchises <- tt_data$media_franchises

unique(media_franchises$franchise)
unique(media_franchises$revenue_category)

franchises <- media_franchises %>%
  group_by(franchise, , revenue_category, year_created) %>%
  summarise(total_rev = sum(revenue))

#### Data Viz ####

# time series
ggplot(franchises, aes(x=year_created, 
                         y=total_rev)) +
  geom_line(aes(color = revenue_category))
ggsave("figures/2019-07-02.jpg", width = 8, height = 4)
