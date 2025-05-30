
# TFM

🧠 Why Are Some Reviews More Helpful Than Others?

Welcome to the official repository of my master's thesis exploring what
makes online product reviews more helpful on platforms like Amazon. This
project combines **computational social science**, **sentiment
analysis** and **verified purchase**, and **e-commerce research** to uncover the hidden dynamics
of review helpfulness.

## 🔍 Research Questions
- Do verified purchase reviews receive more helpful votes?
- How does emotional language influence perceived helpfulness?
- Do these effects vary by product category, price, or review age?

🔍 What This Research Is About Every day, millions of product reviews
shape consumer decisions. But not all reviews are created equal. This
project asks that ***Do reviews from verified buyers get more attention?
Does emotional language make a review more persuasive? How do these
effects change across product types, prices, and time?*** We explore
these questions through statistical modeling, sentiment analysis, and a
dataset of 160,000 English language Amazon reviews across 8 product
categories.


📥 Download the dataset here:
<https://drive.google.com/file/d/1Nj15jBgyAN7EvNd0VLEVnJHvJFVK85QF/view?usp=sharing>

## 🛠️ Repository Contents

```         
📦 project-root/
├── data/
├── scripts/
├── outputs/
├── figures/
└── thesis.pdf
```

## 📊 Key Findings
| Insight | Impact |
|---------|--------|
| ✅ Verified reviews | 1.5× more helpful votes |
| 💬 Emotional + Verified | 22% boost in helpfulness |
| 📝 Long + Emotional | Strongest positive effect |
| 💰 High-price items | Detailed reviews matter most |
| ❌ "Hidden" reviews | 26% never receive votes |

## 🧮 Methods
- **Data**: 160K Amazon reviews (8 categories)

- **Sentiment Analysis**: 
  - AFINN (valence scoring)  
  - BING (binary polarity)
  - NRC (emotion lexicon)
  
- **Models**:
  - Negative Binomial Regression
  - Zero-Inflated NB (for zero votes)
  - Interaction effects analysis

## ⚠️ Limitations
- Lexicons can't detect sarcasm/irony
- English-only reviews
- Historical data (avg. 7+ years old)
- Visibility bias not measured

## 🚀 Future Directions
- Incorporate review visibility metrics
- Multilingual/cross-platform analysis
- Deep learning for sentiment (BERT)
- Mixed-methods approaches

## 📥 Get the Data
Download preprocessed dataset:  
https://drive.google.com/file/d/1Nj15jBgyAN7EvNd0VLEVnJHvJFVK85QF/view?usp=sharing 


## 💬 Connect
- 📧 Email: ekinkizildas@gmail.com  
- 🔗 LinkedIn: [in/ekinkizildas](https://www.linkedin.com/in/ekinkizildas)
- 📚 Citation:  
 ```bibtex
  @mastersthesis{kizildas2025reviews,
    title  = {Why Do We Find Some Reviews More Helpful?},
    author = {Kızıldaş, Ekin},
    school = {Universidad Carlos III de Madrid},
    year   = {2025}
  }
```
