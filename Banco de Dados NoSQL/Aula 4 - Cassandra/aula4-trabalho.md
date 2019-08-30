# Trabalho Cassandra

**334409 - Charles Guimarães Cavalcante**

Nossa plataforma de marketplace, deseja realizar algumas analises e relatórios
sobre as vendas, produtos e lojas em tempo real (Near Real Time). Dado o grande
volume de informaçôes que serâo armazenadas, o Volume de escrita que será
superior ao de leitura e forte necessídade de baixo tempo de resposta, como
responsaveis pela arquitetura dessa estrutura, vocês definiram o Cassandra como
solução de armazenamento de Dados.

## Entidades

## Relatórios

### Pedidos realizados na ultima hora por loja:

```
CREATE TABLE relatorio1 (
    id_loja INT, 
    data TIMESTAMP, 
    hora INT, 
    id_pedido INT, 
    id_produto INT, 
    cliente_nome TEXT, 
    cidade TEXT, 
    uf TEXT, 
    itens_nome TEXT, 
    quantidade INT, 
    valor DECIMAL, 
    PRIMARY KEY ((id_loja,data,hora),id_pedido)
) WITH CLUSTERING ORDER BY (id_loja ASC, data DESC, hora DESC);
```

**Índices para atender às premissas:**
```
CREATE INDEX relatorio1_uf ON relatorio1(uf);
CREATE INDEX relatorio1_produto ON relatorio1(id_produto);
```

**Query para retornar os pedidos da loja 123 no dia '2019-08-29' e hora 21:**
```
SELECT id_pedido, id_produto, cliente_nome, cidade, uf, itens_nome, quantidade, valor 
FROM relatorio1 
WHERE id_loja=123 and data='2019-08-29' and hora=21;
```

### Produtos vendidos na ultima hora

```
CREATE TABLE relatorio2 (
    status TEXT, 
    data TIMESTAMP, 
    hora INT, 
    id_pedido INT, 
    id_produto INT, 
    cliente_nome TEXT, 
    cidade TEXT, 
    uf TEXT, 
    itens_nome TEXT, 
    quantidade INT, 
    valor DECIMAL, 
    PRIMARY KEY ((status,data,hora),id_pedido)
) WITH CLUSTERING ORDER BY (status ASC, data DESC, hora DESC);
```

**Índices para atender às premissas:**
```
CREATE INDEX relatorio2_uf ON relatorio1(uf);
CREATE INDEX relatorio2_produto ON relatorio1(id_produto);
```

**Query para retornar os pedidos com status 'Pagamento realizado' no dia '2019-08-29' e hora 21:**
```
SELECT id_pedido, id_produto, cliente_nome, cidade, uf, itens_nome, quantidade, valor 
FROM relatorio2 
WHERE status='Pagamento realizado' and data='2019-08-29' and hora=21;
```
