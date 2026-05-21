# ============================================
# PREDICTIVE MODELS IN R
# Case: 6-Month Colorectal Tumor Recurrence
# ============================================

# Load required libraries
library(tidyverse)
library(caret)
library(rpart)
library(rpart.plot)
library(pROC)

# Load the dataset (adjust the path if necessary)
data <- read.csv("recurrencia_tumoral.csv")

# ============================================
# DATA CLEANING: Translate variables to English
# ============================================
data <- data %>%
  rename(
    Age = Edad,
    Sex = Sexo,
    CEA_level = BiomarcadorX,
    Recurrence_6m = Recurrencia_6m
  )

# Inspect the first few rows
head(data)

# Convert Sex to factor for categorical modeling
data$Sex <- as.factor(data$Sex)

# Split data into training (80%) and testing (20%) sets
set.seed(123)
train_index <- createDataPartition(data$Recurrence_6m, p = 0.8, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# ============================================
# MODEL 1: LOGISTIC REGRESSION
# ============================================
modelo_log <- glm(Recurrence_6m ~ Age + Sex + CEA_level, 
                  data = train_data, 
                  family = binomial)

# View model coefficients and statistical significance
summary(modelo_log)  

# Predictions and probability extraction
prob_log <- predict(modelo_log, newdata = test_data, type = "response")
pred_log <- ifelse(prob_log > 0.5, 1, 0)

# Confusion Matrix to evaluate specificty and sensitivity
confusionMatrix(factor(pred_log), factor(test_data$Recurrence_6m))

# ROC Curve generation and AUC calculation
roc_log <- roc(test_data$Recurrence_6m, prob_log)
plot(roc_log, col = "blue", main = "ROC Curve - Logistic Regression")
auc(roc_log)

# ============================================
# MODEL 2: DECISION TREE
# ============================================
modelo_arbol <- rpart(Recurrence_6m ~ Age + Sex + CEA_level,
                      data = train_data,
                      method = "class",
                      cp = 0.01)

# 1. Expand R graphic window margins: c(bottom, left, top, right)
par(mar = c(5, 5, 5, 5))

# 2. Plot using 'tweak' to subtly reduce size (e.g., 0.9)
# This shrinks boxes and text to fit perfectly inside the canvas without cutting branches.
rpart.plot(modelo_arbol, 
           type = 2, 
           extra = 104, 
           fallen.leaves = TRUE,
           tweak = 0.9)

# 3. Predictions and evaluation
pred_arbol <- predict(modelo_arbol, newdata = test_data, type = "class")

# Confusion Matrix
confusionMatrix(pred_arbol, factor(test_data$Recurrence_6m))

# Probabilities for ROC curve and AUC calculation
prob_arbol <- predict(modelo_arbol, newdata = test_data)[,2]
roc_arbol <- roc(test_data$Recurrence_6m, prob_arbol)
plot(roc_arbol, col = "darkgreen", main = "ROC Curve - Decision Tree")
auc(roc_arbol)
