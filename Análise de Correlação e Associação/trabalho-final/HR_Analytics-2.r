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

library(smbinning)

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
