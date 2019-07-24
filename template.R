#### 26 Feb 2019 French trains ####

library(tidyverse)
library(tidytuesdayR)

# download this week's data
tt_data<-tt_load("2019-02-26")
print(tt_data)

# extract data of interest
full_trains <- tt_data$full_trains

#### Data Viz ####

# boxplot
ggplot(small_trains, aes(x=delay_cause, 
                         y=delayed_number)) +
  geom_boxplot(outlier.shape = NA, color='gray', alpha=0.75)
ggsave("figures/DATE.jpg", width = 8, height = 4)
