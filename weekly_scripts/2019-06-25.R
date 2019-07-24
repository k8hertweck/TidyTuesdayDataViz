#### 25 June 2019 ####

library(tidyverse)
library(tidytuesdayR)
library(dismo)
library(maptools)
library(maps)
library(lubridate)

# download this week's data
tt_data<-tt_load("2019-06-25")
print(tt_data)

# extract data of interest
data <- tt_data$ufo_sightings

# extract Seattle data
seattle <- filter(data, city_area == "seattle")
write_csv(seattle, "data_out/seattle_ufo.csv")
washington <- filter(data, state == "wa")

unique(data$ufo_shape)
table(washington$ufo_shape)

#### Mapping ####

# map of waashington with all ufos in black and lights in green
light <- washington %>%
  filter(ufo_shape == "light")
map(database="state", regions="washington", interior=TRUE)
points(washington$longitude, washington$latitude, pch=20)
points(light$longitude, light$latitude, col='#b2df8a', pch=20)

# map of waashington with all ufos in black and formations in red
formation <- washington %>%
  filter(ufo_shape == "formation")
map(database="state", regions="washington", interior=TRUE)
points(washington$longitude, washington$latitude, pch=20)
points(formation$longitude, formation$latitude, col='#FF0000', pch=20)

#### Data Viz ####

# extract years from dates
data <- data %>%
  mutate(years = year(mdy_hm(date_time)))
# most frequent shapes
freq_shapes <- data %>%
  filter(!is.na(ufo_shape)) %>%
  group_by(ufo_shape) %>%
  tally() %>%
  arrange(desc(n)) %>%
  filter(n > 5000)

# filter dataset to common shapes and plot in time series
data %>%
  filter(ufo_shape %in% freq_shapes$ufo_shape) %>%
  group_by(years, ufo_shape) %>%
  tally() %>%
  ggplot() +
    geom_line(aes(x=years, y=n, color=ufo_shape))
ggsave("figures/2019-06-25.jpg", width = 8, height = 4)

