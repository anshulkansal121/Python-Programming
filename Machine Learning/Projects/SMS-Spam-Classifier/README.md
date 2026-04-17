# 📩 SMS Spam Classifier

> An end-to-end Natural Language Processing pipeline that classifies SMS messages as **Spam** or **Ham** using Machine Learning — built with Python, NLTK, and Scikit-learn.

---

## 🚀 Overview

Spam messages are a persistent threat to user experience and digital safety. This project builds an intelligent, high-precision binary text classifier that can detect spam SMS messages in real time — covering the complete ML lifecycle from raw data to evaluated model.

**Best Model: TF-IDF + Multinomial Naive Bayes → ~97% Accuracy | High Precision**

---

## 📁 Project Structure

```
SMS-Spam-Classifier/
│
├── Data/
│   └── spam.csv                   # Raw SMS dataset (5,572 messages)
│
├── SMS_Spam_Classifier.ipynb      # Main notebook: full pipeline
└── README.md
```

---

## 🔄 Pipeline Walkthrough

### 1. 🧹 Data Cleaning
- Loaded `spam.csv` with ISO-8859-1 encoding to handle special characters
- Dropped 3 redundant unnamed columns; renamed `v1 → target`, `v2 → text`
- Label-encoded target: **Spam = 1 | Ham = 0**
- Removed **403 duplicate rows** → final clean dataset: **5,169 records**

---

### 2. 📊 Exploratory Data Analysis (EDA)
- Identified class imbalance: **~87% Ham vs ~13% Spam**
- Engineered 3 structural features per message:
  - `num_characters` — total character count
  - `num_words` — total word count
  - `num_sentences` — total sentence count
- **Key Finding:** Spam messages are significantly longer than ham on average
- Validated feature correlation using a heatmap — `num_characters` had the strongest correlation with spam

---

### 3. ✂️ NLP Text Preprocessing

Applied a custom `transform_text()` pipeline to every message:

```
Raw Text
   ↓
Lowercasing
   ↓
Tokenization (NLTK)
   ↓
Remove Special Characters
   ↓
Remove Stopwords & Punctuation
   ↓
Porter Stemming
   ↓
Clean Tokens
```

Example:
```
Input  → "HI ANSHUL KANSAL... how was your day?"
Output → "hi anshul kansal day"
```

---

### 4. 🔍 Visual Text Analysis
- Generated **Word Clouds** for Spam and Ham classes
- Spam cloud reveals high-signal keywords: *free, call, win, claim, prize*
- Plotted **Top 30 most frequent words** per class via bar charts to confirm vocabulary divergence

---

### 5. ⚙️ Feature Engineering — Vectorization

Two strategies compared:

| Vectorizer | Description |
|---|---|
| `CountVectorizer` | Raw word frequency counts |
| `TfidfVectorizer` | Penalizes common words; rewards rare discriminative ones (max 3,000 features) |

---

### 6. 🤖 Model Training & Comparison

Trained **3 Naive Bayes variants** under **both vectorizers** — 6 configurations total:

| Model | Vectorizer | Notes |
|---|---|---|
| Gaussian NB | CountVectorizer / TF-IDF | Assumes continuous features |
| **Multinomial NB** | CountVectorizer / **TF-IDF** ✅ | Best for word count / TF-IDF data |
| Bernoulli NB | CountVectorizer / TF-IDF | Best for binary presence/absence |

**Evaluation Metrics:** Accuracy, Precision, Confusion Matrix

> ⚠️ **Precision was prioritized over Recall** — it's worse to flag a legitimate message as spam (false positive) than to miss a spam message.

---

### 7. 🏆 Results

| Model | Vectorizer | Accuracy | Precision |
|---|---|---|---|
| Gaussian NB | TF-IDF | ~86% | Moderate |
| Bernoulli NB | TF-IDF | ~98% | High |
| **Multinomial NB** | **TF-IDF** | **~97%** | **Highest ✅** |

**Winner: Multinomial Naive Bayes + TF-IDF Vectorizer**

---

## 🛠️ Tech Stack

| Category | Tools |
|---|---|
| Language | Python 3 |
| Data Manipulation | Pandas, NumPy |
| NLP | NLTK (tokenization, stopwords, stemming) |
| Visualization | Matplotlib, Seaborn, WordCloud |
| ML / Modeling | Scikit-learn (Naive Bayes, TF-IDF, CountVectorizer) |
| Environment | Jupyter Notebook |

---

## ⚡ Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/anshulkansal121/Python-Programming.git
cd "Python-Programming/Machine Learning/Projects/SMS-Spam-Classifier"
```

### 2. Install dependencies
```bash
pip install pandas numpy nltk scikit-learn matplotlib seaborn wordcloud
```

### 3. Download NLTK data
```python
import nltk
nltk.download('punkt')
nltk.download('stopwords')
```

### 4. Run the notebook
```bash
jupyter notebook SMS_Spam_Classifier.ipynb
```

---

## 📂 Dataset

- **Source:** [UCI SMS Spam Collection Dataset](https://archive.ics.uci.edu/ml/datasets/sms+spam+collection)
- **Size:** 5,572 SMS messages
- **Labels:** `ham` (legitimate) | `spam`
- **After cleaning:** 5,169 records

---

## 📈 Future Improvements

- [ ] Deploy as a **Streamlit web app** for real-time predictions
- [ ] Serialize model with `pickle` for production use
- [ ] Experiment with **deep learning** (LSTM, BERT) for improved context understanding
- [ ] Handle class imbalance with **SMOTE** or weighted loss
- [ ] Add support for **multilingual spam detection**

---

## 👤 Author

**Anshul Kansal**
- GitHub: [@anshulkansal121](https://github.com/anshulkansal121)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
