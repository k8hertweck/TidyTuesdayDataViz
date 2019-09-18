#### 17 Sept 2019 National parks visitation ####

library(tidyverse)

# download this week's data
park_visits <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-17/national_parks.csv")
gas_price <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-17/gas_price.csv")

#### Data Viz ####

# total number of visitors by year of park start
totals <- park_visits %>%
  filter(year == "Total")
park_visits %>%
  group_by(unit_code) %>%
  summarize(start = min(year)) %>%
  full_join(y=totals, by = "unit_code") %>%
  filter(start != "Total") %>%
  ggplot() +
    geom_point(aes(x=start, y=visitors)) +
    scale_y_log10() +
    labs(x="year introduced", y="number of visitors", title="National Park Visits")
ggsave("figures/2019-09-17NationalParkVisits.jpg", width = 8, height = 4)

# most frequently visited parks
top_parks <- park_visits %>%
  filter(year == "Total") %>%
  filter(visitors > 20000000)
# visitors per year
park_visits %>%
  filter(unit_code %in% top_parks$unit_code) %>%
  filter(year != "Total") %>%
  ggplot() +
    geom_boxplot(aes(x=year, y=visitors))
