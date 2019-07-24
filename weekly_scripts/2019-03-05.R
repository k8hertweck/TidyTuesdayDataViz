#### 5 Mar 2019 Gender pay gap ####

library(tidytuesdayR)
library(ggplot2)
library(ggrepel)
library(dplyr)
library(packcircles)
library(viridis)

# download this week's data
tt_data<-tt_load("2019-03-05")
print(tt_data)
#earnings_female 
#employed_gender 
#jobs_gender 

# extract data of interest
jobs_gender <- tt_data$jobs_gender

#### Data Viz ####

# remove missing data from wage percent of male and summarize
jobs_percent <- jobs_gender %>%
  filter(!is.na(percent_female)) %>%
  group_by(major_category,minor_category) %>%
  summarise(avg_percent=mean(percent_female))

# generate layout for circles
pack_jobs <- circleProgressiveLayout(jobs_percent$avg_percent, sizetype='area')
jobs_percent <- bind_cols(jobs_percent, pack_jobs)
plot(jobs_percent$radius, jobs_percent$avg_percent)
vert_jobs <- circleLayoutVertices(pack_jobs, npoints = 50)

# plot circle packing
ggplot() + 
  geom_polygon(data=vert_jobs, 
               aes(x, y, group = id, 
                   fill=as.factor(id)), 
               color="black", alpha=0.6) +
  geom_text_repel(data=jobs_percent, 
            aes(x, y, size=avg_percent, label=minor_category)) +
  scale_size_continuous(range = c(1, 4)) +
  theme_void() + 
  theme(legend.position="none") +
  coord_equal()
ggsave("figures/5Mar2019.jpg", width = 8, height = 6)
