arquivo <- read.csv(file = 'Bike_Sharing.csv')

View(arquivo)

attach(arquivo)

modelo1 <- lm(cnt ~ temp)
summary(modelo1)

plot(cnt~temp)
abline(modelo1)

fitted(modelo1)

residuals(modelo1)

modelo2 <- lm(cnt ~ temp + atemp)
summary(modelo2)

modelo3 <- lm(cnt ~ temp * atemp)
summary(modelo3)


#Variáveis preditoras qualitativas
# criar variáveis dicotômicas
season1 = season
season1 = ifelse(season==1,"1","0")
season2 = season
season2 = ifelse(season==2,"1","0")
season3 = season
season3 = ifelse(season==3,"1","0")
season4 = season
season4 = ifelse(season==4,"1","0")
weathersit1 = weathersit
weathersit1 = ifelse(weathersit==1,"1","0")
weathersit2 = weathersit
weathersit2 = ifelse(weathersit==2,"1","0")
weathersit3 = weathersit
weathersit3 = ifelse(weathersit==3,"1","0")

modelo2 <- lm(cnt ~ temp + season2 + season3 + season4 + mnth + weathersit1 + weathersit2)

summary(modelo2)

fitted(modelo2)

residuals(modelo2)

rstandard(modelo2)

modelo3 <- lm(cnt ~ temp * atemp + 
                    season2 + season3 + season4 + 
                    hum + windspeed +
                    weathersit2 + weathersit3)

summary(modelo3)
