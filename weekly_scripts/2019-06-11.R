#### 11 June 2019 ####

library(tidyverse)
library(tidytuesdayR)
library(dismo)
library(maptools)
library(maps)

# download this week's data
tt_data<-tt_load("2019-06-11")
print(tt_data)

# extract data of interest
data <- tt_data$meteorites

table(data$fall)

#### Mapping ####

map(database="world")
points(data$long, data$lat, col='#1f78b4', pch=20, cex=1)

#### Data Viz ####

data %>%
  filter(mass > 0) %>%
  filter(year > 0)%>%
  ggplot() +
    geom_point(alpha = 0.3, aes(x=year, y=mass, color=fall)) +
    scale_y_continuous(trans='log10') +
    ylab("mass (g)")
ggsave("figures/2019-06-11time.jpg", width = 8, height = 4)

