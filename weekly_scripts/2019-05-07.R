#### 7 May 2019 Student teacher ratios ####

library(tidyverse)
library(tidytuesdayR)

# download this week's data
tt_data<-tt_load("2019-05-07")
print(tt_data)

# extract data of interest
data <- tt_data$student_teacher_ratio

unique(data$country)
table(data$country)

data %>%
  filter(str_detect(country, "coun")) %>%
  group_by(country) %>%
  tally() 

hi_low <- data %>%
  filter(country == "High income countries" | country == "Low income countries") %>%
  select(-flag_codes, -flags)

#### Data Viz ####

# boxplot
ggplot(hi_low) +
  geom_line(aes(x=year, y=student_ratio, color=country)) +
  ylab("student to teacher ratio") +
  facet_wrap(~indicator) 
ggsave("figures/2019-05-07.jpg", width = 8, height = 4)
