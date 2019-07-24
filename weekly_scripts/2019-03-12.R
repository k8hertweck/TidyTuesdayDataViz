#### 12 Mar 2019 Board games ####

library(tidytuesdayR)
library(ggplot2)
library(dplyr)
library(tm)
library(ggwordcloud)

# download this week's data
tt_data<-tt_load("2019-03-12")
print(tt_data)

# extract data of interest
board_games <- tt_data$board_games

#### Data Viz ####

# scatterplot of average_rating and users_rated: are more popular games rated higher?
ggplot(board_games, aes(x=users_rated, 
                         y=average_rating)) +
  geom_point()

# when were popular games published?
board_games_sm <- board_games %>%
  filter(users_rated > 20000)
ggplot(board_games_sm, aes(x=year_published, 
                        y=average_rating)) +
  geom_point() 

# when were top rated games published?
board_games_top <- board_games %>%
  filter(average_rating > 8.5)
ggplot(board_games_top, aes(x=year_published, 
                           y=average_rating)) +
  geom_point() 

# word cloud of description
# data mining from https://deltadna.com/blog/text-mining-in-r-for-term-frequency/
# extract descriptions
desc_text <- paste(board_games$description, collapse=" ")
desc_source <- VectorSource(desc_text)
corpus <- Corpus(desc_source)
# clean text
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
# create document-term matrix
dtm <- DocumentTermMatrix(corpus)
dtm2 <- as.matrix(dtm)
frequency <- colSums(dtm2)
frequency <- sort(frequency, decreasing=TRUE)
freq <- tibble::rownames_to_column(as.data.frame(frequency[1:50], col.names=c("number")), col)
colnames(freq) <- c("word", "number")
head(freq)

# ggwordcloud https://cran.r-project.org/web/packages/ggwordcloud/vignettes/ggwordcloud.html
wordcloud(freq$word, freq$number)
set.seed(42)
ggplot(freq, aes(label=word, size=number, 
                 color = factor(sample.int(10, 
                                           nrow(freq), replace = TRUE)))) +
  geom_text_wordcloud() +
  theme_minimal()
ggsave("figures/12Mar2019.jpg", width = 8, height = 4)
