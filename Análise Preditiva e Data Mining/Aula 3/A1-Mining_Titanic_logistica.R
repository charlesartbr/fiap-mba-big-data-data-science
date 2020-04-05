# T?cnica de Discrimina??o: regress?o logistica.

# analise explorat?ria e amostra desenvolvida no scrit anterior (tree)

attach(Titanic_train)


logist.model01 <- glm (Survived ~ Pclass+Sex+Age+Embarked+Parch+Fare, family=binomial(link=logit), Titanic_train)

summary(logist.model01 )

# selecionando vari?veis por m?todo autom?tico

model_step<-step(logist.model01,direction="both")

model_step
summary(model_step)

logist.fim <- glm (Survived ~ Pclass+Sex+Age, family=binomial(link=logit), Titanic_train)

summary(logist.fim )
        
# aplicando na base de treino

Titanic_train$predito <- predict(logist.fim,Titanic_train,type = "response")
summary(Titanic_train$predito )  

hist(Titanic_train$predito)

# Criar vari?vel faixa probabilidade
Titanic_train$fx_predito1 <- cut(Titanic_train$predito, breaks=c(0,0.10,0.20,0.30,0.40,0.50,0.60,0.70,0.80,0.90,1), right=F)
# Frequ?ncia absoluta
table(Titanic_train$fx_predito1,Titanic_train$Survived)

View(Titanic_train)

# Frequ?ncia relativa
print(prop.table(table(Titanic_train$fx_predito1,Titanic_train$Survived),2), digits=2)

plot(Titanic_train$fx_predito1 , Titanic_train$Survived)

### Matriz de confus?o - Escolhendo o corte em 0.38 

Titanic_train$fx_predito <- cut(Titanic_train$predito, breaks=c(0,0.38,1), right=F)

MC_log_treino <- table(Titanic_train$Survived, Titanic_train$fx_predito , deparse.level = 2) # montar a matriz de confus?o  
show(MC_log_treino) # mostra os resultados  
ACC_log = sum(diag(MC_log_treino))/sum(MC_log_treino)*100 # calcula a acur?cia  
show(ACC_log) # mostra a acur?cia  


# e se aplicar ma amostra teste?

predito_log_teste <- predict(logist.fim,Titanic_test,type = "response")
summary(predito_log_teste )   

