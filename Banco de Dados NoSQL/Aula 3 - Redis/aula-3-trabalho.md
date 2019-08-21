# Trabalho 1

## Construa uma estrutura de dados que capture os seguintes nomes: 
Bruce, Robert, Fred, Jim, Chimbinha, Ronnie , James, Chris

Características da Lista: Armazenar somente nomes distintos.  

Criei uma chave chamada “nomes” do tipo SET para armazenar os dados, 
pois é uma lista que tem como característica armazenar valores distintos.  
  
Comandos:

```
SADD nomes Bruno
SADD nomes Robert
SADD nomes Fred
SADD nomes Jim
SADD nomes Chimbinha
SADD nomes Ronnie
SADD nomes James
SADD nomes Chris
```

## Apresente uma visão da lista armazenada, depois de feitas 8 entradas.

```
SMEMBERS nomes
```

## Qual a ordem de saída dessa lista? Está respeitada alguma ordem? 
A saída desta lista apresenta por padrão os dados na ordem de inserção.

## Essa característica deve ser vista como um problema? Justifique.
Esta característica não é um problema, pois caso precisemos dos dados ordenados podemos utilizar o comando abaixo:
```
SORT nomes ALPHA
```

--------------

# Trabalho 2

# Pensando em nosso case contínuo da platforma virtual MarketPlace de vendas. 
Construa duas estruturas de Dados:

## Para atender dados de Sessão;

Utilizei a estrutura de HASH para armazenar os dados da sessão:
`HMSET sessao:ab3f82be19 nome "Charles" email "e-mail@charles.art.br"`

Para retorna os da sessão:
`HMGET sessao:ab3f82be19 nome`

Para retorna todos os dados da sessão:
`HGETALL sessao:ab3f82be19`

## Para atender dados de Carrinho de compras;

Utilizei também a estrutura de HASH para armazenar os dados da sessão, 
porém utilizando o comando HSET para adicionar um item de cada vez:

```
HSET carrinho:ab3f82be19 produto1 "iPhone X"
HSET carrinho:ab3f82be19 produto1 " TV Samsung 60 polegadas"
```

Para retorna todos os dados do carrinho:
`HGETALL carrinho:ab3f82be19`
