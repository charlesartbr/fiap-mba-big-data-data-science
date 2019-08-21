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

`SMEMBERS nomes`

## Qual a ordem de saída dessa lista? Está respeitada alguma ordem? 
A saída desta lista apresenta por padrão os dados na ordem de inserção.

## Essa característica deve ser vista como um problema? Justifique.
Esta característica não é um problema, pois caso precisemos dos dados ordenados podemos utilizar o comando abaixo:
`SORT nomes ALPHA`
