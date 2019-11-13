
library(readxl)
Consolidado <- read_excel("Consolidado.xlsx")
View(Consolidado)


attach(Consolidado)
install.packages("neuralnet")
library(neuralnet)
net <-neuralnet(default1~salario + 
                  ValorEmprestimo+ 
                  QtdaParcelas+ comprometimento_renda1+TempodeResidencia+
                  TempodeServico
                , data=Consolidado, hidden=10)
net

plot(net)

library(readxl)
nuvem <- read_excel("E:/Arquivos de Aula - Linguagem R/Arquivos Aulas Fiap/nuvem.xlsx")
View(nuvem)

table(sexo)

attach(nuvem)
head(nuvem)
install.packages("wordcloud")
library(wordcloud)
wordcloud(words=nuvem$words, 
          freq=nuvem$Freq,min.freq = 2,
          random.order=FALSE,
          colors = brewer.pal(12,"Paired"))


