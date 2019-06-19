#### 18 June 2019 ####

library(tidyverse)
library(tidytuesdayR)
library(taxize)

# download this week's data
tt_data<-tt_load("2019-06-18")
print(tt_data)

# extract data of interest
data <- tt_data$bird_counts

# count most frequent
counts <- data %>%
  group_by(species) %>%
  summarize(total = sum(how_many_counted)) %>%
  arrange(total)

# assess names
unique(data$species)
# get taxonomy
tax_names <- unique(data$species_latin)
# get entrez api key
# taxize::use_entrez
# key saved in .Renviron, not committed to GitHub
taxonomy_ncbi <- tax_name(query = tax_names, get = "family", db = "ncbi")
# find missing data
taxonomy_ncbi[is.na(taxonomy_ncbi$family), ]
# replace missing data
taxonomy_ncbi[10, 3] <- "Passerellidae"
taxonomy_ncbi[33, 3] <- "Laridae"
# reformat table
taxonomy_ncbi <- taxonomy_ncbi %>%
  select(query, family) %>%
  rename(species_latin = query)

# other ways to obtain taxonomy
# taxonomy_itis <- tax_name(query = tax_names, get = "family", db = "itis")
# full_class <- classification(tax_names, db = "itis")

# join taxonomy to count data
data_tax <- full_join(data, taxonomy_ncbi, by = "species_latin")
write_csv(data_tax, "data_out/2019-06-18.csv")

#### Data Viz ####

# time series by species
ggplot(data) +
  geom_line(aes(x=year, y=how_many_counted_by_hour, color=species)) +
  theme(legend.position = "none")
ggsave("figures/2019-06-18time_series.jpg", width = 8, height = 4)

# time series by family
data_tax %>%
  group_by(family, year) %>%
  summarize(total = sum(how_many_counted_by_hour)) %>%
  ggplot() +
  geom_line(aes(x=year, y=total, color=family)) 
  #theme(legend.position = "none")
ggsave("figures/2019-06-18time_series_family.jpg", width = 8, height = 4)
