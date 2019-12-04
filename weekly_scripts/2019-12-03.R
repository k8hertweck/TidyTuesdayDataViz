#### 3 Dec 2019 Philly cars ####

library(tidyverse)
library(tidytuesdayR)
library(lubridate)

# download this week's data
tt_data<-tt_load("2019-12-03")
print(tt_data)

# extract data of interest
tickets <- tt_data$tickets
head(tickets)

#### Data Viz ####

# all tickets
tickets %>%
  mutate(date = date(issue_datetime)) %>%
  group_by(date) %>%
  tally() %>%
  ggplot(aes(x=date, y=n)) +
  geom_line()
ggsave("figures/2019-12-03total_tickets.jpg", width = 8, height = 4)
