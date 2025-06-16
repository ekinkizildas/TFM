## ----setup, include=FALSE-------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----load_libraries, include=FALSE----------------------------------------------
library(tidyverse)
library(syuzhet)
library(gt)
library(tidytext)
library(corrplot)
library(dotwhisker)
library(broom)
library(pscl)
library(flextable)
library(kableExtra)
library(knitr)




## -------------------------------------------------------------------------------
source("extracted_data_cleaning_code.R", local = knitr::knit_global())


## -------------------------------------------------------------------------------
summary(sample_data %>% 
          dplyr::select(helpful_vote, review_length, review_age, sentiment_score, price))

 gt(sample_data %>%
  summarise(
    Count = n(),
    `Helpful Rate (%)` = round(mean(helpful_binary, na.rm = TRUE) * 100, 1),
    `Avg. Helpful Votes` = round(mean(helpful_vote, na.rm = TRUE), 2),
    `Avg. Review Length` = round(mean(review_length, na.rm = TRUE), 0),
    `Avg. Review Age (days)` = round(mean(review_age, na.rm = TRUE), 0),
    `Avg. Sentiment Score` = round(mean(sentiment_score, na.rm = TRUE), 2),
    `Avg. Price ($)` = round(mean(price, na.rm = TRUE), 2)
  ))




## -------------------------------------------------------------------------------

category_summary <- sample_data %>%
  group_by(category) %>%
  summarise(
    Count = n(),
    `Helpful Rate (%)` = round(mean(helpful_binary) * 100, 1),
    `Avg. Sentiment` = round(mean(sentiment_score, na.rm = TRUE), 2),
    `Avg. Review Length` = round(mean(review_length, na.rm = TRUE), 0),
    `Avg. Price ($)` = round(mean(price, na.rm = TRUE), 2)
  )

gt(category_summary)





## -------------------------------------------------------------------------------
sample_data %>%
  arrange(desc(helpful_vote)) %>%
  dplyr::select(helpful_vote, verified_purchase, rating, sentiment_score, text) %>%
  head(10)




## -------------------------------------------------------------------------------
sample_data %>%
  arrange(desc(joy)) %>%
  dplyr::select(joy, helpful_vote, rating, text) %>%
  head(5)



## -------------------------------------------------------------------------------
 sample_data %>%
  mutate(length_group = case_when(
    review_length < 100 ~ "Short",
    review_length < 500 ~ "Medium",
    TRUE ~ "Long"
  )) %>%
  group_by(length_group) %>%
  summarise(avg_helpful = mean(helpful_vote),
            avg_sentiment = mean(sentiment_score),
            count = n())



## -------------------------------------------------------------------------------
sample_data %>%
  filter(sentiment_score > 8 | sentiment_score < -8) %>%
  dplyr::select(sentiment_score, helpful_vote, rating, text) %>%
  head(10)



## -------------------------------------------------------------------------------
sample_data <- sample_data %>%
  mutate(sentiment_per_100 = (sentiment_score / review_length) * 100)



## -------------------------------------------------------------------------------
ggplot(sample_data %>% filter(helpful_vote <= 20), aes(x = helpful_vote)) +
  geom_histogram(binwidth = 1, fill = "#00BFC4", color = "white") +
  labs(
    title = "Distribution of Helpful Votes",
    x = "Helpful Votes",
    y = "Count"
  ) +
  theme_minimal()





## -------------------------------------------------------------------------------
sample_data %>%
  group_by(category) %>%
  summarise(helpful_rate = mean(helpful_binary)) %>%
  ggplot(aes(x = reorder(category, -helpful_rate), y = helpful_rate)) +
  geom_col(fill = "#00BFC4") +
  labs(title = "Helpful Review Rate by Product Category",
       x = "Category", y = "Helpful Rate") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))




## -------------------------------------------------------------------------------
ggplot(sample_data, aes(x = review_length)) +
  geom_histogram(binwidth = 50, fill = "#00BFC4", color = "white") +
  scale_x_continuous(limits = c(0, 1500)) +
  labs(
    title = "Distribution of Review Lengths",
    x = "Number of Characters", y = "Count of Reviews"
  ) +
  theme_minimal()





## -------------------------------------------------------------------------------
ggplot(sample_data, aes(x = sentiment_score)) +
  geom_histogram(binwidth = 1, fill = "#00BFC4", color = "white") +
  labs(
    title = "Distribution of Sentiment Scores(AFINN)",
    x = "Sentiment Score", y = "Number of Reviews"
  ) +
  theme_minimal()





## -------------------------------------------------------------------------------
ggplot(sample_data, aes(x = bing_score)) +
  geom_histogram(binwidth = 1, fill = "#00BFC4", color = "white") +
  labs(
    title = "Distribution of Sentiment Scores (BING)",
    x = "Sentiment Score", y = "Number of Reviews"
  ) +
  theme_minimal()




## -------------------------------------------------------------------------------
ggplot(sample_data, aes(x = price)) +
  geom_histogram(binwidth = 5, fill = "#00BFC4", color = "white") +
  scale_x_continuous(limits = c(0, 300)) +
  labs(
    title = "Distribution of Product Prices",
    x = "Price ", y = "Number of Products"
  ) +
  theme_minimal()





## -------------------------------------------------------------------------------
ggplot(sample_data, aes(x = sentiment_score, fill = category)) +
  geom_density(alpha = 0.6, color = "black") +
  xlim(0, 25) +
  facet_wrap(~category, scales = "free_y") +
    scale_fill_manual(values = rep("#00BFC4", length(unique(sample_data$category)))) +
  labs(
    title = "Sentiment Distribution by Product Category (AFINN)",
    x = "Sentiment Score", y = "Density"
  ) +
  theme_minimal()+
  theme(legend.position = "none")




## -------------------------------------------------------------------------------
ggplot(sample_data, aes(x = bing_score, fill = category)) +
  geom_density(alpha = 0.6, color = "black") +
  xlim(0, 25) +
  facet_wrap(~category, scales = "free_y") +
    scale_fill_manual(values = rep("#00BFC4", length(unique(sample_data$category)))) +
  labs(
    title = "Sentiment Distribution by Product Category (BING)",
    x = "Sentiment Score", y = "Density"
  ) +
  theme_minimal()+
  theme(legend.position = "none") 



## -------------------------------------------------------------------------------

overall_emotion_summary <- sample_data %>%
  summarise(across(c(joy, trust, fear, anger, sadness, disgust, surprise, anticipation),
                   mean, na.rm = TRUE)) %>%
  pivot_longer(cols = everything(), names_to = "emotion", values_to = "mean_value")

ggplot(overall_emotion_summary, aes(x = reorder(emotion, -mean_value), y = mean_value)) +
  geom_col(show.legend = FALSE,fill = "#00BFC4") +
  labs(title = "Average Emotion Scores (Overall)",
       x = "Emotion", y = "Mean Score") +
  theme_minimal()




## -------------------------------------------------------------------------------
sample_data %>%
  group_by(verified_purchase) %>%
  summarise(avg_helpful = mean(helpful_vote, na.rm = TRUE)) %>%
  ggplot(aes(x = as.factor(verified_purchase), y = avg_helpful, fill = as.factor(verified_purchase))) +
 geom_col(fill = "#00BFC4")+
  scale_x_discrete(labels = c("0" = "Not Verified", "1" = "Verified")) +
  labs(
    title = "Average Helpful Votes by Verified Status",
    x = "Verified Purchase",
    y = "Average Helpful Votes"
  ) +
  theme_minimal() +
  theme(legend.position = "none")



## -------------------------------------------------------------------------------
sample_data %>%
  filter(review_age > 0) %>%
  ggplot(aes(x = log10(review_age), y = log10(helpful_vote + 1))) +
  geom_point(alpha = 0.3, color = "#00BFC4") +
  geom_smooth(method = "loess", se = FALSE, color = "black", linetype = "dashed") +
  labs(
    title = "Relationship Between Review Age and Helpful Votes ",
    x = "Review Age",
    y = "Helpful Votes ",
    caption = "0 helpful votes included using log10(helpful_vote + 1)"
  ) +
  theme_minimal()





## -------------------------------------------------------------------------------

sample_data %>%
  count(verified_purchase) %>%
  ggplot(aes(x = as.factor(verified_purchase), y = n, fill = as.factor(verified_purchase))) +
   geom_col(fill = "#00BFC4")+
  scale_x_discrete(labels = c("0" = "Not Verified", "1" = "Verified")) +
  labs(
    title = "Distribution of Verified Purchase Status",
    x = "Verified Purchase",
    y = "Number of Reviews"
  ) +
  theme_minimal() +
  theme(legend.position = "none")






## -------------------------------------------------------------------------------


sample_data$review_year <- format(as.Date(sample_data$review_date), "%Y")

temporal_summary <- sample_data %>%
  group_by(review_year, verified_purchase) %>%
  summarise(mean_age = mean(review_age, na.rm = TRUE),
            count = n()) %>%
  ungroup()




## -------------------------------------------------------------------------------

temporal_verified <- sample_data %>%
  group_by(review_year) %>%
  summarise(
    verified = mean(verified_purchase == TRUE, na.rm = TRUE),
    non_verified = mean(verified_purchase == FALSE, na.rm = TRUE)
  ) %>%
  pivot_longer(cols = c("verified", "non_verified"), names_to = "type", values_to = "rate")


ggplot(temporal_verified, aes(x = as.numeric(review_year), y = rate, color = type)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  scale_color_manual(values = c("verified" = "#1F78B4", "non_verified" = "#E31A1C"),
                     labels = c("Verified", "Not Verified")) +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "Verified vs. Non-Verified Reviews Over Time",
    x = "Review Year",
    y = "Review Proportion (%)",
    color = "Review Type"
  ) +
  theme_minimal()





## -------------------------------------------------------------------------------
ggplot(sample_data, aes(x = rating)) +
  geom_bar(fill = "#00BFC4") +
  labs(title = "Distribution of Star Ratings")



## -------------------------------------------------------------------------------
ggplot(sample_data, aes(x = rating, y = helpful_vote)) +
  stat_summary(fun = mean, geom = "col", fill = "#00BFC4") +
  labs(title = "Average Helpful Votes by Rating")





## -------------------------------------------------------------------------------
sample_data <- sample_data %>%
  mutate(review_age_group = case_when(
    review_age < 1000 ~ "Recent",
    review_age >= 1000 & review_age < 3000 ~ "Medium",
    review_age >= 3000 ~ "Old"
  ))



summary_data <- sample_data %>%
  group_by(rating, verified_purchase, review_age_group) %>%
  summarise(avg_helpful = mean(helpful_vote, na.rm = TRUE)) %>%
  ungroup()




## -------------------------------------------------------------------------------

ggplot(summary_data, aes(x = factor(rating), y = avg_helpful, color = as.factor(verified_purchase), group = verified_purchase)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  facet_wrap(~ review_age_group) +
  scale_color_manual(values = c("#E41A1C", "#377EB8"), labels = c("Not Verified", "Verified")) +
  labs(
    title = "Interaction Between Star Rating, Verified Purchase, and Review Age on Review Helpfulness",
    x = "Star Rating",
    y = "Average Helpful Votes",
    color = "Verified Purchase"
  ) +
  theme_minimal(base_size = 13)





## -------------------------------------------------------------------------------

sample_data <- sample_data %>%
  mutate(length_group = cut(review_length,
                            breaks = quantile(review_length, probs = c(0, 0.33, 0.66, 1), na.rm = TRUE),
                            labels = c("Short", "Medium", "Long"),
                            include.lowest = TRUE))



## -------------------------------------------------------------------------------
sample_data %>%
  ggplot(aes(x = sentiment_score, y = log(review_length + 1), color = length_group)) +
  geom_point(alpha = 0.2, size = 0.8) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Relationship Between Review Length and Afinn Score",
    x = "AFINN Sentiment Score",
    y = "Log Review Length"
  ) +
  theme_minimal()





## -------------------------------------------------------------------------------
sample_data %>%
  ggplot(aes(x = bing_score, y = log(review_length + 1), color = length_group)) +
  geom_point(alpha = 0.2, size = 0.8) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Relationship Between Review Length and Bing Sentiment Score",
    x = "Bing Sentiment Score",
    y = "Log Review Length"
  ) +
  theme_minimal()




## -------------------------------------------------------------------------------


sample_data %>%
  group_by(length_group) %>%
  summarise(across(c(anger, anticipation, disgust, fear, joy, negative, positive, sadness, surprise, trust), 
                   mean, na.rm = TRUE)) %>%
  pivot_longer(cols = -length_group, names_to = "sentiment", values_to = "mean_score") %>%
  ggplot(aes(x = length_group, y = mean_score, color = sentiment, group = sentiment)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  labs(
    title = "Average NRC Sentiment Scores by Review Length Groups",
    x = "Review Length Groups",
    y = "Average Sentiment Score",
    color = "Sentiment"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "bottom"
  )





## -------------------------------------------------------------------------------

ggplot(sample_data, aes(x = category, y = helpful_vote)) +
  geom_violin(fill = "#00BFC4") +
  scale_y_log10() +
  labs(
    title = "Helpful Votes Distribution by Category",
    x = "Category",
    y = "Helpful Votes (Log)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))




## -------------------------------------------------------------------------------


ggplot(sample_data, aes(x = review_age)) +
  geom_histogram(bins = 50, fill = "#00BFC4", color = "white", alpha = 0.8) +
  geom_density(aes(y = ..count..), color = "black", size = 1, adjust = 1.5) +
  labs(
    title = "Distribution of Review Age (days)",
    x = "Review Age (days)",
    y = "Number of Reviews"
  ) +
  theme_minimal()





## -------------------------------------------------------------------------------

summary_table <- sample_data %>%
  group_by(category, verified_purchase) %>%
  summarise(
    N = n(),
    Avg_Helpful = mean(helpful_vote, na.rm = TRUE),
    Avg_Length = mean(review_length, na.rm = TRUE),
    Avg_Rating = mean(rating, na.rm = TRUE),
    Avg_Afinn = mean(sentiment_score, na.rm = TRUE),
    .groups = "drop"
  )





## -------------------------------------------------------------------------------

bing_pct_table <- sample_data %>%
  filter(!is.na(bing_label)) %>%
  group_by(category, verified_purchase, bing_label) %>%
  summarise(N = n(), .groups = "drop") %>%
  group_by(category, verified_purchase) %>%
  mutate(Share = N / sum(N)) %>%
  dplyr::select(-N) %>%
  pivot_wider(names_from = bing_label, values_from = Share, values_fill = 0) %>%
  mutate(
    Percent_Negative = round(Negative * 100, 1),
    Percent_Positive = round(Positive * 100, 1),
    Percent_Neutral = round(Neutral * 100, 1)
  ) %>%
  dplyr::select(category, verified_purchase, Percent_Negative, Percent_Neutral, Percent_Positive)

final_summary <- left_join(summary_table, bing_pct_table, 
                           by = c("category", "verified_purchase"))



colnames(final_summary)[colnames(final_summary) == "Percent_Negative"] <- "BING_Negative (%)"
colnames(final_summary)[colnames(final_summary) == "Percent_Positive"] <- "BING_Positive (%)"
colnames(final_summary)[colnames(final_summary) == "Percent_Neutral"]  <- "BING_Neutral (%)"



b <- final_summary %>%
  flextable() %>%
  set_header_labels(
    category = "Category",
    verified_purchase = "Verified",
    Avg_Helpful = "Avg. Helpful",
    Avg_Length = "Avg. Length",
    Avg_Rating = "Avg. Rating",
    Avg_Afinn = "AFINN (Mean)",
    `BING_Negative (%)` = "BING Negative (%)",
    `BING_Positive (%)` = "BING Positive (%)"
  ) %>%
  fontsize(part = "header", size = 11) %>%  
  fontsize(part = "body", size = 10) %>%
  font(part = "all", fontname = "Times New Roman") %>%
  autofit()







## -------------------------------------------------------------------------------
knitr::purl("03exploratory_analysis.Rmd", 
            output = "extracted_exploratory_analysis_code.R")


