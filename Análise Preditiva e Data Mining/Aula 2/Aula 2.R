data <- read.csv(file = 'Bike_Sharing.csv')

View(data)

attach(data)

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
