## ----setup, include=FALSE---------
knitr::opts_chunk$set(echo = TRUE)


## ---------------------------------
library(tidyverse)    
library(readr)   
library(tidytext)     
library(syuzhet)    
library(textdata) 
library(mice)   
library(knitr)



## ---------------------------------
sample_data_row <- read_csv("sample_data_balanced.csv")

sample_data_row <- sample_data_row %>%
  rename(
    product_title = title.y,
    review_title = title.x
  )


## ---------------------------------
sample_data_row <- sample_data_row %>%
  mutate(
    helpful_binary = ifelse(helpful_vote > 0, 1, 0),
    review_length = nchar(text),
    review_date = as.POSIXct(timestamp / 1000, origin = "1970-01-01"),
    review_date = as.Date(review_date),
    review_age = as.numeric(Sys.Date() - review_date)
  )




## ---------------------------------
sum(is.na(sample_data_row))

na_cols <- colSums(is.na(sample_data_row))
na_cols[na_cols > 0]



## ---------------------------------

# Drop unused column
sample_data <- sample_data_row %>%
  dplyr::select(-product_title)

# MICE: Select only numeric columns suitable for imputation
mice_data <- sample_data %>%
  dplyr::select(price, rating, review_length, review_age, store)

# Run MICE with Predictive Mean Matching
imputed_mice <- mice(mice_data, m = 5, method = "pmm", seed = 123)

# Extract completed dataset (first imputed set)
completed_mice <- complete(imputed_mice, 1)

# Replace missing prices with imputed values
sample_data$price[is.na(sample_data$price)] <- completed_mice$price[is.na(sample_data$price)]

# Categorical imputations (e.g., 'Unknown' for missing text-based columns)
sample_data <- sample_data %>%
  mutate(
    store = ifelse(is.na(store), "Unknown", store),
    main_category = ifelse(is.na(main_category), "Unknown", main_category),
    rating_number = ifelse(is.na(rating_number), mean(rating_number, na.rm = TRUE), rating_number),
    review_length = ifelse(is.na(review_length), mean(review_length, na.rm = TRUE), review_length)
  )

sample_data <- sample_data %>% drop_na(text)


# Final NA check
colSums(is.na(sample_data))



## ---------------------------------

sample_data$sentiment_score <- get_sentiment(sample_data$text, method = "afinn")




## ---------------------------------


# Tokenize the text (split into words)
tokens_nrc <- sample_data %>%
  dplyr::select(text, helpful_binary) %>%
  unnest_tokens(word, text)

# Load NRC emotion lexicon
nrc <- get_sentiments("nrc")

# Join tokens with NRC lexicon to assign emotions
nrc_joined <- tokens_nrc %>%
  inner_join(nrc, by = "word",
             relationship = "many-to-many")

# Count emotion occurrences per review (row-wise)
emotion_summary <- nrc_joined %>%
  count(row_number(), sentiment) %>%   # row_number() gives a unique ID per row
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>%
  rename(row_id = `row_number()`)

# Merge emotion scores back into original dataset
sample_data <- sample_data %>%
  mutate(row_id = row_number()) %>%
  left_join(emotion_summary, by = "row_id") %>%
  dplyr::select(-row_id)



## ---------------------------------


bing_lexicon <- get_sentiments("bing")


sample_data <- sample_data %>%
  mutate(review_id = row_number())


bing_scores <- sample_data %>%
  unnest_tokens(word, text) %>%
  inner_join(bing_lexicon, by = "word",relationship = "many-to-many") %>%
  mutate(score = ifelse(sentiment == "positive", 1, -1)) %>%
  group_by(review_id) %>%
  summarise(bing_score = sum(score))


sample_data <- left_join(sample_data, bing_scores, by = "review_id", relationship = "many-to-many")





## ---------------------------------
sample_data <- sample_data %>%
mutate(bing_label = case_when(
bing_score > 0~ "Positive",
bing_score < 0~ "Negative",
TRUE~ "Neutral"
))

