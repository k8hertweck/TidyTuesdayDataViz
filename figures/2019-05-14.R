#### 14 May 2019 ####

library(tidyverse)

# download this week's data
nobel_winners <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-14/nobel_winners.csv")
nobel_winner_all_pubs <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-14/nobel_winner_all_pubs.csv")

# create before or after 
names(nobel_winner_all_pubs)
nobel_pubs <- nobel_winner_all_pubs %>%
  mutate(yr_diff = pub_year - prize_year) %>%
  na.omit(yr_diff)

# look at weirdos
weirdos <- nobel_pubs %>%
  filter(yr_diff < -50 | yr_diff > 50)

#### Data Viz ####

# horizontal violin plot
ggplot(nobel_pubs) +
  geom_violin(aes(x=category, 
                  y=yr_diff, fill=category)) +
  coord_flip()
ggsave("figures/2019-05-14.jpg", width = 8, height = 4)
