install.packages("readxl")
install.packages("gmodels")

library(readxl)
library(gmodels)

Banco <- read_excel("./Banco.xlsx")

View(Banco)

attach(Banco)

Banco$soma <- apply(Banco[, 9:10], 1, sum)
Banco$soma1 <- cartao_credito + Emprestimos

by(salário, sexo, mean)

table(sexo)
table(salário)
table(sexo, catemp)

CrossTable(sexo, catemp)
CrossTable(sexo, catemp, chisq = T)
