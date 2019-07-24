#### 30 Apr 2019 ####

library(tidyverse)
library(tidytuesdayR)
library(gridExtra)

# download this week's data
tt_data<-tt_load("2019-04-30")
print(tt_data)

# extract data of interest
bird_collisions <- tt_data$bird_collisions
mp_light <- tt_data$mp_light

# look at taxonomy
unique(bird_collisions$family)
unique(bird_collisions$genus)
# no missing data for family, genus, species

# tally for numbers of each species
top_birbs <- bird_collisions %>%
  count(genus) %>%
  filter(n > 4000) %>%
  select(genus)

# cumulative bird counts
bird_counts <- bird_collisions %>%
  count(date, family, genus, species) %>%
  group_by(family, genus, species) %>%
  mutate(total_bird = cumsum(n))

# cumulative bird counts for top genera
top_birb_counts <- bird_collisions %>%
  filter(genus %in% top_birbs$genus) %>%
  count(date, family, genus) %>%
  group_by(family, genus) %>%
  mutate(total_bird = cumsum(n))

# cumulative bird counts by site
site_counts <- bird_collisions %>%
  filter(genus %in% top_birbs$genus) %>%
  count(date, locality) %>%
  group_by(locality) %>%
  mutate(total_bird = cumsum(n))

#### Data Viz ####

range(top_birb_counts$date) #"1978-09-15" "2016-11-30"
range(mp_light$date) #"2000-03-06" "2018-05-26"

# line plot for time series
birb <- ggplot(top_birb_counts, aes(x=date)) +
  geom_line(aes(y=total_bird, color=genus)) +
  ylab("number of birds (cumulative)") +
  xlab("year")

ggplot(top_birb_counts, aes(x=date)) +
  geom_line(aes(y=total_bird, color=genus)) +
  geom_line(data=site_counts, 
            aes(y=total_bird, group = locality)) +
  annotate("text", label = "MP", 
           x = as.Date("2013-01-01"), y = 20000, size = 4) +
  annotate("text", label = "CHI", 
           x = as.Date("2005-01-01"), y = 25000, size = 4) +
  ylab("number of birds (cumulative)") +
  xlab("year")

# bar plot for light
light <- ggplot(mp_light, aes(x=date, y=light_score)) + 
    geom_col()

# combined plot
plot_comb <- grid.arrange(birb, light, nrow = 2, ncol = 1)
ggsave("figures/2019-04-30.jpg", width = 8, height = 4)
