## FIAP - 1S2020
## Data mining
## Prof. André Insardi
## (adaptado de material de Prof. Gustavo Correa Mirapalheta)

#install.packages("tidyverse")
#install.packages("tidytext")
library(tidyverse)
library(tidytext)
library(dplyr)
library(janeaustenr)
#setwd("../scripts")
# An?lise de Sentimento
#O processo de An?lise de Sentimento  \label{fig002}](../imagens/textmining002.png)

#- Considera-se o texto como a combina??o de suas palavras individuais e o conte?do de sentimento do
# texto como a soma do sentimento de suas palavras individuais.

## An?lise de Sentimento: dataset sentiments

#- Conjunto de l?xicos com a classifica??o das palavras de acordo com um sentimento espec?fico ou um n?vel associado

head(tidytext::sentiments)

## An?lise de Sentimento: l?xicos dispon?veis

#- AFINN (Finn ?rup Nielsen)
#    + por escore (-5 a 5)
#- Bing (Bing Liu and collaborators)
#    + bin?ria ("positiva","negativa") 
#- NRC (Saif Mohammad and Peter Turney)
#    + bin?ria ("positiva","negativa") e nas categorias: positive, negative, anger, anticipation,
# disgust, fear, joy, sadness, surprise, e trust
#- loughran
#    + categorias: negative, positive, uncertainty,  litigious,   
#constraining, superfluous
    
## An?lise de Sentimento: exemplos de l?xicos

## An?lise de Sentimento: exemplos de l?xicos
#- Bing (Bing Liu and collaborators)
#    + bin?ria ("positiva","negativa")

get_sentiments("bing") %>% head()

## An?lise de Sentimento: exemplos de l?xicos

## An?lise de Sentimento com dados "Tidy"

#- Assim como a remo??o dos *stop words* era uma opera??o *anti_join* a an?lise de sentimento ? um
#  *inner_join*.

#- Por exemplo, vamos determinar quais as palavras de *joy* mais comuns em *Emma*, tomando por base o
# l?xico NRC.

#- Primeiro temos que baixar o texto de *Emma* e torna-lo *tidy* atrav?s de *unnest_tokens()* e da
# inclus?o das colunas referentes ? linha e ao cap?tulo de origem

## An?lise de Sentimento: *joy* em *Emma*

#- Os livros est?o dispon?veis no pacote *janeaustenr*, atrav?s da fun??o *austen_books()*. O essencial para o exerc?cio que iremos realizar seria a coluna de text. No entanto, vamos tamb?m criar colunas indicando o n?mero do cap?tulo e da linha correspondente, para efeito de pr?tica nos recursos de minera??o de texto, como pode ser visto no pr?ximo slide. 

## An?lise de Sentimento: *joy* em *Emma*

#- Para incluir os n?meros de cap?tulo e linha divididos por livro, iniciamos agrupando os textos pela campo *book*.

austen_books()
austen_books()[11:20,] #explorando o dataframe
group_by(austen_books(), book) -> austen_group; austen_group

## An?lise de Sentimento: *joy* em *Emma*

#- Em seguida inserimos o n?mero de linha, no dataframe agrupado por *book*.

mutate(austen_group, linenumber = row_number()) -> austen_mutate1; austen_mutate1

## An?lise de Sentimento: *joy* em *Emma*

#- E depois o n?mero do cap?tulo com a regex: "^chapter [\\divxlc]"

mutate(austen_mutate1, chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
            ignore_case = TRUE) ) ) ) -> austen_mutate2; austen_mutate2

## An?lise de Sentimento: *joy* em *Emma*

#- Temos agora um dataframe no qual al?m do texto e do livro, linha por linha, temos dois campos, um com o n?mero da linha e outro com o n?mero do cap?tulo associado. Podemos agora prosseguir para a segunda parte do exerc?cio, isto ? a tokeniza??o do mesmo por palavra

## An?lise de Sentimento: *joy* em *Emma*

#- Desagrupamos o dataframe para que seja feita a tokeniza??o por palavra

ungroup(austen_mutate2) -> austen_ungroup; head(austen_ungroup)

## An?lise de Sentimento: *joy* em *Emma*

#- Em seguida tokenizamos o dataframe, uma palavra por linha
#tokenização
unnest_tokens(austen_ungroup, word, text) -> austen_unnest; head(austen_unnest)

## An?lise de Sentimento: *joy* em *Emma*

#- Observe no slide anterior que escolhemos o nome "word" para a coluna de resultado de unnest
#    + Isto torna os *inner_joins* mais f?ceis de executar pois os datasets de *stop words* e de
#    *l?xicos* j? possuem uma coluna com nome igual
    
## An?lise de Sentimento: *joy* em *Emma*

#- Precisamos agora eliminar os caracteres "_" das palavras, pois os mesmos indicam que o texto
# original estava em it?lico, de acordo com as regras do Projeto Gutemberg. Fazemos isto para evitar
# que existam tokens como "\_you\_"

#- Para isso lan?amos m?o da regex: "[a-z']+". Esta regex vai eliminar tamb?m n?meros dos tokens, mas
# isto seria feito de qualquer forma depois pelo inner_join com os l?xicos, os quais cont?m apenas
# palavras.
    
## An?lise de Sentimento: *joy* em *Emma* 
#tirar caracteres especiais 
mutate(austen_unnest, word = str_extract(word, "[a-z']+")) -> austen_unnest; austen_unnest

## An?lise de Sentimento: *joy* em *Emma*

#- Por precau??o vamos filtrar tamb?m os NAs
filter(austen_unnest, !is.na(word)) -> austen_unnest; austen_unnest

## An?lise de Sentimento em Jane Austen

#- Para tal vamos criar um escore de sentimento atrav?s do l?xico *bing* e da fun??o *inner_join*

#- Dividiremos os textos em grupos de 80 linhas, atrav?s de um ?ndice calculado por *x %/% y*, o qual
# executa divis?o inteira. 
#    + Por que 80? Poucas linhas podem n?o produzir uma estimativa significativa. Muitas linhas podem
# "limpar" a estrutura do texto. O valor 80 depende do texto. No caso de Jane Austen, isto produz
# resultados interessantes.
    
#- Utilizamos em seguida *spread* para ter os valores positivos e negativos em colunas separadas.
# Calculamos em seguida o valor l?quido fazendo *positivas* - *negativas* para cada se??o de 80
# linhas do texto.

## An?lise de Sentimento em Jane Austin

#- Primeiro cruzamos *austen_unnest* com o l?xico *bing*

inner_join(austen_unnest, get_sentiments("bing")) -> tidy_join; tidy_join

## An?lise de Sentimento em Jane Austin

#- Depois criamos um ?ndice que ir? indicar o n?mero do grupo de 80 linhas no qual a palavra se
# encontra

count(tidy_join, book, index = linenumber %/% 80, sentiment) -> tidy_count; tidy_count

# por capitulo
count(tidy_join, book, index = chapter, sentiment) -> tidy_chapter; tidy_chapter

## An?lise de Sentimento em Jane Austin

#- Utilizando a fun??o *spread* dividimos a coluna *sentiment* em duas, uma com valores positivos e
# outra com valores negativos (de *joy*). 

spread(tidy_count, sentiment, n, fill = 0) -> tidy_spread; tidy_spread

## An?lise de Sentimento em Jane Austin

#- Criamos em seguida uma coluna *sentiment* com o valor l?quido entre a soma dos valores positivos e
# negativos de sentimento

mutate(tidy_spread, sentiment = positive - negative) -> tidy_mutate; tidy_mutate

## An?lise de Sentimento em Jane Austin

#- E por ?ltimo renomeanos o dataframe para *janeaustensentiment*

tidy_mutate -> janeaustensentiment; janeaustensentiment

## An?lise de Sentimento em Jane Austin

#- Vamos agora plotar o gr?fico da altera??o de sentimento, ao longo de cada um dos romances de Jane
# Austen
#    + Observe nos slides a seguir que o ?ndice que controla o avan?o de cada romance ? o n?mero do
#      grupo de 80 linhas
    
## An?lise de Sentimento em Jane Austin

#- Primeiro criamos o mapeamento est?tico b?sico do ggplot2     
    
ggplot(janeaustensentiment, aes(index, sentiment, fill = book)) -> jane_plot; jane_plot

## An?lise de Sentimento em Jane Austin

#- Depois adicionamos um gr?fico de barras, por?m sobreposto

jane_plot + geom_col(show.legend = FALSE) -> jane_col; jane_col

## An?lise de Sentimento em Jane Austin

#- E para melhorar a visualiza??o, dividimos o mesmo por *book*

jane_col + facet_wrap(~book, ncol = 2, scales = "free_x") 

########### FIM BING #####################


########### NUVEM DE PALAVRAS COM BING #####################

## Wordclouds
library(gutenbergr)

#- Em seguida criamos dataframes tokenizados de forma similar para as Irm?es Bronte.

bronte <- gutenberg_download(c(1260, 768, 969, 9182, 767))

tidy_bronte <- bronte %>%
  unnest_tokens(word, text) %>%
  mutate(word = str_extract(word, "[a-z']+")) %>%
  anti_join(stop_words, by=c("word"="word"))

## Wordclouds (cont.)

#- Fazemos o mesmo para o dataframe com as obras de H.G.Wells

hgwells <- gutenberg_download(c(35, 36, 5230, 159))

tidy_hgwells <- hgwells %>%
  unnest_tokens(word, text) %>%
  mutate(word = str_extract(word, "[a-z']+")) %>%
  anti_join(stop_words)

## Wordclouds (cont.)

#- E mais uma vez unimos os dataframes por linha

mutate(tidy_bronte, author = "Bront? Sisters")->tidy_bronte2
mutate(tidy_hgwells, author = "H.G. Wells")->tidy_hgwells2
mutate(austen_unnest, author = "Jane Austen")->tidy_books2
tidy_books2

## Wordclouds - Palavras + comuns em Jane Austen
#install.packages("wordcloud")
######### DESENHA NUVEM########
library(wordcloud); 

anti_join(tidy_books2, stop_words) -> books_antijoin
count(books_antijoin, word) -> books_count
with(books_count, wordcloud(word, n, max.words=100)) -> books_cloud

## Wordcloud & Sentiment - Jane Austen Novels

#- Vamos agora realizar uma an?lise de sentimento, determinando as palavras positivas e negativas
# mais comuns. Iniciamos gerando o tibble correspondente.

library(reshape2)
austen_unnest %>%
inner_join(get_sentiments("bing")) %>%
count(word, sentiment, sort = TRUE) %>%
acast(word ~ sentiment, value.var = "n", fill = 0) -> tidy_comparison

## Wordcloud & Sentiment - Jane Austen Novels

#- O tibble que ser? usado para gerar a nuvem comparativa ? apresentado a seguir. 

head(tidy_comparison)

## Wordcloud & Sentiment - Jane Austen Novels

#- Obs: os tamanhos n?o s?o compar?veis entre sentimentos diferentes

comparison.cloud(tidy_comparison, colors = c("red", "blue"), max.words = 100)

## An?lise de Sentimentos em Frases

#- "I am not having a good day" 
#  + Senten?a negativa por causa do "not"
  
#- Pacotes para an?lise de senten?as: *coreNLP*, *cleanNLP* e *sentimentr*

#- Tokeniza??o por senten?a no tibble

PandP_sentences <- data_frame(text = prideprejudice) %>%
unnest_tokens(sentence, text, token = "sentences")

## An?lise de Sentimentos em Frases - exemplo de tibble

#- Observe o tamanho da senten?a quando o arquivo est? em formato UTF-8

PandP_sentences$sentence[2]

## An?lise de Sentimentos em Cap?tulos - exemplo de tibble

#- Vamos dividir os tokens atrav?s de uma *regex*. No exemplo abaixo cada token ser? um cap?tulo.
# Vamos primeiro determinar se a *regex* ? capaz de contar corretamente os cap?tulos de cada livro.

#- O tibble pode ser visto no pr?ximo slide

austen_chapters <- austen_books() %>%
group_by(book) %>%
unnest_tokens(chapter, text, token = "regex",
pattern = "Chapter|CHAPTER [\\dIVXLC]") %>%
ungroup()

## An?lise de Sentimentos em Cap?tulos - exemplo de tibble

austen_chapters %>%
group_by(book) %>%
summarise(chapters = n())

## An?lise de Sentimentos por Cap?tulo

#- Nosso objetivo ser? determinar qual cap?tulo possui a maior propor??o de palavras negativas.

## An?lise de Sentimentos por Cap?tulo

#- Vamos obter a lista de palavras negativas no Bing.

bingnegative <- get_sentiments("bing") %>%
filter(sentiment == "negative")
head(bingnegative)

## An?lise de Sentimentos por Cap?tulo

#- Em seguida vamos criar um data frame com quantas palavras est?o em cada cap?tulo de forma a
# normalizar os resultados. 

wordcounts <- austen_unnest %>%
group_by(book, chapter) %>%
summarize(words = n())
head(wordcounts)

## An?lise de Sentimentos por Cap?tulo

#- Depois vamos calcular o n?mero de palavras negativas em cada cap?tulo e dividir pelo total de
# palavras por cap?tulo. 

austen_unnest %>% semi_join(bingnegative) %>%
group_by(book, chapter) %>% summarize(negativewords = n()) %>%
left_join(wordcounts, by = c("book", "chapter")) %>%
mutate(ratio = negativewords/words) %>% filter(chapter != 0) %>%
top_n(1) %>% ungroup()-> tidy_sentiment_chapter; 
head(tidy_sentiment_chapter)

## An?lise de Sentimentos por Cap?tulo

#- O que acontece nos cap?tulos listados?
#   + Sense and Sensibility (43): Marianne est? gravemente doente, perto da morte.
#   + Pride and Prejudice (34): Sr. Darcy prop?e pela primeira vez...     + Mansfield Park (46):
# quase no fim, quando todos descobrem o adult?rio escandaloso de Henry
#   + Emma (15): O horripilante o Sr. Elton prop?e
#   + Northanger Abbey (21): Catherine est? no fundo de sua fantasia g?tica de assassinato. 
#   + Persuasion (4): o leitor conhece a recusa do Capit?o Wentworth por Anne (em flashback) e ela
# percebe o erro que cometeu.



   