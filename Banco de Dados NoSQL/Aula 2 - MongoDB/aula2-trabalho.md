```javascript
db.pedidos.insert({
    nome: "Charles Cavalcante", email: "contato@charles.art.br", telefone: "(11) 98765-4321",
    status: "Pagamento Confirmado",
    endereco: {
        logradouro: "Av. Paulista", numero: "1106", complemento: "7º andar", bairro: "Cerqueira César",
        cep: "01311-000", cidade: "São Paulo", uf: "SP"
    },
    carrinho: [
        { idProduto: ObjectId("5d5367f4898cf8e7dbb0db03"), nome: "iPhone X", quantidade: 1, valor: 4581.81 },
        { idProduto: ObjectId("5d536801898cf8e7dbb0db04"), nome: "Moto G7 Plus", quantidade: 1, valor: 1249.90 }
    ],
    formaPagamento: {
        tipo: "Cartão de Crédito",
        bandeira: "MasterCard",
        parcelas: 12,
        numeroMascarado: "5432-XXXX-XXXX-1234"
    }
});
```

```javascript
db.pedidos.createIndex({ status: 1 })
db.pedidos.createIndex({ "endereco.uf": 1 })
```

```javascript
db.pedidos.aggregate([
 { $match: { status: "Pagamento Confirmado" } },
 { $group: { _id: "$endereco.uf", total: { $sum: "$carrinho.valor" } } }
])
```
