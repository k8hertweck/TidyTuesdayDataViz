#### 27 Aug 2019 Simpsons ####

library(tidyverse)
library(ggsci)
library(gridExtra)

# download this week's data
simpsons <- readr::read_delim("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-08-27/simpsons-guests.csv", delim = "|", quote = "")

#### Data Viz ####

# boxplot
first <- simpsons %>%
  filter(season != "Movie") %>%
  group_by(episode_title, season) %>%
  tally() %>%
  type_convert() %>%
  filter(season < 16) %>%
  ggplot(aes(x=season, y=n, group=factor(season))) +
    geom_boxplot(aes(fill=factor(season))) +
    scale_fill_simpsons(guide=FALSE) +
    scale_x_discrete(limits=c(1:15)) +
    ylim(1, 10) +
    labs(y="number of guest stars") +
    theme_bw() 

second <- simpsons %>%
  filter(season != "Movie") %>%
  group_by(episode_title, season) %>%
  tally() %>%
  type_convert() %>%
  filter(season > 15) %>%
  ggplot(aes(x=season, y=n, group=factor(season))) +
    geom_boxplot(aes(fill=factor(season))) +
    scale_fill_simpsons(guide=FALSE) +
    scale_x_discrete(limits=c(16:30)) +
    ylim(1, 10) +
    labs(y="") +
    theme_bw()     

jpeg("figures/2019-08-27Simpsons.jpg")
grid.arrange(first, second, nrow=1)
dev.off()
