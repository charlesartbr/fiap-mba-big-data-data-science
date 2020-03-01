install.packages("car")
install.packages("sjPlot")
install.packages("Amelia")
install.packages("HH")
install.packages("MASS")

library(tidyverse)
library(corrplot)
library(ggplot2)
library(ggstatsplot)
library(lubridate)
library(gridExtra)
library(caTools)
library(car)
library(GGally)
library(readxl)
library(MASS)
library(Amelia)
library(HH)
library(sjPlot)

boston <- read.csv(file = "Boston_Housing_Data.csv")

View(boston)

boston <- boston[,c(-1,-2)]

summary(boston)

boston_cor <- round(cor(boston), 2)
corrplot(round(cor(boston), 2), method = "color")

# bedrooms, bathroom
cor(boston$bedrooms, boston$bathrooms)
# view, grade 
cor(boston$view, boston$grade)
# sqft_living, sqft_above, sqft_basement, sqft_living15
cor(boston$sqft_living, boston$sqft_above)
cor(boston$sqft_living, boston$sqft_basement)
cor(boston$sqft_living, boston$sqft_living15)
cor(boston$sqft_above, boston$sqft_basement)
cor(boston$sqft_above, boston$sqft_living15)
cor(boston$sqft_basement, boston$sqft_living15)

data = boston[,c(1, 2, 3, 4, 8, 10, 12)]
data

set.seed(41) # semente para reproduzir os mesmos dados
sample = sample.split(data, SplitRatio=0.8) # separação em 80%
train_data = subset(data, sample==TRUE) # dados de treino
test_data = subset(data, sample==FALSE) # dados de teste


modelo <- lm(price ~ ., data=train_data)
summary(modelo)

predicao <- predict(newdata=test_data, modelo)

teste <- data.frame(actual=test_data$price, predicted=predicao)

predicao <- predict(newdata=test_data, modelo)
teste <- data.frame(actual=test_data$price, predicted=predicao)
media <- mean(abs(teste$actual-teste$predicted) / teste$actual)
acuracia <- 1 - media
acuracia
