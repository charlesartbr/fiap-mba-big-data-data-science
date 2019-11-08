install.packages("readxl")
install.packages("gmodels")

library(readxl)
library(gmodels)

Banco <- read_excel("./Banco.xlsx")

View(Banco)

attach(Banco)

selecao_colunas <- Banco[,c("id", "sexo")]
selecao_colunas

selecao_colunas1 <- Banco[10:20,c("id", "sexo")]
selecao_colunas1

selecao_colunas2 <- Banco[sexo=="Masculino",]
selecao_colunas2

selecao_colunas3 <- Banco[sexo=="Masculino" & catemp=="A",]
selecao_colunas3

selecao_colunas4 <- Banco[sexo=="Masculino" | catemp=="A",]
selecao_colunas4

selecao_linhas <- Banco[estudo>=12 | catemp=="A",]
selecao_linhas

selecao_linhas1 <- Banco[estudo>=12 | catemp==c("A","C"),]
selecao_linhas1

selecao_linhas2 <- Banco[sexo=="Masculino" & estudo>=10,c("id","sexo","catemp")]
selecao_linhas2

outra_forma <- subset(Banco, sexo=="Masculino" & estudo>=10)
outra_forma

outra_forma1 <- subset(Banco, sexo=="Masculino" & estudo>=10, select=c(id,sexo))
outra_forma1



