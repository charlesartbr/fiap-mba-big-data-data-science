# Cassandra

## Docker Commands;
```
docker pull cassandra  
docker run --name Cassandra -p 9042:9042 -d cassandra  
docker exec -it Cassandra cqlsh  
```
## Comandos

### Criar e usar um Keyspace 
```
CREATE KEYSPACE KS1
  WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 3};
use ks1;
```

### Criando duas tabelas
```
CREATE TABLE users (  
	id int PRIMARY KEY,  
	name text,  
	email text  
);  
CREATE TABLE messages (  
	posted_on bigint,  
	user_id int,  
	user_name text,   
	body text,  
	PRIMARY KEY  (user_id, posted_on)  
);  
```

### Verifique a criação  
```
DESCRIBE TABLE users;  
DESCRIBE TABLE messages;  
```

### Altere a estrutura e valide  
```
ALTER TABLE users  ADD password text;  
ALTER TABLE users  ADD pseudonym text;  
ALTER TABLE users  ADD password_reset_token text;  
```

### Conjuntos  
```
ALTER TABLE users ADD hobbies set<text>;   
CREATE TABLE followers ( user_id int PRIMARY KEY,  followers list<text>);  
ALTER TABLE messages ADD  comments map<text, text>;  
```

### Populando  
```
INSERT INTO users (id, name, email) VALUES (101, 'Miranda otto', 'otto@gmail.com');  
INSERT INTO users (id, name) VALUES (102, 'Jane Seymor');  
INSERT INTO users (id, name) VALUES (103, 'Michael Fassbinder');  
INSERT INTO users (id, name, email) VALUES (104, 'Linda Evans', 'linda@gmail.com');  
INSERT INTO users (id, name, email) VALUES (105, 'Tim Allen', 'tim_01@yahoo.com');  
INSERT INTO users (id, name, email) VALUES (106, 'Lucy Liu','Liu@gmail.com');  

INSERT INTO messages (user_id, posted_on, user_name, body) VALUES (101, 1384895178, 'Miranda otto', 'Oi moça!');  
INSERT INTO messages (user_id, posted_on, user_name, body) VALUES (101, 1384895319, 'Miranda otto', 'Oi, de novo;;;.');  
INSERT INTO messages (user_id, posted_on, user_name, body) VALUES (104, 1384895222, 'Linda Evans', 'Você conhece a Miranda Otto?');  
INSERT INTO messages (user_id, posted_on, user_name, body) VALUES (103, 1384895223, 'Lucy Liu', 'Comediante em Ally McBeal');  
INSERT INTO messages (user_id, posted_on, user_name, body) VALUES (103, 1384895224, 'Lucy Liu', 'Filme de Ação com Tarantino');  
INSERT INTO messages (user_id, posted_on, user_name, body) VALUES (103, 1384895225, 'Lucy Liu', 'Dra. Watson, no Sherlock');  
INSERT INTO messages (user_id, posted_on, user_name, body) VALUES (103, 1384895226, 'Lucy Liu', 'E pintora famosa, mas com outro nome');  
INSERT INTO messages (user_id, posted_on, user_name, body) VALUES (103, 1384895227, 'Tim Allen', 'Rei da Comédia');  
INSERT INTO followers ( user_id, followers) VALUES (101, ['Neymar','Tite']);  
```

### Criando Indices  
```
CREATE INDEX name_index ON   users(name);  
CREATE INDEX email_index ON   users(email);  
SELECT name, email FROM  users WHERE name = 'Miranda otto';  
SELECT name, email FROM  users WHERE email = 'otto@gmail.com';  
SELECT * FROM followers;  
```

### Update  
```
UPDATE users SET email =  'jane@smith.org' WHERE id = 102;  
UPDATE users SET pseudonym = 'Yu Ling' WHERE id = 106;  
UPDATE messages SET comments  = comments + {'otto' : 'thx for the info!'} WHERE user_id = 103 AND  posted_on = 1384895223;  
```

### Pesquisas, seguindo  
```
SELECT name, hobbies  FROM users  WHERE id IN (104, 106, 103);  
SELECT name as nome, hobbies as passatempo  FROM users  WHERE id IN (104, 106, 103);  
select name from users where id > 103 allow filtering;  
select name from users where name > 'P' allow filtering;  
select count(*) from users;  
```

### Valide tudo  
```
SELECT * FROM users;  
SELECT name, email FROM users   WHERE id = 101;  
SELECT name, email FROM users   WHERE name = 'Tim Allen';  
```

### Só pode selecionar se houver índice!  
```
SELECT name, email FROM users   WHERE name = 'Tim Allen' allow filtering;  
```

### deletando  
```
DELETE email FROM users WHERE id = 105;  
DELETE FROM users WHERE id = 102;  
```
