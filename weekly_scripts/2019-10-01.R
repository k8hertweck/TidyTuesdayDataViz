#### 1 Oct 2019 pizza ####

library(tidyverse)
devtools::install_github("dill/emoGG")
library(emoGG)
library(ggrepel)

# download this week's data
pizza_jared <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-01/pizza_jared.csv")
pizza_barstool <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-01/pizza_barstool.csv")
pizza_datafiniti <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-01/pizza_datafiniti.csv")

# search for pizza emoji
emoji_search("pizza")

# find bougie pizza
expensive <- pizza_datafiniti %>%
  filter(price_range_min == 50)
expensive$name

# manipulate data
better_pizza <- pizza_datafiniti %>%
  mutate(better_name = ifelse(pizza_datafiniti$name == "Crust Stone Oven Pizza", 
                              "bourgeois pizza", ""))

#### Data Viz ####

better_pizza %>%
  unique() %>%
  ggplot(aes(x=price_range_min, 
             y=price_range_max, 
             label=better_name)) +
  geom_emoji(emoji="1f355") +
  geom_label_repel() +
  labs(title="Pizza price range for surveyed restaurants",
       x="minimum price ($)", y="maximum price ($)")
ggsave("figures/2019-10-01pizza.jpg", width = 8, height = 4)
