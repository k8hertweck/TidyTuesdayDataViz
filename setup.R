#### Basic project setup ####

# install data retrieval package: https://github.com/thebioengineer/tidytuesdayR
install.packages("devtools")
devtools::install_github("thebioengineer/tidytuesdayR")
install.packages("rlang")

# test
tt_data<-tt_load("2019-01-15")

