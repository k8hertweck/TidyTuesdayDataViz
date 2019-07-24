#### 24 July 2019 Wildlife vs planes ####

library(tidyverse)
library(tidytuesdayR)

# download this week's data
tt_data<-tt_load("2019-07-23")
print(tt_data)

# extract data of interest
wildlife_impacts <- tt_data$wildlife_impacts

unique(wildlife_impacts$species)
unique(wildlife_impacts$species_id)
unique(wildlife_impacts$phase_of_flt)
unique(wildlife_impacts$state)

# clean phase of flight column
wildlife_impacts <- wildlife_impacts %>%
  mutate(phase_of_flt = 
           str_replace_na(str_to_lower(phase_of_flt), "unknown"))

#### Data Viz ####
# What is the most dangerous phase of flight for animals in Washington?
wildlife_impacts %>%
  filter(state == "WA") %>%
  group_by(incident_year, phase_of_flt) %>%
  tally() %>%
  ggplot() +
    geom_line(aes(x=incident_year, y=n, color=phase_of_flt))
ggsave("figures/2019-07-24phaseWA.jpg", width = 8, height = 4)

# What is the most dangerous phase of flight for animals in all the data?
wildlife_impacts %>%
  group_by(incident_year, phase_of_flt) %>%
  tally() %>%
  ggplot() +
    geom_line(aes(x=incident_year, y=n, color=phase_of_flt))
ggsave("figures/2019-07-24phaseall.jpg", width = 8, height = 4)

# Which species are most impacted?
big_group <- wildlife_impacts %>%
  group_by(species) %>%
  tally() %>%
  arrange(desc(n)) %>%
  filter(n > 1000)
wildlife_big <- wildlife_impacts %>%
  filter(species %in% big_group$species)
wildlife_big %>%
  group_by(incident_year, species) %>%
  tally() %>%
  ggplot() +
    geom_line(aes(x=incident_year, y=n, color=species))
