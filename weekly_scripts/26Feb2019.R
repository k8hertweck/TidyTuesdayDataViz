#### 26 Feb 2019 ####

library(tidytuesdayR)
library(ggplot2)

# download this week's data
tt_data<-tt_load("2019-02-26")
print(tt_data)

# extract data of interest
full_trains <- tt_data$full_trains
#tt_data$regularite-mensuelle-tgv-aqst 
small_trains <- tt_data$small_trains
table(small_trains$delay_cause)

#### Small trains ####

# bubbles and boxplot
ggplot(small_trains, aes(x=delay_cause, 
                         y=delayed_number)) +
  geom_boxplot(outlier.shape = NA, color='gray', alpha=0.75) +
  geom_point(aes(size=avg_delay_all_arriving), alpha=0.5, color='blue')
  
# bubble plot
ggplot(small_trains) +
  geom_point(aes(x=num_late_at_departure, 
                 y=num_arriving_late, 
                 size=delayed_number,
                 color=delay_cause),
             alpha=0.3)
ggsave("figures/26Feb2019.jpg", width = 8, height = 4)
