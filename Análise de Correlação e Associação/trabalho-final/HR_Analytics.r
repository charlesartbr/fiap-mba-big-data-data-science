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
library(arules)
library(descr)
library(Information)

hr <- read_excel("HR_Analytics.xlsx")

View(hr)

hr <- hr[,c(-1)]

corrplot(round(cor(hr[,c(-9, -10)]), 2), method = "color")

satisfaction_level_cl <- discretize(hr$satisfaction_level, "frequency", breaks=4)
last_evaluation_cl <- discretize(hr$last_evaluation, "frequency", breaks=4)
average_montly_hours_cl <- discretize(hr$average_montly_hours, "frequency", breaks=4)

hr <- data.frame(hr, satisfaction_level_cl, last_evaluation_cl, average_montly_hours_cl)

View(hr)

CrossTable(hr$satisfaction_level_cl, hr$left, prop.r=FALSE, prop.t=FALSE, prop.chisq=FALSE)
CrossTable(hr$last_evaluation_cl, hr$left, prop.r=FALSE, prop.t=FALSE, prop.chisq=FALSE)
CrossTable(hr$average_montly_hours_cl, hr$left, prop.r=FALSE, prop.t=FALSE, prop.chisq=FALSE)
CrossTable(hr$number_project, hr$left, prop.r=FALSE, prop.t=FALSE, prop.chisq=FALSE)
CrossTable(hr$time_spend_company, hr$left, prop.r=FALSE, prop.t=FALSE, prop.chisq=FALSE)
CrossTable(hr$Work_accident, hr$left, prop.r=FALSE, prop.t=FALSE, prop.chisq=FALSE)
CrossTable(hr$promotion_last_5years, hr$left, prop.r=FALSE, prop.t=FALSE, prop.chisq=FALSE)

IV <- create_infotables(data = hr[, c(-1,-2,-4)], y = "left")
print(head(IV$Summary, 100), row.names = FALSE)

data = hr[, c(3, 5, 7, 10, 11, 12)]

set.seed(41) # semente para reproduzir os mesmos dados
sample = sample.split(data, SplitRatio=0.8) # separação em 80%
train_data = subset(data, sample==TRUE) # dados de treino
test_data = subset(data, sample==FALSE) # dados de teste

modelo <- glm(left ~ ., family=binomial(link='logit'), data=train_data)

predicao <- predict(modelo, newdata=test_data, type="response")

ks.test(predicao[test_data$left==0],predicao[test_data$left==1])
