# Clinical Predictive Modeling: 6-Month Colorectal Cancer Tumor Recurrence

This repository contains a comparative predictive analysis benchmarking **Logistic Regression** against a **Decision Tree (Classification Tree)** model in R. The goal is to evaluate their capacity to predict 6-month tumor recurrence in post-treatment Colorectal Cancer patients using clinical demographics and tumor biomarkers.

## 📋 Project Overview

In translational oncology, high predictive accuracy must be balanced with transparency and clinical interpretability. This project demonstrates how to construct machine learning workflows in R, unpack their statistical outputs into actionable medical insights, and present visual decision boundaries suitable for tumor board evaluations.

## 🗂️ Dataset & Features

The dataset includes post-treatment clinical records with the following standardized features:
* `Age`: Patient's age at evaluation (continuous).
* `Sex`: Patient's biological sex (categorical factor: `Female`, `Male`).
* `CEA_level`: Carcinoembryonic Antigen level in ng/mL (continuous tumor biomarker).
* `Recurrence_6m`: 6-month recurrence status (`1` = Recurrence, `0` = No Recurrence).

---

## 🔬 Models Performance & Comparison

### 1. Logistic Regression (Generalized Linear Model)
A parametric model utilized for its mathematical rigor, probability calibration, and generation of **Odds Ratios (OR)** via the exponential transformation of log-odds coefficients.

* **CEA Level ($p < 0.001$):** Highly statistically significant biomarker. Holding other factors constant, each 1 ng/mL increase in CEA multiplies the odds of recurrence by approximately 1.05.
* **Age ($p = 0.0054$):** Statistically significant factor, representing a steady risk increment per additional year.

#### Performance Metrics:
```text
Accuracy : 0.7750     | AUC-ROC : 0.9348
Kappa : 0.5545        | 'Positive' Class : 0
Sensitivity : 0.8947  | Specificity : 0.6667
```

### 2. Classification Decision Tree (rpart)
A non-parametric machine learning architecture implemented via recursive partitioning to evaluate if an algorithmic rule-based approach optimizes predictive performance over classical models.
Model Performance Summary (Confusion Matrix & Statistics):

```text
Reference
Prediction   0   1
         0  18   6
         1   1  15

Accuracy : 0.8250     | AUC-ROC : 0.8835
Kappa : 0.6535        | 'Positive' Class : 0
Sensitivity : 0.9474  | Specificity : 0.7143
Pos Pred Value : 0.75 | Neg Pred Value : 0.9375
```

#### Key Interpretations:
* **Overall Accuracy:** The Decision Tree outperformed Logistic Regression in overall classification accuracy (82.5% vs. 77.5%).
* **Sensitivity & Specificity:** Achieved a remarkable 94.74% Sensitivity and an improved 71.43% Specificity for the baseline class, successfully identifying clinical high-risk groups.
* **Discrimination Power:** Yielded a strong AUC-ROC of 0.8835, proving the validity of CEA_level and Age thresholds for immediate stratification.

### 🚀 How to Run This Project
1. Clone the repository:
git clone [https://github.com/davidvillafan96/clinical-colorectal-cancer-recurrence_prediction.git](https://github.com/davidvillafan96/clinical-colorectal-cancer-recurrence_prediction.git)

2. Ensure dependencies are installed in R:
install.packages(c("tidyverse", "caret", "rpart", "rpart.plot", "pROC"))

**Run the script:** Open clinical_recurrence_models.R in RStudio and execute the pipeline. Ensure recurrencia_tumoral.csv is present in your working directory.
