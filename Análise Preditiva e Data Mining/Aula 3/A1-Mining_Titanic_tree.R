# T?cnica de Discrimina??o: ?rvore.

# limpar mem?ria do R
rm(list=ls(all=TRUE))


install.packages("rpart") 
install.packages("rpart.plot") 

# importar os arquivos
Titanic_train <- read.csv("train.csv")

Titanic_test <- read.csv("test.csv")

View(Titanic_train)

str(Titanic_train)

attach(Titanic_train)

summary(Titanic_train)

Titanic_train$Survived<-as.factor(Titanic_train$Survived)
Titanic_train$Pclass<-as.factor(Titanic_train$Pclass)

attach(Titanic_train)

summary(Titanic_train)

# sibsp Number of Siblings/Spouses Aboard ( N?mero de irm?os / c?njuges a bordo)
# Titanic_train$SibSp <- as.factor(Titanic_train$SibSp)

# parch Number of Parents/Children Aboard (N?mero de pais / filhos a bordo)
# Titanic_train$Parch <- as.factor(Titanic_train$Parch)

summary(Titanic_train)

table(Titanic_train$Survived)

prop.table(table(Titanic_train$Survived))

#comando para gerar em 2 linhas e 3 colunas os plots
par (mfrow=c(2,3))
plot(as.factor(Titanic_train$Pclass), as.factor(Titanic_train$Survived),main='Pclass')
plot(Titanic_train$Sex, as.factor(Titanic_train$Survived),main='Sex')
plot(as.factor(Titanic_train$Age), as.factor(Titanic_train$Survived),main='Age')
plot(Titanic_train$Embarked, as.factor(Titanic_train$Survived),main='Embarked')
plot(as.factor(Titanic_train$SibSp), as.factor(Titanic_train$Survived),main='SibSp')
plot(as.factor(Titanic_train$Parch), as.factor(Titanic_train$Survived), main='Parch')

par (mfrow=c(1,1))

# column percentages 
prop.table(table(as.factor(Titanic_train$Pclass),as.factor(Titanic_train$Survived)),2)
 

attach(Titanic_train)

table(as.factor(Age), Survived, useNA = "ifany")

boxplot(Age ~ Survived, main='Age')

boxplot(Fare ~ Survived , main='Fare')


# Carrega o pacote: ?rvore de decis?o
library(rpart) 
library(rpart.plot) 

attach(Titanic_train)

# informa?oes dos Par?metros do Modelo
 
rpart.model01 <- rpart(Survived ~ Pclass+Sex+Age+Embarked+Parch+Fare, maxdepth=10, Titanic_train)


# Faz o Gr?fico (type=0 a 4) (extra=0 a 9)
rpart.plot(rpart.model01, type=4, extra=104, under=FALSE, clip.right.labs=TRUE,
           fallen.leaves=FALSE,
           digits=2, varlen=-8, faclen=10,
           cex=0.6, tweak=1,
           compress=TRUE,
           snip=FALSE)

# veja as op??es
rpart.plot(rpart.model01, type=5, extra=104, under=FALSE, clip.right.labs=TRUE,
           fallen.leaves=TRUE,
           digits=2, varlen=-8, faclen=10,
           cex=0.8, tweak=1,
           compress=TRUE,
           snip=FALSE)



# printcp(rpart.model01) # display the results
# plotcp(rpart.model01) # visualize cross-validation results


summary(rpart.model01) # detailed summary of splits


print(rpart.model01)

plotcp(rpart.model01) 


## Predict com tipo 'classe' retorna se sobreviveu ou n?o.

previsto.com.modelo <- predict(rpart.model01, Titanic_train, type='class')

matriz.de.confusao <- table(Titanic_train$Survived, previsto.com.modelo)
matriz.de.confusao

diagonal <- diag(matriz.de.confusao)
Acc <- sum(diagonal) / sum(matriz.de.confusao)
Acc

## Passando na base de teste

Titanic_test$Pclass <- as.factor(Titanic_test$Pclass)
summary(Titanic_test)

Titanic_test$Survived <- predict(rpart.model01, Titanic_test, type='class')
View(Titanic_test)

Titanic_train$Survived2 <- predict(rpart.model01, Titanic_train, type='class')
View(Titanic_train)

library(dplyr)

resposta <- select(Titanic_train, PassengerId, Survived)
resposta <- subset(resposta, PassengerId >= 12 & PassengerId <= 18)
resposta
