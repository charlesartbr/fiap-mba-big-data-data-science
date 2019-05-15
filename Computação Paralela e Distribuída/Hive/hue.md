# Exercícios de Hive utilizando o Hue

Exibir os bancos de dados:  
`SHOW DATABASES;`

Criar um banco de dados:  
`CREATE DATABASE credit_card LOCATION '/db/credit_card';`

Criar uma tabela:
```sql
CREATE EXTERNAL TABLE credit_card.transactions (  
  ts TIMESTAMP,  
  card_id string,  
  store string,  
  status string,  
  currency string,  
  amount bigint  
)  
PARTITIONED BY (dt BIGINT)  
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'  
COLLECTION ITEMS TERMINATED BY ','  
STORED AS TEXTFILE  
LOCATION '/db/credit_card/transaction';
```
