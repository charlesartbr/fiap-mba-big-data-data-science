install.packages("rvest")
library(rvest)

pagina <- html("http://www.ipeadata.gov.br/ExibeSerie.aspx?serid=40940&module=M")
dados <-pagina %>% #text string
 html_nodes(".dxgvDataRow")%>% # função indice percorre
 html_text() #retorna cabecalho

risco <-gsub("[[:punct:]]","",dados) # Substitui todas as pontuações
dados<-gsub("[[:punct:]]","",dados)

data <-substr(dados,1,8)
risco <-substr(dados,9,11)

tabela <-data.frame(data, risco, stringsAsFactors = FALSE)
tabela


is.character(risco)
risco <-as.numeric(as.character(risco))
is.numeric(risco)

boxplot(risco)
plot.ts(risco)


install.packages("forecast")
library(forecast)

arima <- auto.arima(risco)
arima

previsao <- forecast(arima, h=10)
previsao

plot(previsao)

##############################################################################################

library(readxl)
nuvem <- read_excel("E:/Arquivos de Aula - Linguagem R/Arquivos Aulas Fiap/nuvem.xlsx")
View(nuvem)


attach(nuvem)
head(nuvem)
install.packages("wordcloud")
library(wordcloud)
wordcloud(words=nuvem$words, freq=nuvem$Freq,min.freq = 5,random.order=FALSE,
          colors = brewer.pal(12,"Paired"))



# Pacotes de cor RColorBrewer


# Programação usando For

attach(Banco)

Banco$media<-(cartao_credito+Emprestimos)/2
Banco
Banco$classe <-NA
Banco
media<-as.numeric(media)
min(media)
max(media)
for (i in 1:nrow(Banco)){
  if(Banco[i, "media"]>=10000){
    Banco[i,"classe"] <-"classe A"
  } else if (Banco[i,"media"]< 10000 & Banco[i, "media"]>=5000){
    Banco[i,"classe"]<-"classe B"
  }else{
    Banco[i,"classe"]<-"classe C"
  }
}
Banco
table(Banco$classe)


# Outro exemplo
Banco$resultado <-ifelse(estudo > 10,"Doutorado","Mestrado")
Banco
