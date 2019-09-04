#### 3 Sept 2019 Moore's law ####

library(tidyverse)
library(tidytuesdayR)

# download this week's data
tt_data<-tt_load("2019-09-03")
print(tt_data)

# extract data of interest
cpu <- tt_data$cpu
gpu <- tt_data$gpu
ram <- tt_data$ram

#### Data Viz ####

# boxplot
ggplot() +
  geom_point(data=cpu, aes(x=date_of_introduction, y=transistor_count)) +
  geom_point(data=ram, aes(x=date_of_introduction, y=transistor_count, 
                           color=factor(capacity_bits))) +
  geom_smooth(data=cpu, aes(x=date_of_introduction, y=transistor_count)) +
  scale_y_log10() +
  labs(x="year introduced", y="transistor count", color="bit capacity", title="Moore's Law") 
ggsave("figures/2019-09-03MooresLaw.jpg", width = 8, height = 4)
