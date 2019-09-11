#### 10 Sept 2019 Amusement ride injuries ####

library(tidyverse)
library(tidytuesdayR)
library(viridisLite)
library(ggpointdensity)

# download this week's data
tt_data<-tt_load("2019-09-10")
print(tt_data)

# extract data of interest
saferparks <- tt_data$saferparks
tx_injuries <- tt_data$tx_injuries

# look at distribution of age and gender
tx_injuries %>%
  group_by(gender, age) %>%
  tally()
# examine cause of injury for age of 0
babies <- tx_injuries %>%
  filter(age == 0) %>%
  select(alleged_injury, cause_of_injury)
# ok so maybe they're not babies

lg_sample <- saferparks %>%
  group_by(device_category) %>%
  tally() %>%
  filter(n > 500)

saferparks %>%
  filter(device_category %in% lg_sample$device_category) %>%
  filter(gender != "B", gender != "f") %>%
  ggplot() +
    geom_boxplot(aes(x=device_category, y=age_youngest, color=gender))
ggsave("figures/2019-09-10amusementParks.jpg", width = 8, height = 4)
