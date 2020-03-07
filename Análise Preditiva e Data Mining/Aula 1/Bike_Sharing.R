data <- read.csv(file = 'Bike_Sharing.csv')

View(data)


temp_max = 39 # temperatura original máxima
temp_min = -8 # temperatura original mínima

# formula para voltar a variável original
data$temp_original = data$temp * (temp_max - temp_min) + temp_min

# para plotar lado a lado
par(mfrow=c(1,2))

# histograma da variável normalizada “temp”
hist(data$temp)

# histograma da variável original “temp_original”
hist(data$temp_original)



atemp_max = 50  # sensação de temperatura original máxima
atemp_min = -16 # sensação de temperatura original mínima

# formula para voltar a variável original
data$atemp_original = data$atemp * (atemp_max - atemp_min) + atemp_min

# para plotar lado a lado
par(mfrow=c(1,2))

# histograma da variável normalizada “atemp”
hist(data$atemp)

# histograma da variável original “atemp_original”
hist(data$atemp_original)



# formula para voltar a variável original
data$hum_original = data$hum * 100

# para plotar lado a lado
par(mfrow=c(1,2))

# histograma da variável normalizada “hum”
hist(data$hum)

# histograma da variável original “hum_original”
hist(data$hum_original)



# formula para voltar a variável original
data$windspeed_original = data$windspeed * 67

# para plotar lado a lado
par(mfrow=c(1,2))

# histograma da variável normalizada “windspeed”
hist(data$windspeed)

# histograma da variável original “windspeed_original”
hist(data$windspeed_original)

