#### 24 July 2019 Wildlife airplane hits ####

library(tidyverse)
library(tidytuesdayR)

# download this week's data
tt_data<-tt_load("2019-07-23")
print(tt_data)

# extract data of interest
wildlife_impacts <- tt_data$wildlife_impacts

unique(wildlife_impacts$species_id)

#### Data Viz ####

ggsave("figures/2019-07-24.jpg", width = 8, height = 4)
