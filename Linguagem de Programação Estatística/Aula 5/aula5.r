install.packages("readxl")
install.packages("plotly")
install.packages("glm2")

library(readxl)
library(plotly)
library(glm2)

Fraude <- read_excel("./Fraude.xlsx")
View(Fraude)

attach(Fraude)
names(Fraude)

#  Fraude = "0" N�o Fraude
#  Fraude = "1" Fraude

# Canal 0 = Presencial
# Canal 1 = Internet


######  Business intelligence #######################

grafico_pie <- table(Fraude$Fraude)
grafico_pie <-as.data.frame(grafico_pie)
grafico_pie

grafico_pie2 <- plot_ly(grafico_pie,
                        labels = ~Var1,
                        values = ~Freq,
                        type = 'pie')%>%
                        layout(title = "Gr�ficos Fraudes - BI")
grafico_pie2


###################################################

# binomial � uma distribui��o de probabilidade discreta 0 ou 1.
# Fun��o glm � uma fun��o que est� dentro do pacote glm2 e vai criar o modelo
# a variavel Fraude � minha variavel de estudo (0= N�o Fraudou e 1= Fraude)
# quero saber se as outras vari�veis consegue explicar a Fraude.
# o sinal ~ significa rela��o, ou seja, quero saber se as vari�veis (Idade, Gastos, Canal) tem rela��o para explicar
# o evento de interesse. o evento de interesse � sempre o 1. Fraude nesse caso.

Logistica <-glm(Fraude$Fraude11 ~ Idade + Gastos + Canal, family = binomial)
Logistica
                
summary(Logistica) 
# fun��o summary: resumo do modelo. Essa linha calcula os Betas (coeficientes para serem interpretados)

probabilidade <-predict(Logistica, Fraude, type = "response")
# estou criando uma vari�vel/ coluna chamada probabilidade. Essa vari�vel est� recebendo a probabilidade prevista do modelo
# que � calculada pela fun��o predict. a observa��o type=response, sig que estou calculando a probabilidade para resposta.

Fraude$probabilidade <-probabilidade # colocando a probabilidade no arquivo.

predito <- ifelse(probabilidade >= 0.5,1,0)
# estou criando um coluna predito que utiliza probabilidade criada anteriormente. como a probabilidade vaira de 0 a 1,
# qq valor que ficar igual ou acima de 0,5 ser� classificado como 1 que no nosso caso � Fraude. Valores de probabilidades
# menores que 0.49 ser� classificado como N�o Fraude, ou seja "0".

Fraude$predito <- predito # colocando a classifica��o no arquivo n�o Fraude "0" ou Fraude "1".
Fraude

table(Fraude$Fraude11,predito) # tabela cruzada, serve para saber quantos acertos e erros.
classificacao_geral <-((124+4)/(124+6+55+4))*100 # essa classifica��o geral. mede o quanto o modelo acerta no geral
classificacao_geral

## igual a conta acima, mas pela matriz
classificacao_geral1 <-table(Fraude$Fraude11,predito)
assertividade <-(classificacao_geral1[1]+classificacao_geral1[4])/sum(classificacao_geral1)
assertividade


##################################  Novos Dados ###########################################

library(readxl)
Novos_Dados_Fraude <- read_excel("Novos Dados Fraude.xlsx")
View(Novos_Dados_Fraude)

probabilidade <-predict(Logistica, Novos_Dados_Fraude, type = "response")
# estou criando uma vari�vel/ coluna chamada probabilidade. Essa vari�vel est� recebendo a probabilidade prevista do modelo
# que � calculada pela fun��o predict. a observa��o type=response, sig que estou calculando a probabilidade para resposta.

Novos_Dados_Fraude$probabilidade <-probabilidade # colocando a probabilidade no arquivo.

predito <- ifelse(probabilidade >= 0.5,1,0)

Novos_Dados_Fraude$predito <- predito

table(Novos_Dados_Fraude$predito)

View(Novos_Dados_Fraude)
names(Novos_Dados_Fraude)

#########################################################

# selecionando os registros com possiveis fraudes

install.packages("dplyr")
library(dplyr)
Clientes_Fraudes <-filter(Novos_Dados_Fraude, predito == 1)
Clientes_Fraudes

##A linha abaixo n�o esta usando dplyr
Clientes_Fraudes1 <- Novos_Dados_Fraude[Novos_Dados_Fraude$predito == 1, c("id","probabilidade","predito")]
Clientes_Fraudes1


##############  Previs�o - Business Analytics Novos Dados #################

attach(Novos_Dados_Fraude)
names(Novos_Dados_Fraude)

grafico_pie <- table(Novos_Dados_Fraude$predito)
grafico_pie <-as.data.frame(grafico_pie)
grafico_pie

grafico_pie2 <- plot_ly(grafico_pie,
                        labels = ~Var1,
                        values = ~Freq,
                        type = 'pie')%>%
                        layout(title = "Gr�ficos Fraudes - Previs�o")

grafico_pie2



