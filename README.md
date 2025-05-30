# TFM

📘 Project Title:

Why Do We Find Some Reviews More Helpful? The Role of Verified Status and Emotional Tone

📄 Description

This repository contains all the code, datasets, and documentation for the master’s thesis analyzing the perceived helpfulness of Amazon product reviews. The study investigates how verified purchase status and emotional tone affect review helpfulness, using sentiment analysis and count-based regression models across 160,000 English-language reviews.

🎯 Research Objectives

Examine how verified status influences perceived review helpfulness
Analyze the role of emotional tone using lexicon-based sentiment analysis (AFINN, BING, NRC)
Explore how textual features, price, review age, and product category moderate these effects
Implement and compare count-based models: Poisson, Negative Binomial (NB), and Zero-Inflated Negative Binomial (ZINB)
🧪 Methodology

Data Source: Amazon Reviews 2023 Dataset
Sample Size: ~160,000 reviews across 8 product categories
Language Filter: English-only reviews
Sentiment Analysis: AFINN, BING, NRC Lexicons
Modeling:
Baseline NB Model
NB with Interaction Terms (verified × sentiment, length × sentiment)
ZINB model to account for excess zeros
Tools: R, tidyverse, MASS, pscl
📁 Repository Structure

📦 root/
├── 📁 data/             # Cleaned review datasets (pre-processed)
├── 📁 scripts/          # R scripts for sentiment scoring, modeling, and visualization
├── 📁 outputs/          # Model results, figures, tables
├── 📄 thesis.pdf        # Final thesis document
└── 📄 README.md         # This file
📊 Key Results

Verified reviews received ~1.5x more helpful votes
Sentiment had stronger effects when expressed by verified users
Emotional tone (e.g., trust, sadness) increased helpfulness in longer reviews
ZINB model revealed 26.5% of reviews likely had no exposure (structural zeros)
📌 Limitations

Lexicon methods may not detect sarcasm or context
Only English reviews from 8 product categories
Visibility bias not directly measurable
🔍 Future Work

Incorporate BERT/RoBERTa for deep sentiment modeling
Study visibility using user behavior data
Explore cross-linguistic and cross-platform patterns
