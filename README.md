# TFM

🧠 Why Are Some Reviews More Helpful Than Others?

Welcome to the official repository of my master’s thesis — a deep dive into what makes online product reviews more “helpful” on platforms like Amazon. Is it just about what is written, or who writes it? Let’s find out.

🔍 What This Research Is About
Every day, millions of product reviews shape consumer decisions. But not all reviews are created equal. This project asks:
Do reviews from verified buyers get more attention?
Does emotional language make a review more persuasive?
How do these effects change across product types, prices, and time?
We explore these questions through statistical modeling, sentiment analysis, and a dataset of 160,000 English-language Amazon reviews across 8 product categories.

🛠️ What’s Inside
Cleaned Data → Pre-processed Amazon review samples
Sentiment Analysis → Lexicon-based (AFINN, BING, NRC)
Modeling Scripts → Poisson, Negative Binomial, and Zero-Inflated NB
Interaction Effects → Verified × Sentiment, Length × Sentiment
Visuals & Output → Plots, tables, and regression summaries
Final Paper → 📄 thesis.pdf

📥 Download the dataset here:
https://drive.google.com/file/d/1Nj15jBgyAN7EvNd0VLEVnJHvJFVK85QF/view?usp=sharing

Folder structure:
```
📦 project-root/
├── data/
├── scripts/
├── outputs/
├── figures/
└── thesis.pdf
```
📈 Key Takeaways
✔ Verified reviews are consistently rated as more helpful — about 1.5x more
✔ Emotional tone (especially trust, sadness) helps — but only if you're verified
✔ Longer reviews + emotional language = strongest effect
✔ High-priced products trigger more scrutiny, boosting the value of detailed and credible reviews
✔ 26% of reviews were never marked helpful — likely due to platform visibility bias

⚠️ Limitations
Only English reviews included
Lexicons can’t detect sarcasm, irony, or cultural nuances
Review exposure (views, position) not directly observed
Average review age: 7+ years — algorithms may have changed
🚀 What’s Next?

Include visibility data (scroll depth, clicks)
Study other languages and e-commerce platforms
Mix methods: quantitative models + user interviews

💬 Want to Talk or Collaborate?
📧 ekinkizildas@gmail.com
🔗 www.linkedin.com/in/ekinkizildas

Feel free to fork, cite, or reuse. Let’s make online reviews more meaningful.

Kızıldaş, E. (2025). Why Do We Find Some Reviews More Helpful? The Role of Verified Status and Emotional Tone. Master’s Thesis, Humboldt-Universität zu Berlin.

