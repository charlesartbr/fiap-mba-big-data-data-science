a <- c(1, 2, 3)
b <- c(2, 2, 5)

a + b
a - b
a * b
a ** b

x <- paste("Charles", "Cavalcante", sep=" ")
x
substr(x, 5, 11)

x = c(1, 2, 3, 4, 5, 6, 7, 8, 9)
sum(x)
mean(x)
median(x)
sd(x)
max(x)
min(x)
range(x)

sexo <- c(1,2,1,2)
sexo
is.numeric(sexo)
sexoo <- factor(sexo, 
                levels = c(1,2), 
                labels = c("Masculino", "Feminino"))
sexoo
summary(sexoo)
is.numeric(sexoo)
is.factor(sexoo)
