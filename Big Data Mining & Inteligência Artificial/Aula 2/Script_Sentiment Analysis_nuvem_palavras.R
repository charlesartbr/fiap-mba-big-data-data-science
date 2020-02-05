## FIAP - 1S2020
## Data mining
## Prof. André Insardi
## (adaptado de material de Prof. Gustavo Correa Mirapalheta)
library(tidyverse);
library(tidytext);
library(dplyr);
library(janeaustenr);
library(wordcloud); 

#Vamos utilizar a obra de Jane Austen
#Como primeiro passo iremos tokenizar o texto 
austen_books()
austen_books()[11:20,] #explorando o dataframe
group_by(austen_books(), book) -> austen_group; 
austen_group
mutate(austen_group, linenumber = row_number()) -> austen_mutate1; 
austen_mutate1
mutate(austen_mutate1, chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
                                                               ignore_case = TRUE) ) ) ) -> austen_mutate2; austen_mutate2
ungroup(austen_mutate2) -> austen_ungroup; head(austen_ungroup)
unnest_tokens(austen_ungroup, word, text) -> austen_unnest; head(austen_unnest)

mutate(austen_unnest, author = "Jane Austen")->tidy_books2

## Wordclouds (cont.)

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
