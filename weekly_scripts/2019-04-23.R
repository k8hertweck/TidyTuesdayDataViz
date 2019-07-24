#### 23 Apr 2019 Anime ####

library(tidyverse)
library(tidytuesdayR)
library(gridExtra)

# download this week's data
tt_data<-tt_load("2019-04-23")
print(tt_data)

# extract data of interest
tidy_anime <- tt_data$tidy_anime

# minimize data
small_anime <- tidy_anime %>%
  select(-synopsis, -background, -title_japanese, -related) %>%
  filter(score > 8)
write_csv(small_anime, "~/Desktop/small_anime.csv")

#### Data Viz ####

# histograms
# score
p1 <- ggplot(tidy_anime, aes(x=score)) +
  geom_bar()
# popularity
p2 <- ggplot(tidy_anime, aes(x=popularity)) +
  geom_bar()
# rank and score
p3 <- ggplot(tidy_anime, aes(x=score, y=rank)) +
  geom_point() +
  ylab("MyAnimeList formula rank")
# rank and score
p4 <- ggplot(tidy_anime, aes(x=popularity, y=score)) +
  geom_point()

plot_comb <- grid.arrange(p1, p2, p3, p4, nrow = 2, ncol = 2)
ggsave("figures/2019-04-23.jpg", plot_comb, width = 8, height = 4)
