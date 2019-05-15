# Exercícios de Hive utilizando o Hue

Exibir os bancos de dados:  
```sql
SHOW DATABASES;
```

Criar um banco de dados:  
```sql
CREATE DATABASE credit_card LOCATION '/db/credit_card';
```

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

Criar uma partição:  
```sql
ALTER TABLE credit_card.transactions ADD PARTITION (dt=20170912);
```

Inserir dados em uma nova partição:
```sql
insert into table credit_card.transactions partition (dt=20170101)   
values ("2017‐01‐01 01:23:45","e5f6g7h8","Americanas","APROVADA","BRL",5000);
```

Selecionar os dados:
```sql
select * from credit_card.transactions;
```

Cria uma tabela externa 
```sql
create table credit_card.transactions_stage (
  ts timestamp,     
  card_id string,     
  store string,     
  status string,     
  currency string,     
  amount bigint 
) 
row format delimited fields terminated by ',' 
stored as textfile 
location '/user/cloudera/importacao_20170912';
```
