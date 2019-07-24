#### 9 July 2019 Women's tennis wins ####

library(tidyverse)
library(tidytuesdayR)
library(lubridate)

# download this week's data
tt_data<-tt_load("2019-07-09")
print(tt_data)

# extract data of interest
wwc_outcomes <- tt_data$wwc_outcomes

unique(wwc_outcomes$team)

# convert win status to lose=0, tie=0.5, win=1
win_status <- factor(wwc_outcomes$win_status)
hist(win_status)
levels(win_status)
win_status <- as.numeric(win_status)
win_status[win_status == 1] <- 0
win_status[win_status == 2] <- 0.5
win_status[win_status == 3] <- 1
hist(win_status)
wwc_outcomes$win_status <- as.numeric(win_status)

wwc_outcomes <- wwc_outcomes %>%
  group_by(team, year) %>%
  summarize(totals = sum(win_status)) %>%
  mutate(wins = cumsum(totals))

#### Data Viz ####

# time series
wwc_outcomes%>%
    ggplot(aes(x=year, y=wins)) +
    geom_line(aes(color=team))
ggsave("figures/2019-07-09.jpg", width = 8, height = 4)
