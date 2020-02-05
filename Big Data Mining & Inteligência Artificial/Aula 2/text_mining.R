## FIAP - 1S2020
## Data mining
## Prof. André Insardi
## (adaptado de material de Prof. Gustavo Correa Mirapalheta)

### Exemplo Text Mining
### Exploração do Arquivo "Dom Casmurro"

# FUNÇÕES

################################################################################################################
## função separa.paragrafo                                                                                     #
################################################################################################################

f.separa.paragrafo<-function(vetor.texto)
{
  
  lista.texto<-list()
  posicao.lista<-1
  
  tokens<-length(vetor.texto)
  quebras<-c(1:tokens)[vetor.texto=="<p>"]
  
  for (i in 1:(length(quebras)-1))
  {
    if (quebras[i+1]-quebras[i]>1)
    {
      lista.texto[[posicao.lista]]<- c(vetor.texto[(quebras[i]+1):(quebras[i+1]-1)])
      posicao.lista<-posicao.lista+1
    }
  }
  
  return(lista.texto)
}

################################################################################################################
# funcao perto                                                                                                 #
################################################################################################################

perto<-function(vetor.texto, foco, onde)
{
  posicao<-seq(along=vetor.texto)[vetor.texto==foco]
  return(as.matrix(vetor.texto[posicao+onde]))
}

################################################################################################################
# funcao kwic = key word in context                                                                            #
################################################################################################################

f.kwic<-function(vetor.texto, foco, contexto)
{
  posicao<-seq(along=vetor.texto)[vetor.texto==foco]
  
  #tratamento de exce??es
  if (length(posicao)==0)
  {
    print("Palavra em foco nao encontrada.")
    return()
  }
  if (contexto<2)
  {
    esquerda<-vector(mode="character")
    direita <-vector(mode="character")
    eixo<-vector(mode="character")
    eixo[1:length(posicao)]<-foco
    for (i in (seq(along=posicao)))
    {
      esquerda[i]<-paste(vetor.texto[posicao[i]-1], collapse=" ")
      direita[i]<-paste(vetor.texto[posicao[i]+1], collapse=" ")
    }
    saida<-cbind(as.data.frame(esquerda),as.data.frame(eixo),as.data.frame(direita))
    names(saida)<-c("esq","foco","dir")
    return(saida)
  }
  
  if (posicao[1]<=contexto)
  {
    print("Primeira ocorrencia anterior ao contexto desejado.")#programador sem tempo...
    return()
  }
  
  #casos normais
  esquerda<-vector(mode="character")
  direita <-vector(mode="character")
  eixo<-vector(mode="character")
  eixo[1:length(posicao)]<-foco
  for (i in (seq(along=posicao)))
  {
    esquerda[i]<-paste(vetor.texto[(posicao[i]-contexto):(posicao[i]-1)], collapse=" ")
    direita[i]<-paste(vetor.texto[(posicao[i]+1):(posicao[i]+contexto)], collapse=" ")
  }
  saida<-cbind(as.data.frame(esquerda),as.data.frame(eixo),as.data.frame(direita))
  names(saida)<-c("esq","foco","dir")
  return(saida)
}

################################################################################################################
## fun??o separaelementos                                                                                     ##
################################################################################################################

f.separaelementos <- function(texto)
{
  
  v.ret <- vector(mode="numeric")
  
  if (length(texto)==0) return(v.ret)
  
  v.ret <- unlist(strsplit(as.vector(texto)," "))
  
  v.ret <- gsub("\\["," \\[ ",v.ret)                  # simbolo [
  v.ret <- gsub("\\]"," \\] ",v.ret)                  # simbolo ]
  
  v.ret <- gsub("([?!:;,~\\.^$%&*+=-])"," \\1 ",v.ret)
  
  v.ret <- gsub("\\("," \\( ",v.ret)                  # simbolo (
  v.ret <- gsub("\\)"," \\) ",v.ret)                  # simbolo )
  v.ret <- gsub("\\#"," \\# ",v.ret)                  # simbolo #
  v.ret <- gsub("\\`"," \\` ",v.ret)                  # simbolo `
  v.ret <- gsub("\""," <asp2> ",v.ret)                # aspas duplas
  v.ret <- gsub("\'"," <asp1> ",v.ret)                # aspas simples
  v.ret <- gsub("\t"," ",v.ret)
  v.ret <- gsub("\n"," ",v.ret)
  
  v.ret <- unlist(strsplit(as.vector(v.ret)," "))
  v.ret <- v.ret[nchar(v.ret) > 0]
  
  # Aglutina elementos estruturais
  v.ret <- f.trocaelemento(v.ret,c("i",".","e","."),"i.e.",FALSE)
  v.ret <- f.trocaelemento(v.ret,c("e",".","g","."),"e.g.",FALSE)
  v.ret <- f.trocaelemento(v.ret,c("<asp1>","d"),"'d",FALSE)
  v.ret <- f.trocaelemento(v.ret,c("<asp1>","s"),"'s",FALSE)
  v.ret <- f.trocaelemento(v.ret,c("(","c",")"),"(c)",FALSE)
  v.ret <- f.trocaelemento(v.ret,c("(","r",")"),"(r)",FALSE)
  v.ret <- f.trocaelemento(v.ret,c("http",":","/","/"),"http://",FALSE)
  
  return (v.ret[nchar(v.ret) > 0])
}

################################################################################################################
## fun??o trocaelemento                                                                                       ##
################################################################################################################

# Troca a ocorr?ncia de um elemento ou mais (lista.antigo) por outro

f.trocaelemento <- function(vetor.texto,lista.antigo,texto.novo,IGNORAMAIUSCULAS)
{
  tamelem <- length(lista.antigo)
  
  KN.elemento <- f.procuraexpressao(vetor.texto,lista.antigo,IGNORAMAIUSCULAS)
  
  for (i in KN.elemento)
  {
    vetor.texto[i] <- texto.novo
    if (tamelem > 1)
      vetor.texto[(i+1):(i+tamelem-1)] <- ""
  }
  
  return (vetor.texto[nchar(vetor.texto) > 0])
}

################################################################################################################
## fun??o procuraexpressao                                                                                   ##
################################################################################################################

f.procuraexpressao <- function(vetor.texto, vetor.expressao, IGNORAMAIUSCULAS)
{
  
  if (IGNORAMAIUSCULAS)
    posini<-(1:length(vetor.texto))[tolower(vetor.texto)==tolower(vetor.expressao[1])]
  else
    posini<-(1:length(vetor.texto))[vetor.texto==(vetor.expressao[1])]
  
  if (length(posini)==0) return(posini)
  
  tamanho<-length(vetor.expressao)
  expressao <- paste(vetor.expressao, collapse=" ")
  
  pos<-vector(mode="numeric")
  
  for (i in posini)
  {
    expri <- paste(vetor.texto[i:min(i+tamanho-1,length(vetor.texto))], collapse=" ")
    if (IGNORAMAIUSCULAS)
    { if (tolower(expri)==tolower(expressao)) pos <- c(pos,i) }
    else
    { if (expri==expressao) pos <- c(pos,i) }
  }
  
  return(pos)
}



################################################################################################################
################################################################################################################
# CORPO PRINCIPAL DO PROGRAMA                                                                                  #
################################################################################################################
################################################################################################################

setwd("C:/Users/logonrmlocal/Desktop/fiap-mba-big-data-data-science/Big Data Mining & Inteligência Artificial/Aula 2")
dc <- scan(file="domcasmurro.txt", what = "character")
dc[is.na(dc)] <- "NA" #corrige ambiguidade na importacao de em+a=na maiscula
dc[1:100]

#Comente. Algum problema? Sugestao de aperfeicoamento?

#pontuacao
pontuacao<-c(",", ";", ":", ".", "!", "?", "-", "/", "[", "]", "?", "!",
             "#", "`", "<asp1>", "<asp2>", "(", ")", "+", "-", "=", "$", "?")
pontuacao
#Comente. Algum problema? Sugestao de aperfeicoamento?

#tokens
length(dc)
#palavras
length(dc[!is.element(dc,pontuacao)])
#pontuacao
length(dc[is.element(dc,pontuacao)])
table(dc[is.element(dc,pontuacao)])

pontuacao_original <- pontuacao

# Separa caracteres de pontuação e outros das palavras
# dentro do vetor de palavras
dc_antigo <- dc
dc <- f.separaelementos(dc)

#tokens
length(dc)
#palavras
length(dc[!is.element(dc,pontuacao)])
#pontuacao
length(dc[is.element(dc,pontuacao)])
table(dc[is.element(dc,pontuacao)])

#palavras
palavras <- dc[!is.element(dc,pontuacao)]
table(palavras)->temp
palavras<-dimnames(temp)[[1]]
frequencias<-as.vector(temp)
rm(temp)
palavras[frequencias>100]
frequencias[frequencias>100]

estruturais<-c( "a",   "A",       "agora",   "ainda",   "algum",   "alguma",  "algumas", "alguns", "antes",
                "ao",      "Ao",      "aos",     "aqui",    "as",      "As",      "Às",      "assim",   "Assim",   "até",
                "bem",     "CAPÍTULO","com",     "comigo",  "como",    "cousa",   "creio",   "D",       "da",      "dar",
                "das",     "dava",    "de",      "dela",     "dele",    "dentro",  "depois",  "depressa", "deu",    "disse",
                "dizer",   "dizia",   "do",      "dos",     "dous",    "duas",    "e",       "E",       "é",       "à",
                "ela",     "ele",     "eles",    "em",      "Em",      "ent?o",   "Ent?o",   "entrar",  "entre",   "era",
                "Era",     "eram",    "esta",    "está",    "estar",   "estava",  "este",    "eu",      "Eu",      "falar",
                "fazer",   "fez",     "fim",     "foi",     "Foi",     "fora",    "fosse",   "fui",     "gente",   "grande",
                "há",      "havia",   "ia",      "ir",      "isso",    "isto",    "já",      "Já",      "la",      "lá",
                "lhe",     "lo",      "logo",    "mais",    "mal",     "mas",     "Mas",     "me",      "meio",    "melhor",
                "menos",   "mesma",   "mesmo",   "meu",     "meus",    "mim",     "minha",   "muito",   "na",      "nada",
                "não",     "Não",     "nas",     "nem",     "no",      "No",      "nos",     "nós",     "nossa",   "o",
                "O",       "os",      "Os",      "ou",      "outra",   "outras",  "outro",   "outros",  "para",    "pela",
                "pelo",    "pode",    "podia",   "Pois",    "por",     "porque",  "pouco",   "primeira","primeiro","quando",
                "Quando",  "que",     "Que",     "queria",  "quis",    "são",     "se",      "Se",      "sei",     "sem",
                "sempre",  "senhor",  "senhora", "ser",     "seu",     "seus",    "si",      "só",      "sua",     "tal",
                "também",  "Também",  "tanto",   "tão",     "tarde",   "tem",     "ter",     "tinha",   "toda",    "todas",
                "todo",    "todos",   "tudo",    "um",      "Um",      "uma",     "Uma",     "veio",    "vez",     "vezes",
                "vi")

palavrasfinal <- dc[!is.element(dc,c(pontuacao,estruturais))]
table(palavrasfinal)->temp
palavrasfinal<-dimnames(temp)[[1]]
frequenciasfinal<-as.vector(temp)
rm(temp)
palavrasfinal[frequenciasfinal>100]
frequenciasfinal[frequenciasfinal>100]



# OUTROS EXEMPLOS DE EXPLORA??O

palavras[c(1:length(frequencias))[frequencias[!is.element(palavras,estruturais)]>200]]
#Comente. Algum problema? Sugestao de aperfeicoamento?

palavras[frequencias==3]
#Comente. Algum problema? Sugestao de aperfeicoamento?

f.kwic(dc,"favor",1)
f.kwic(dc,"favor",3)
f.kwic(dc,"favor",5)
f.kwic(dc,"favor",10)
#Comente. Algum problema? Sugestao de aperfeicoamento?

f.kwic(dc,"sangue",3)
f.kwic(dc,"sangue",10)
#Comente. Algum problema? Sugestao de aperfeicoamento?

#Tente outras palavras.
