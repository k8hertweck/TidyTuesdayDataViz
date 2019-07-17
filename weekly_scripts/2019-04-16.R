#### 16 Apr 2019 ####

library(tidyverse)
library(tidytuesdayR)

# download this week's data
#tt_data<-tt_load("2019-04-16") # yikes 
brexit <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/brexit.csv")
corbyn <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/corbyn.csv")
dogs <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/dogs.csv")
eu_balance <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/eu_balance.csv")
pensions <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/pensions.csv")
trade <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/trade.csv")
women_research <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/women_research.csv")

#### Data Viz ####

# boxplot by field
ggplot(women_research, aes(x=field, y=percent_women, color = field)) +
  geom_boxplot()
ggsave("figures/16Apr2019field.jpg", width = 8, height = 4)
# boxplot by country
ggplot(women_research, aes(x=country, y=percent_women, color=country)) +
  geom_boxplot()
ggsave("figures/16Apr2019country.jpg", width = 8, height = 4)
