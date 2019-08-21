#### 20 Aug 2019 nuclear explosions ####

library(tidyverse)
library(ggbeeswarm)

# import data
nuclear_explosions <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-08-20/nuclear_explosions.csv")

## Data viz
nuclear_explosions %>%
  mutate(yield_range = yield_upper - yield_lower) %>%
  ggplot() +
    geom_boxplot(aes(x=year, y=yield_range, group = year))

nuclear_explosions %>%
  ggplot() +
    geom_boxplot(aes(x=year, y=depth, group = year))

nuclear_explosions %>%
  mutate(depth_pos = -depth) %>%
  filter(depth_pos < 5) %>%
  ggplot() +
    geom_beeswarm(aes(x=year, y=depth_pos, color=country, size=yield_lower)) +
    ylab("depth at detonation (km)") +
    ggtitle("Nuclear explosions over time: depth, lower yield estimate, and who to blame")
ggsave("figures/2019-08-20nuclear.jpg", width = 8, height = 5)
