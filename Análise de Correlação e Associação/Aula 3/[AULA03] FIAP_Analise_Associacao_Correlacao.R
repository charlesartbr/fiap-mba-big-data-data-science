
library(readxl)
#Importacao da tabela "Loan Payments Data"
loan<-read_excel("Loan_Payments_Data.xlsx", sheet ="Planilha1")
View(loan)
loan$classif<-ifelse(loan$loan_status == "COLLECTION", 1, 0)
View(loan)
table(loan$loan_status)
table(loan$classif)

#Categorizacao da variavel "age" em 15 bins
library(arules)
loan$age_cl<-discretize(loan$age, "frequency", breaks = 15)
View(loan)
table(loan$age_cl)

#Calculo do Information Value e do WOE
library(Information)
IV <- create_infotables(data = loan, y = "classif")
IV_valor<-data.frame(IV$Summary)
print(IV$Tables$age_cl, row.names=FALSE)
age_cl=data.frame(IV$Tables$age_cl)
View(age_cl)
plot_infotables(IV, "age_cl")


#Novo agrupamento de age_cl, agora em 5 grupos
loan$age_cl_I<-ifelse(loan$age<25, 1,
                      ifelse(loan$age<27, 2,
                             ifelse(loan$age<32, 3,
                                    ifelse(loan$age<33, 4,
                                           ifelse(loan$age>=33, 5, 0)))))
View(loan)
IV <- create_infotables(data = loan, y = "classif", ncore = 2)
IV$Summary
IV_valor<-data.frame(IV$Summary)
View(IV_valor)
print(IV$Tables$age_cl_I, row.names=FALSE)
age_cl_I=data.frame(IV$Tables$age_cl_I)
View(age_cl_I)
plot_infotables(IV, "age_cl_I")


#Teste do optimal binning para a variavel Idade, da base Emprestimo Bancario


install.packages("smbinning")
library(smbinning)
empbanc<-read_excel("Emprestimo_Bancario.xlsx")
empbanc<-as.data.frame(empbanc)
idade_optbin<-smbinning(df=empbanc, y="classif", x="idade", p=0.05)
idade_optbin
empbanc$idade_optbin_cl<-ifelse(empbanc$idade<=26,1,
                                ifelse(empbanc$idade<=31,2,
                                       ifelse(empbanc$idade<=40,3,0)))

empbanc$idade_quartis<-discretize(empbanc$idade, "frequency", breaks = 15)
View(empbanc)
IV <- create_infotables(data = empbanc, y = "classif")
IV$Summary


#Agrupando cada variavel em classes (nesse caso, 4 classes)
library(arules)
idade_cl<-discretize(empbanc$idade, "frequency", breaks =  4)
experiencia_cl<-discretize(empbanc$experiencia, "frequency", breaks = 4)
tempend_cl<-discretize(empbanc$tempo_endereco, "frequency", breaks = 4)
renda_cl<-discretize(empbanc$renda, "frequency", breaks = 4)
empbanc<-data.frame(empbanc, idade_cl, experiencia_cl,tempend_cl,renda_cl)
View(empbanc)


#Cruzando cada variavel com o target "classif"
install.packages("descr")
library(descr)
CrossTable(empbanc$idade_cl, empbanc$classif, prop.r = FALSE, prop.t = FALSE, prop.chisq = FALSE)
CrossTable(empbanc$educacao, empbanc$classif, prop.r = FALSE, prop.t = FALSE, prop.chisq = FALSE)
CrossTable(empbanc$experiencia_cl, empbanc$classif, prop.r = FALSE, prop.t = FALSE, prop.chisq = FALSE)
CrossTable(empbanc$tempend_cl, empbanc$classif, prop.r = FALSE, prop.t = FALSE, prop.chisq = FALSE)
CrossTable(empbanc$idade_optbin_cl, empbanc$classif, prop.r = FALSE, prop.t = FALSE, prop.chisq = FALSE)

#Calculando o nivel de importancia de cada variavel para explicar "classif"
install.packages("Information")
library(Information)
empbanc_select<-empbanc[,c(3,7,8,9,10,11)]
View(empbanc_select)
IV <- create_infotables(data = empbanc_select, y = "classif", ncore = 2)
print(head(IV$Summary, 10), row.names = FALSE)
print(IV$Tables$experiencia_cl, row.names = FALSE) #Apenas para exemplificar


#Analise da correlacao entre variaveis da base MTCARS usando um SCATTERPLOT
data(mtcars)
install.packages("ggstatsplot")
library(ggstatsplot)

#Matriz de correlacao entre todas as variaveis
round(cor(mtcars),2)
install.packages("corrplot")
library(corrplot)
corrplot(round(cor(mtcars),2), method = "circle")

#Analise da correlacao entre as variaveis mpg e wt
ggscatterstats(
  data = mtcars,                                          
  x = mpg,                                                  
  y = wt,
  xlab = "MPG - Milhas por galão",
  ylab = "WT - Peso do carro ",
  marginal = TRUE,
  marginal.type = "histogram",
  centrality.para = "mean",
  margins = "both",
  title = "Relação entre MPG e WT",
  messages = FALSE
)
