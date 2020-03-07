# utilizando a função read.table para ler o arquivo CSV
arquivo<-read.table(file="Bike_Sharing.csv", header=T,sep=",")

# dimensão da base de dados (tabela)
dim(arquivo)

# nomes das variáveis
names(arquivo)

# visualizar primeiras 20 linhas
head(arquivo,20)

attach(arquivo)

# selecionar as variáveis quantitativas
dadosquant=subset(arquivo,select=c(cnt,temp,weekday))
summary(dadosquant)

#Análise da variável CNT
hist(cnt, xlab="Número de bikes alugadas", ylab="Freq. Absoluta", main="Histograma do Número de bikes alugadas")

# Calcular a média da variável CNT
media<-mean(cnt)
print(media)

# Calcular o desvio padrão da variável CNT
dp<-sd(cnt)
print(dp)

# Calcular o coeficiente de variação da variável CNT
cv<-sd(cnt)/mean(cnt)
print(cv)


dadosquant=subset(arquivo,select=c(temp, atemp, hum, windspeed, casual, registered, cnt))

summary(temp)
summary(season)
season <- as.factor(season)
summary(season)

summary(dadosquant)

# distribuição irregular, a mediana é a melhor medida
hist(casual)

# distribuição normal, a medía é a melhor medida
hist(cnt)


matriz <- cor(dadosquant)

install.packages("corrplot")
library(corrplot)
corrplot


corrplot(matriz)
corrplot(matriz, method = "color")
corrplot(matriz, method = "ellipse")
corrplot(matriz, method = "shade")

corrplot(matriz, method = "number")
corrplot(matriz, type="lower", method = "number")

install.packages("Hmisc")
library(Hmisc)

matriz <- rcorr(as.matrix(dadosquant))

matriz$r
matriz$P
matriz$n

#plot
# corrplot(matriz$r,p,mat=matriz$P,sig.level=0.005)
# corrplot(m$r,p,mat=matriz$P,sig.level=0.005, method="number", type="upper")


# gráfico de dispersão
plot(cnt~temp)

# pacote correlação
cor(cnt,temp)
# teste estatístico
cor.test(cnt, temp, method="pearson")

# stugers
k = floor(1 + 3.3 * log(731, 10))
amplitude = ceil((max(cnt) - min(cnt)) / k)

# stugers com library
install.packages("fdth")
library(fdth)

f = fdt(arquivo$cnt)
f

arquivo$faixacnt <- cut(cnt
                        , breaks = c(22, 892, 1762, 2632, 3502, 4372, 5242, 6112, 6982, 7851, 8720)
                        , right = F
                        , labels = c('[22 a 892]','(892 a 1762]', '(1762 a 2632]', '(2632 a 3502]','(3502 a 4372]', '(4372 a 5242]','(5242 a 6112]', '(6112 a 6982]', '(6982 a 7851]', '(7851 a 8720]'))


table(arquivo$faixacnt, holiday)

prop.table(table(arquivo$faixacnt, holiday))

x <- matrix(c(temp, atemp, hum, windspeed, casual, registered, cnt), nc=2)
chisq.test(x)

x<-matrix(c(13,57,68,69,121,136,77,75,77,17,0,5,3,4,1,1,4,2,1,0), nc=2);x
chisq.test(x)

x<-matrix(c(13+57+68,69+121+136,77+75+77+17,0+5+3,4+1+1,4+2+1+0), nc=2);x
chisq.test(x)
