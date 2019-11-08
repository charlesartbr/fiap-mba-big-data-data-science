install.packages("sqldf")
install.packages("readxl")
install.packages("plyr")

library(readxl)
library(sqldf)
library(plyr)

Banco <- read_excel("./Banco.xlsx")

View(Banco)

attach(Banco)

feminino <- sqldf("SELECT * FROM Banco WHERE sexo = 'Feminino'")
feminino

media <- sqldf("SELECT avg(salário) FROM Banco")
media

Apend_1 <- read_excel("./Apend_1.xlsx")
View(Apend_1)

Apend_2 <- read_excel("./Apend_2.xlsx")
View(Apend_2)

uniao <- rbind(Apend_1, Apend_2)
uniao

Apend_1111 <- read_excel("./Apend_1111.xlsx")
View(Apend_1111)

uniao1 <- rbind(Apend_1111, Apend_2)
uniao1

# com plyr
uniao2 <- rbind.fill(Apend_1111, Apend_2)
uniao2

Apend_A <- read_excel("./Apend_A.xlsx")
View(Apend_A)

Apend_B <- read_excel("./Apend_B.xlsx")
View(Apend_B)

chave <- merge(Apend_A, Apend_B, by="id")
chave

full <- merge(Apend_A, Apend_B, by="id", all=TRUE)
full

left <- merge(Apend_A, Apend_B, by="id", all.x=TRUE)
left

right <- merge(Apend_A, Apend_B, by="id", all.y=TRUE)
right

chave1 <- sqldf("SELECT * FROM Apend_A JOIN Apend_B ON Apend_B.id=Apend_A.id")
chave1

full1 <- sqldf("SELECT Apend_A.*, Apend_B.* FROM Apend_A 
                LEFT JOIN Apend_B ON Apend_B.id=Apend_A.id
                UNION 
                SELECT Apend_A.*, Apend_B.* FROM Apend_B 
                JOIN Apend_A ON Apend_A.id=Apend_B.id WHERE Apend_A.id IS NULL")
full1

left1 <- sqldf("SELECT * FROM Apend_A LEFT JOIN Apend_B ON Apend_B.id=Apend_A.id")
left1

right1 <- sqldf("SELECT * FROM Apend_B LEFT JOIN Apend_A ON Apend_A.id=Apend_B.id")
right1


Apend_B = sqldf(c("UPDATE Apend_B SET Salario = 9999 WHERE id = 1",
                  "SELECT * FROM Apend_B"))

Apend_B = sqldf(c("INSERT INTO Apend_B VALUES (8, 500, 'Ensino Médio')",
                  "SELECT * FROM Apend_B"))
Apend_B


x <- seq(1, 100, by=5)
z <- mean(x)
y <- ifelse(x>z, "Acima da média", "Abaixo da média")
y


Banco$media <- (cartao_credito + Emprestimos) / 2
Banco

Banco$classe <-NA
Banco

media <- as.numeric(Banco$media)
min(media)
max(media)

for (i in 1:nrow(Banco)){
  if(Banco[i, "media"] >= 10000){
    Banco[i,"classe"] <- "classe A"
  } else if (Banco[i,"media"] < 10000 & Banco[i, "media"] >= 5000) {
    Banco[i,"classe"] <- "classe B"
  }else{
    Banco[i,"classe"] <- "classe C"
  }
}
Banco
table(Banco$classe)


Banco$resultado <-ifelse(estudo > 15, "Doutorado", "Mestrado")
Banco

install.packages("ggplot2")
library(ggplot2)

dispersao <- ggplot(Banco, aes(x=estudo, y=salário, color=sexo))
dispersao + geom_point()

barplot(prop.table(table(Banco$sexo))*100, 
        col=c("blue", "red"),
        title("frequencia", xlab="sexo", ylab="%"))
barplot

boxplot(Banco$salário)
boxplot(Banco$salário ~ Banco$sexo)

Banco[order(Banco$salário, decreasing = TRUE),]
summary(Banco$salário)

q1 = quantile(Banco$salário, 0.25, names = FALSE)
q3 = quantile(Banco$salário, 0.75, names = FALSE)
outliner = q3 + (q3 - q1) * 1.5

Banco$novoSalario <- replace(Banco$salário, Banco$salário > outliner, outliner)
Banco

boxplot(Banco$novoSalario)

summary(Banco$salário)
summary(Banco$novoSalario)


install.packages("tcltk")
library(tcltk)

cc <- tkmessageBox(title="Arquivo", message="Teste", icon="info", type="abortretryignore")
cc