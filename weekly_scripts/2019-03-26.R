#### 26 Mar 2019 ####

# approach from https://austinwehrwein.com/digital-humanities/creating-a-density-map-in-r-with-zipcodes/

library(tidytuesdayR)
library(tidyverse)
library(zipcode)
library(maps)
library(viridis)

# download this week's data
tt_data<-tt_load("2019-03-26")
print(tt_data)

# extract data of interest
seattle_pets <- tt_data$seattle_pets

#### data exploration ####

# how many different pets?
count(seattle_pets, species) # cat, dog, goat, pig
# where are the goats?
pigs <- filter(seattle_pets, species == "Pig")

# clea zipcode data
data("zipcode")
pet_zips <- seattle_pets
pet_zips$zip_code <- clean.zipcodes(pet_zips$zip_code)
# size by zip
zip_counts <- aggregate(data.frame(count = pet_zips$license_number), 
                     list(zip = pet_zips$zip_code), length)
pet_zips <- mutate(pet_zips, zip = zip_code)
pet_zips <- merge(zip_counts, zipcode, by = "zip")
# filter out non-WA places
pet_zips_WA <- filter(pet_zips, state == "WA")

#### Data Viz ####

map(database = "county", regions = "washington")
map(database = "county", regions = c("washington,king"))
points(pet_zips$longitude, pet_zips$latitude)

# plot Washington with county outlines
wa <- map_data("county", "washington")
king <- map_data("county", c("washington,king"))

ggplot(pet_zips_WA, aes(x=longitude, y=latitude)) +
  geom_polygon(data=wa, 
               aes(x=long, y=lat, group=group), 
               color='gray',fill=NA,alpha=.35) +
  geom_point(aes(color = count)) +
  xlim(-123,-119) +
  ylim(45,50)
ggsave("figures/26Mar2019.jpg", width = 8, height = 6)
