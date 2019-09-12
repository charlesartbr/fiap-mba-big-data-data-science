CREATE KEYSPACE marketplace 
WITH replication = { 'class': 'SimpleStrategy', 'replication_factor': 1 };

USE marketplace;


// 1) Pedidos realizados na ultima hora por loja:
CREATE TABLE relatorio1 (
    id_loja INT, 
    data TIMESTAMP, 
    hora INT, 
    id_pedido INT, 
    cliente_nome TEXT, 
    cidade TEXT, 
    uf TEXT, 
    id_produto set<int>,
    valor_total DECIMAL, 
    PRIMARY KEY ((id_loja, data, hora), id_pedido)
) WITH CLUSTERING ORDER BY (id_pedido DESC);

CREATE INDEX relatorio1_uf ON relatorio1(uf);
CREATE INDEX relatorio1_produto ON relatorio1(id_produto);

INSERT INTO relatorio1 (id_loja, data, hora, id_pedido, cliente_nome, cidade, uf, id_produto, valor_total) VALUES (123, '2019-09-12', 20, 1230, 'Teste 0', 'São Paulo', 'SP', { 1020, 1030, 1040 }, 12345.67);
INSERT INTO relatorio1 (id_loja, data, hora, id_pedido, cliente_nome, cidade, uf, id_produto, valor_total) VALUES (123, '2019-09-12', 21, 1234, 'Teste 1', 'São Paulo', 'SP', { 1021, 1022 }, 123.45);
INSERT INTO relatorio1 (id_loja, data, hora, id_pedido, cliente_nome, cidade, uf, id_produto, valor_total) VALUES (123, '2019-09-12', 21, 1235, 'Teste 2', 'Belo Horizonte', 'MG', { 1023 }, 345.67);
INSERT INTO relatorio1 (id_loja, data, hora, id_pedido, cliente_nome, cidade, uf, id_produto, valor_total) VALUES (123, '2019-09-12', 21, 1236, 'Teste 3', 'São Paulo', 'SP', { 1023 }, 345.67);

SELECT id_pedido, cliente_nome, cidade, uf, valor_total 
FROM relatorio1 
WHERE id_loja=123 and data='2019-09-12' and hora=21;

// 2) Produtos vendidos na ultima hora

CREATE TABLE relatorio2 (
    status TEXT, 
    data TIMESTAMP, 
    hora INT, 
    id_pedido INT, 
    cliente_nome TEXT, 
    cidade TEXT, 
    uf TEXT, 
    id_produto set<int>,
    valor_total DECIMAL, 
    PRIMARY KEY ((status, data, hora), id_pedido)
) WITH CLUSTERING ORDER BY (id_pedido DESC);

CREATE INDEX relatorio2_uf ON relatorio2(uf);
CREATE INDEX relatorio2_produto ON relatorio2(id_produto);

INSERT INTO relatorio2 (status, data, hora, id_pedido, cliente_nome, cidade, uf, id_produto, valor_total) VALUES ('Cancelado', '2019-09-12', 20, 1230, 'Teste 0', 'São Paulo', 'SP', { 1020, 1030, 1040 }, 12345.67);
INSERT INTO relatorio2 (status, data, hora, id_pedido, cliente_nome, cidade, uf, id_produto, valor_total) VALUES ('Pagamento realizado', '2019-09-12', 21, 1234, 'Teste 1', 'São Paulo', 'SP', { 1021, 1022 }, 123.45);
INSERT INTO relatorio2 (status, data, hora, id_pedido, cliente_nome, cidade, uf, id_produto, valor_total) VALUES ('Aguardando confirmação', '2019-09-12', 21, 1235, 'Teste 2', 'Belo Horizonte', 'MG', { 1023 }, 345.67);
INSERT INTO relatorio2 (status, data, hora, id_pedido, cliente_nome, cidade, uf, id_produto, valor_total) VALUES ('Pagamento realizado', '2019-09-12', 21, 1236, 'Teste 3', 'São Paulo', 'SP', { 1023 }, 345.67);

SELECT id_pedido, cliente_nome, cidade, uf, valor_total 
FROM relatorio2 
WHERE status='Pagamento realizado' and data='2019-09-12' and hora=21;

SELECT id_pedido, cliente_nome, cidade, uf, valor_total 
FROM relatorio2 
WHERE status='Pagamento realizado' and data='2019-09-12' and hora=21 and id_produto CONTAINS 1023;


// 3) Produtos mais vendidos por Região

CREATE TABLE relatorio3 (
    id_pedido INT, 
    id_produto int,
    produto_nome TEXT, 
    quantidade int, 
    valor DECIMAL, 
    uf TEXT, 
    PRIMARY KEY ((id_produto, produto_nome), uf, quantidade)
) WITH CLUSTERING ORDER BY (uf ASC, quantidade DESC);

CREATE INDEX relatorio3_uf ON relatorio3(uf);

INSERT INTO relatorio3 (id_pedido, id_produto, produto_nome, quantidade, valor, uf) VALUES(1230, 1020, 'Produto 1', 1, 10.0, 'SP');
INSERT INTO relatorio3 (id_pedido, id_produto, produto_nome, quantidade, valor, uf) VALUES(1234, 1021, 'Produto 2', 2, 20.0, 'SP');
INSERT INTO relatorio3 (id_pedido, id_produto, produto_nome, quantidade, valor, uf) VALUES(1235, 1020, 'Produto 1', 1, 10.0, 'MG');
INSERT INTO relatorio3 (id_pedido, id_produto, produto_nome, quantidade, valor, uf) VALUES(1236, 1020, 'Produto 1', 3, 10.0, 'SP');

SELECT id_produto, produto_nome, SUM(quantidade)
FROM relatorio3 
WHERE uf='SP'
GROUP BY id_produto, produto_nome;