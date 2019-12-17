
#******************************EXEMPLO 01 - DADOS DE EMPRESTIMOS BANCARIOS***************************
#REGRESSAO LINEAR SIMPLES, #ANALISE DE CORRELACAO, #IDENTIFICACAO DE OUTLIERS

#Analise das variaveis da base EMPRESTIMO BANCARIO
install.packages("Amelia")
library(Amelia)
library(readxl)
library(ggstatsplot)

empbanc<-read_excel("Emprestimo_Bancario.xlsx", sheet = "Plan1")
View(empbanc)
missmap(empbanc, main = "Valores faltantes vs observados")

#Matriz de correlacao entre todas as variaveis
round(cor(empbanc[,-1]),2)
library(sjPlot)
sjp.corr(empbanc)
sjt.corr(empbanc)

#Analise da correlacao entre as variaveis experiencia e renda - Scatterplot simples
cor(empbanc$experiencia, empbanc$renda)
scatter.smooth(x = empbanc$experiencia, y = empbanc$renda, main = "Experiencia vs Renda")
boxplot(empbanc$renda, col = rainbow(12))
summary(empbanc$renda)
#Analise da correlacao com e sem o outlier de renda
cor(empbanc$experiencia, empbanc$renda) #correlacao considerando o outlier
summary(empbanc$renda)
sd(empbanc$renda)
#Filtrando o outlier de renda
empbanc_filtro<-subset(empbanc, renda<2000)
cor(empbanc_filtro$experiencia, empbanc_filtro$renda) #correlacao DESconsiderando o outlier
summary(empbanc_filtro$renda)
sd(empbanc_filtro$renda)


#Tentando explicar a renda do cliente por meio de sua experiencia - COM O OUTLIER
modelo_renda<-lm(renda ~ experiencia, data=empbanc)
summary(modelo_renda)
anova(modelo_renda)

install.packages("HH")
library(HH)

modelo_renda<-lm(debito_renda ~ cred_deb + outros_debitos + classif, data=empbanc)
summary(modelo_renda)
anova(modelo_renda)
vif(modelo_renda)

modelo_renda<-lm(renda ~ cred_deb + outros_debitos, data=empbanc)
summary(modelo_renda)
anova(modelo_renda)
vif(modelo_renda)

#Tentando explicar a renda do cliente por meio de sua experiencia - SEM O OUTLIER
modelo_renda_filtro<-lm(renda ~ experiencia, data=empbanc_filtro)
summary(modelo_renda_filtro)
anova(modelo_renda_filtro)

cor(empbanc)
#Gerando predições na base EMPBANC
empbanc$renda_predita<-fitted(modelo_renda)
View(empbanc)


#**************************************EXEMPLO 02 - DADOS SOBRE VINHOS*******************************
#REGRESSAO LINEAR SIMPLES E MULTIPLA, PADRONIZACAO DE DADOS PARA ENCONTRAR OUTLIERS, GRAFICOS DIAG
#NOSTICOS DOS PRESSUPOSTOS DA REGRESSAO LINEAR
wines <- read_excel("wines.xlsx", sheet = "Plan1")
View(wines)

#Da para explicar o valor da prolina em funcao das demais variaveis?
round(cor(wines[,-1]),2)

#Padronizacao dos dados para identificar potenciais outliers
wine_standard <- scale(wines)
View(wine_standard)
summary(wine_standard)

#Modelo explicativo da prolina
modelo_prolina<-lm(proline ~ ., data=wines)
summary(modelo_prolina)
anova(modelo_prolina)

#Graficos diagnosticos da regressao linear
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(modelo_prolina)

#Gerando predições na base WINES
wines$proline_pred<-fitted(modelo_prolina)
View(wines)

#**************************************EXEMPLO 03 - DADOS DE ALTURAS X PESOS DE MULHERES*************
#AJUSTE DE UM MODELO DE REGRESSAO LINEAR SIMPLES COM AVALIACAO DOS PRESSUPOSTOS

data(women) # Load a built-in data called 'women'
View(women)

fit = lm(weight ~ height, women) # Run a regression analysis
plot(fit)
par(mfrow=c(2,2)) # Change the panel layout to 2 x 2
plot(fit)
par(mfrow=c(1,1)) # Change back to 1 x 1

fit = lm(weight ~ height, women) # Rodar uma analise de regressao linear simples
summary(fit)


#**************************************EXEMPLO 04 - DADOS DE IMOVEIS EM BOSTON************************
#ANALISE DE REGRESSAO LINEAR MULTIPLA, SELECAO DE MODELOS, SINAIS DE MULTICOLINEARIDADE
install.packages("MASS")
install.packages("leaps")
install.packages("relaimpo")
install.packages("bootstrap")
library(readxl)
library(corrplot)
library(HH)
library(MASS)
library(leaps)
library(relaimpo)
library(bootstrap)
bhd<-read_excel("Boston_Housing_Data.xlsx", sheet = "Boston_Housing_Data")
View(bhd)
round(cor(bhd[,c(-1,-2)]),2)
corrplot(round(cor(bhd[,c(-1,-2)]),2),method = "square")
modelo_bhd<-lm(price ~ ., bhd[,c(-1,-2)] )
summary(modelo_bhd)
vif(modelo_bhd) #Testando a presenca de multicolinearidade
cor(bhd$sqft_living, bhd$sqft_above)
str(bhd)
#Retirando variaveis multicolineares e rodando de novo o modelo
modelo_bhd<-lm(price ~ ., bhd[,c(-1,-2,-13,-14)] )
summary(modelo_bhd)
vif(modelo_bhd)

#Selecao de modelos
# Stepwise Regression
modelo_bhd <- lm(price ~ . ,data=bhd[,c(-1,-2,-13,-14)])
step <- stepAIC(modelo_bhd, direction="both")
step$anova # display results

#*******************************EXEMPLO 05 - DADOS DE SALARIOS DE PROFESSORES**********************
#ANALISE DE REGRESSAO LINEAR, SELECAO DE VARIAVEIS E SINAIS DE MULTICOLINEARIDADE

data(Salaries)
View(Salaries)
str(Salaries)

install.packages("lsr")
library(lsr)
library(HH)
correlate(Salaries, corr.method = "pearson")
modelo_professores<-lm(salary ~ ., data = Salaries)
summary(modelo_professores)
step <- stepAIC(modelo_professores, direction="both")
step$anova # display results
vif(modelo_professores)

#*******************************EXEMPLO 06 - FATORES QUE INFLUENCIAM SALARIOS********************************
#ANALISE DE REGRESSAO LINEAR SIMPLES E MULTIPLA
wages<-read_excel("Deterninants_Wages.xlsx", sheet = "Sheet2")
View(wages)
str(wages)
install.packages("Rcpp")
library(Rcpp)
library(Amelia)
missmap(wages)
wages<-as.data.frame(wages)
sjp.corr(wages)
modelo_wages<-lm(WAGE ~ ., data = wages)
summary(modelo_wages)
step <- stepAIC(modelo_wages, direction="both")
step$anova # display results
cor(wages$EDUCATION, wages$EXPERIENCE)
cor(wages$EXPERIENCE, wages$AGE)
vif(modelo_wages)
modelo_wages<-lm(WAGE ~ ., data = wages[,-4])
summary(modelo_wages)
vif(modelo_wages)

#*******************************EXEMPLO 07 - PRECOS DE CARROS USADOS********************************
#ANALISE DE REGRESSAO LINEAR SIMPLES E MULTIPLA
used_cars<-read.csv("Auto_Used_Car_Pricing.csv", header = TRUE, encoding = "UTF-8")
View(used_cars)

#*********************************EXEMPLO 08 - EMPRESTIMO BANCARIO*****************

#Importacao da tabela "Emprestimo Bancario.xslx"
install.packages("readxl")
library(readxl)
empbanc<-read_excel("Emprestimo_Bancario.xlsx", sheet ="Plan1")
View(empbanc)

#Agrupando cada variavel em classes (nesse caso, 4 classes)
install.packages("arules")
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
CrossTable(empbanc$idade_cl, empbanc$classif, prop.r = FALSE, prop.t = FALSE,
           prop.chisq = FALSE)
CrossTable(empbanc$educacao, empbanc$classif, prop.r = FALSE, prop.t = FALSE,
           prop.chisq = FALSE)
CrossTable(empbanc$experiencia_cl, empbanc$classif, prop.r = FALSE, prop.t = FALSE,
           prop.chisq = FALSE)
CrossTable(empbanc$tempend_cl, empbanc$classif, prop.r = FALSE, prop.t = FALSE,
           prop.chisq = FALSE)
CrossTable(empbanc$renda_cl, empbanc$classif, prop.r = FALSE, prop.t = FALSE,
           prop.chisq = FALSE)

#Calculando o nivel de importancia de cada variavel para explicar "classif"
install.packages("Information")
library(Information)
empbanc_select<-empbanc[,c(3,7,8,9,10,11)]
View(empbanc_select)
IV <- create_infotables(data = empbanc_select, y = "classif", ncore = 2)
print(head(IV$Summary, 10), row.names = FALSE)
print(IV$Tables$experiencia_cl, row.names = FALSE) #Apenas para exemplificar

#Calculo da correlacao entre as variaveis
matriz_correl <- round(cor(empbanc[,2:7]), 2)
matriz_correl
install.packages("corrplot")
library(corrplot)
matriz_correl_I<-corrplot(matriz_correl, method = "circle")
matriz_correl_I

#Analise do VIF para detectar potencial multicolinearidade
install.packages("HH")
library(HH)
model <- glm(classif ~ idade_cl+educacao+experiencia_cl+tempend_cl+
               renda_cl, family = binomial (link='logit'), data = empbanc)
summary(model)
vif(model)

#***********************EXEMPLO 09 - SAÍDA DE FUNCIONARIOS DE UMA EMPRESA************************
#Leitura da base 
RH<-read_excel("HR_Analytics.xlsx", sheet="Plan1")
View(RH)
RH$salary<-as.factor(RH$salary)
RH$sales<-as.factor(RH$sales)

#Descricao da base
summary(RH)
hist(RH$satisfaction_level, main="Distribuição de SATISFACTION LEVEL", 
     ylab="Frequência", xlab="Valores", col = "yellow")
hist(RH$last_evaluation, main="Distribuição de LAST EVALUATION", 
     ylab="Frequência", xlab="Valores", col = "orange")

#Perfil inicial de quem não está saindo
library(dplyr)
hr_hist <- RH %>% filter(left==0)
par(mfrow=c(2,2))
hist(hr_hist$satisfaction_level,col="#3090C7", main = "Satisfaction level") 
hist(hr_hist$last_evaluation,col="#3090C7", main = "Last evaluation")
hist(hr_hist$average_montly_hours,col="#3090C7", main = "Average montly hours")
hist(hr_hist$time_spend_company,col="#3090C7", main = "Time Spend Company")

#Perfil inicial de quem está saindo
library(dplyr)
hr_hist <- RH %>% filter(left==1)
par(mfrow=c(2,2))
hist(hr_hist$satisfaction_level,col="#3090C7", main = "Satisfaction level") 
hist(hr_hist$last_evaluation,col="#3090C7", main = "Last evaluation")
hist(hr_hist$average_montly_hours,col="#3090C7", main = "Average montly hours")
hist(hr_hist$time_spend_company,col="#3090C7", main = "Time Spend Company")

#Cálculo do information value das variáveis
library(Information)
IV <- create_infotables(data = RH, y = "left", ncore = 2)
print(head(IV$Summary, 10), row.names = FALSE)

#Análise bivariada das variáveis mais influentes
library(descr)
library(arules)
options(warn=-1)
RH$sat_level <- discretize(RH$satisfaction_level, "frequency", categories = 4)
RH$avg_mont_hours <- discretize(RH$average_montly_hours, "frequency", categories = 4)
CrossTable(RH$sat_level, RH$left, prop.r = FALSE,prop.t = FALSE, prop.chisq = FALSE)
CrossTable(RH$number_project, RH$left, prop.r = FALSE,prop.t = FALSE, prop.chisq = FALSE)
CrossTable(RH$avg_mont_hours, RH$left, prop.r = FALSE,prop.t = FALSE, prop.chisq = FALSE)

#Análise bivariada das variáveis menos influentes
CrossTable(RH$salary, RH$left, prop.r = FALSE,prop.t = FALSE, prop.chisq = FALSE)
CrossTable(RH$sales, RH$left, prop.r = FALSE,prop.t = FALSE, prop.chisq = FALSE)
CrossTable(RH$promotion_last_5years, RH$left, prop.r = FALSE,prop.t = FALSE, prop.chisq = FALSE)

#Otimizacao do processo de categorizacao
class(RH)
satlevel_optbin<-smbinning(df=RH, y="left", x="satisfaction_level", p=0.05)
satlevel_optbin
RH<-as.data.frame(RH)
class(RH)
satlevel_optbin<-smbinning(df=RH, y="left", x="satisfaction_level", p=0.05)
satlevel_optbin
numproj_optbin<-smbinning(df=RH, y="left", x="number_project", p=0.05)
avgmont_optbin<-smbinning(df=RH, y="left", x="average_montly_hours", p=0.05)
timespend_optbin<-smbinning(df=RH, y="left", x="time_spend_company", p=0.05)

RH1<-smbinning.gen(RH,satlevel_optbin, chrname="satlevel_opt" )
RH1<-smbinning.gen(RH1,numproj_optbin,chrname="numproj_opt" )
RH1<-smbinning.gen(RH1,avgmont_optbin,chrname="avgmont_opt" )
RH1<-smbinning.gen(RH1,timespend_optbin,chrname="timespend_opt" )
View(RH1)

IV <- create_infotables(data = RH1, y = "left", ncore = 2)
print(head(IV$Summary, 10), row.names = FALSE)

#Modelo preditivo so com as variaveis originais
modelo1<-glm(left ~ ., family = binomial (link='logit'), data = RH1[,c(2,4,5,6,8)])
summary(modelo1)
RH_pred_I<-predict(modelo1, RH1, type="response")
RH1<-data.frame(RH1,RH_pred_I )
View(RH1)
library(dgof)
ks.test(RH1$RH_pred_I[RH1$left==0],
        RH1$RH_pred_I[RH1$left==1])

#Modelo preditivo so com as variaveis categorizadas via optimal bin
modelo2<-glm(left ~ ., family = binomial (link='logit'), data = RH1[,c(8,12,13,14,15)])
summary(modelo2)
RH_pred_II<-predict(modelo2, RH1, type="response")
RH1<-data.frame(RH1,RH_pred_II )
View(RH1)
library(dgof)
ks.test(RH1$RH_pred_II[RH1$left==0],
        RH1$RH_pred_II[RH1$left==1])
