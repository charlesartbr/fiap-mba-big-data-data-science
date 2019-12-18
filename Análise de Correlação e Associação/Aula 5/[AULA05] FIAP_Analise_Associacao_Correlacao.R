#************************************EXEMPLO 01*********************************************************
#Age of Death of Successive Kings of England
#starting with William the Conqueror
#Source: McNeill, "Interactive Data Analysis"

kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat",skip=3)
kings

#Convertendo em um base com formato temporal
class(kings)
kingstimeseries <- ts(kings)
kingstimeseries
class(kingstimeseries)
plot.ts(kingstimeseries)

#METODO 01 - MEDIAS MOVEIS
#Utilizando as media moveis
install.packages("TTR")
install.packages("fpp2")
install.packages("smooth")
install.packages("MLmetrics")
library(TTR)
library(fpp2)
library(smooth)
library(MLmetrics)
kingstimeseriesSMA8 <- SMA(kingstimeseries,n=8) #Utiliza media movel dos ultimos 8 meses
plot.ts(kingstimeseriesSMA8)

#Predizendo os proximos pontos 3 de tempo, utilizando medias moveis de ordem 8
pred_3<-forecast(sma(kingstimeseries, order = 8),h=3)
predito<-pred_3$fitted
realizado<-pred_3$y
MAPE<-MAPE(predito, realizado)
MAPE

#METODO 02 - ALISAMENTO EXPONENCIAL SIMPLES
#Utilizando Alisamento Exponencial (MAIS ADEQUADO PARA BASES NAO SAZONAIS)
library(tidyverse)
library(fpp2)
View(goog) # Acoes do Google na bolsa
#Criar bases de treino e validacao
goog.train <- window(goog, end = 900)
goog.test <- window(goog, start = 901)
#Calculo do alisamento exponencial
ses.goog <- ses(goog.train, alpha = .2, h = 100)
autoplot(ses.goog)
#Diferenciando os dados para tirar a tendencia
goog.dif <- diff(goog.train)
autoplot(goog.dif)
#Calculo do alisamento exponencial para a base sem tendencia
ses.goog.dif <- ses(goog.dif, alpha = .2, h = 100)
autoplot(ses.goog.dif)
#Avaliando a acuracia da previsao
goog.dif.test <- diff(goog.test)
accuracy(ses.goog.dif, goog.dif.test)
#Encontrando o alpha (para o alisamento) que minimiza o erro (RMSE)
alpha <- seq(.01, .99, by = .01)
RMSE <- NA
for(i in seq_along(alpha)) {
  fit <- ses(goog.dif, alpha = alpha[i], h = 100)
  RMSE[i] <- accuracy(fit, goog.dif.test)[2,2]
}

# convert to a data frame and idenitify min alpha value
alpha.fit <- data_frame(alpha, RMSE)
alpha.min <- filter(alpha.fit, RMSE == min(RMSE))

# plot RMSE vs. alpha
ggplot(alpha.fit, aes(alpha, RMSE)) +
  geom_line() +
  geom_point(data = alpha.min, aes(alpha, RMSE), size = 2, color = "blue")  

# recalibrando a previsao com alpha = .05
ses.goog.opt <- ses(goog.dif, alpha = .05, h = 100)

# performance eval
accuracy(ses.goog.opt, goog.dif.test)

# plotting results
p1 <- autoplot(ses.goog.opt) +
  theme(legend.position = "bottom")
p2 <- autoplot(goog.dif.test) +
  autolayer(ses.goog.opt, alpha = .5) +
  ggtitle("Predicted vs. actuals for the test data set")

gridExtra::grid.arrange(p1, p2, nrow = 1)

#METODO 03 - ALISAMENTO EXPONENCIAL PARA DADOS SAZONAIS
#Utilizando Alisamento Exponencial Holt-Winters (MAIS ADEQUADO PARA BASES SAZONAIS)
#Tem dois parametros, alpha (nivel) e beta (tendencia)
holt.goog <- holt(goog.train, h = 100)
autoplot(holt.goog)
holt.goog$model
accuracy(holt.goog, goog.test)

#Identificando os valores otimos de alpha e beta que minimiza o erro (RMSE)
# identificando parametros otimos
beta <- seq(.0001, .5, by = .001)
RMSE <- NA
for(i in seq_along(beta)) {
  fit <- holt(goog.train, beta = beta[i], h = 100)
  RMSE[i] <- accuracy(fit, goog.test)[2,2]
}

# convert to a data frame and idenitify min alpha value
beta.fit <- data_frame(beta, RMSE)
beta.min <- filter(beta.fit, RMSE == min(RMSE))

# plot RMSE vs. beta
ggplot(beta.fit, aes(beta, RMSE)) +
  geom_line() +
  geom_point(data = beta.min, aes(beta, RMSE), size = 2, color = "blue")  
 
#novo modelo com o beta otimo
holt.goog.opt <- holt(goog.train, h = 100, beta = 0.0601)

#Acuracia dos modelos
#Primeiro modelo
accuracy(holt.goog, goog.test)
#Modelo otimo
accuracy(holt.goog.opt, goog.test)


#Comparando os graficos das previsoes
p1 <- autoplot(holt.goog) +
  ggtitle("Original Holt's Model") +
  coord_cartesian(ylim = c(400, 1000))

p2 <- autoplot(holt.goog.opt) +
  ggtitle("Optimal Holt's Model") +
  coord_cartesian(ylim = c(400, 1000))

gridExtra::grid.arrange(p1, p2, nrow = 1)


#METODO 04 - REGRESSAO LINEAR
data("AirPassengers")
AP <- AirPassengers
plot(AP, ylab="Passengers (1000s)", type="o", pch =20)
#Decompondo os dados
AP.decompM <- decompose(AP, type = "multiplicative")
plot(AP.decompM)
#Ajustando um modelo linear
t <- seq(1, 144, 1)
modelTrend <- lm(formula = AP.decompM$trend ~ t)
predT <- predict.lm(modelTrend, newdata = data.frame(t))

plot(AP.decompM$trend[1:144] ~ t[1:144], ylab="T(t)", xlab="t",
     type="p", pch=20, main = "Trend Component: Modelled vs Observed")
lines(predT, col="red")

summary(modelTrend)

#Gerando as previsoes para os 12 meses seguintes
Data1961 <- data.frame("T" = 2.667*seq(145, 156, 1) + 84.648, S=rep(0,12), e=rep(0,12),
                       row.names = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
Data1961

#Calculando a acuracia do modelo
View(AP)
class(AP)
AP<-as.data.frame(AP)
class(AP)
View(AP)
str(AP)
AP$realizado<-AP$x
AP$time<-seq(1,144,1)
AP$predito<-2.667*AP$time+84.648
View(AP)
MAPE<-MAPE(AP$predito, AP$realizado)
MAPE



