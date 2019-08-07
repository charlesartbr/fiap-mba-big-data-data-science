**Integrantes:**  

334130 - ANDREI RENAN ZANETTI DE MORAES  
334409 - CHARLES GUIMARÃES CAVALCANTE  
334169 - DANILO SANTOS DOURADO  
334195 - FERNANDO AUGUSTO WAHL  

----

**Cenário 2 – Sessões e Carrinho de Compras**  

Durante esse período para que os pedidos sejam fechados dentro deste
crescimento de demanda, é necessário gerenciar as sessões e o carrinho de
compras do cliente, de forma a garantir dísponibilidade máxima, problemas
com o carrinho, perda de sessão podem motivar o cliente a realizar suas
compras em um concorrente.

----

**Há a necessidade de persistir os dados? Porquê?**  

Não há necessidade de persistência dos dados de sessões e do carrinho de 
compras por serem dados temporários, necessários somente no dia da Black Friday.  
  
  
**Onde se encaixa no teorema de CAP?**  

Se encaixa no teorema em **AP (Disponibilidade e Tolerância a Falhas)** 
devido a alta demanda de clientes nesta data, podendo chegar a milhões de 
registros de sessões e carrinhos de compras. 
  
É necessário disponibilidade para garantia de que todo request 
receba uma resposta bem sucedida ou com falha. 
  
A tolerância a particionamento é necessária para que o sistema continue 
a operar mesmo com erro de comunicação entre as máquinas do sistema.
  
    
**Qual tipo de NoSQL?**   

O banco de dados é do tipo **Chave-Valor**, pois os dados serão retornados 
mais rapidamente utilizando a chave da sessão. Os bancos de dados de chave-valor 
tem maior escalabilidade para grandes quantidades de dados e volumes extremamente 
altos para atender milhões de usuários simultâneos por meio de armazenamento 
e processamento distribuído. 
