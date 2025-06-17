# TFM

🧠 Why Are Some Reviews More Helpful Than Others? The Role of Verified Status and Emotional Tone

This repository contains the full research project and materials for my master's thesis submitted to Universidad Carlos III de Madrid. The study investigates what makes online product reviews more helpful on platforms like Amazon, focusing on the effects of **verified purchase status, emotional tone, and contextual variables such as price, review age, and product category**.

## 🔍 Research Questions
- How does verified purchase status affect the perceived helpfulness of online reviews?
- Does the emotional tone of a review contribute to its helpfulness?
- Are these effects stronger when combined (e.g., emotional tone + verified status)?
- Do contextual variables such as product price, review age, or category moderate these relationships?

🧠 What This Research Is About
Consumer decisions today are increasingly shaped by online reviews. Yet not all reviews have the same influence. This thesis analyzes 160,000 Amazon reviews across 8 product categories using sentiment analysis and count-based regression models to examine how emotional tone and reviewer credibility (verified status) affect helpfulness votes.


## 🛠️ Repository Contents

```         
├── exploratory_analysis_files/
│   └── figure-html/
├── rmd_files/
│   └── [contains R Markdown files, e.g., 03exploratory_analysis.Rmd]
├── tables/
├── .Rhistory
├── .gitignore
└── README.md
⚠️ Important Note:
The file 01Preprocessing_Data.Rmd was used only for initial data pruning and manual exclusions.
It includes subjective cleaning steps such as removing irrelevant categories or filtering problematic entries by hand.
It is not meant for reproducibility and should only be run if you wish to inspect or replicate the initial data curation logic.
To ensure consistency, all downstream analysis begins from 02Data_Cleaning.Rmd.
```

## 📊 Key Findings
| Insight                    | Impact                                      |
| -------------------------- | ------------------------------------------- |
| ✅ Verified reviews         | Receive significantly more helpful votes    |
| 💬 Verified + Emotional    | Combination shows amplified effectiveness   |
| 📝 Long, emotional reviews | Perform best in terms of helpfulness        |
| 💰 High-priced products    | Reviews tend to be evaluated more carefully |
| ❌ Low-engagement reviews   | 26% receive no helpful votes at all         |


## 🧮 Methods
- **Data**: 160K Amazon reviews (8 categories)

- **Sentiment Analysis**: 
  - AFINN (valence scoring)  
  - BING (binary polarity)
  - NRC (emotion lexicon)
  
- **Models**:
  - Negative Binomial Regression
  - Zero-Inflated NB 
  - Interaction models

## ⚠️ Limitations
- Lexicon based sentiment tools miss sarcasm or contextual cues
- English only reviews
- Historical data (average review age: 7.4 years)
- Visibility bias (e.g., review position on page) not accounted for

## 🚀 Future Directions
- Use of transformer-based models like BERT for deeper emotional analysis
- Incorporation of review visibility data (e.g., impressions or clicks)
- Cross-platform and multilingual replication studies
- Combining quantitative and qualitative methods

## 📥 Get the Data
Download the preprocessed dataset used in this thesis:
https://drive.google.com/file/d/1Nj15jBgyAN7EvNd0VLEVnJHvJFVK85QF/view?usp=sharing 


⚠️ Important Note:
The original raw dataset is publicly available at
🔗 https://amazon-reviews-2023.github.io
However, do not download the data directly from the source if you intend to reproduce this analysis.
The dataset used in this project includes manual filtering and exclusions for research purposes.
Please use the provided preprocessed file to ensure consistency with the reported results.


## 💬 Connect
- 📧 Email: ekinkizildas@gmail.com  
- 🔗 LinkedIn: [in/ekinkizildas](https://www.linkedin.com/in/ekinkizildas)
- 📚 Citation:  
 ```bibtex
  @mastersthesis{kizildas2025reviews,
    title  = {Why Do We Find Some Reviews More Helpful? The Role of Verified Status and Emotional Tone},
    author = {Kızıldaş, Ekin},
    school = {Universidad Carlos III de Madrid},
    year   = {2025}
  }
```
