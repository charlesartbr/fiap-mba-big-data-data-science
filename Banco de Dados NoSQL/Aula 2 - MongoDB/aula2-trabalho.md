## Pedidos

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

## Restaurates

```javascript
// 1) Exibir os campos restaurant_id, name, borough e cuisine para todos os documentos na coleção restaurants. 
db.restaurants.find({}, { 
    restaurant_id: "", 
    name: "", 
    borough: "", 
    cuisine:"" 
}).pretty()

// 2 - Exibir todo o restaurante que está no bairro Bronx.
db.restaurants.find({ borough: "Bronx" }, { 
    restaurant_id: "", 
    name: "", 
    borough: "", 
    cuisine:"" 
}).pretty()

// 3 - Exibir os primeiros 5 restaurantes que estão no bairro Bronx.
db.restaurants.find({ borough: "Bronx" }, { 
    restaurant_id: "", 
    name: "", 
    borough: "", 
    cuisine:"" 
}).limit(5).pretty()

// 4 - Encontrar o restaurante Id, nome e bairro para os restaurantes que obtiveram uma pontuação inferior a 10. 
db.restaurants.find({ "grades.score": { $lt: 10 } }, { 
    restaurant_id: "", 
    name: "", 
    borough: ""
}).pretty()

// 5 - Encontrar o nome do restaurante, bairro e tipo de culinária para os restaurantes que contém 'mon' como três letras em algum lugar em seu nome.
db.restaurants.find({ cousine: { $ne: "American" } }, { 
    name: "", 
    borough: "",
    cousine: ""
}).pretty()
```

### Desafio Extra: Elaborar consulta para encontrar os restaurantes que não preparam qualquer culinária de 'americano' e sua nota maior que 70 e latitude menor que -65.754168.
```javascript

// criação do indice
db.restaurants.createIndex({ "address.coord": "2dsphere" })

// query
db.restaurants.find({ 
    $and: [
        { cuisine: { $not: /american/i } },
        { "grades.score": { $gt: 70 } },
        { "address.coord[0]": { $lt: -65.754168 } }
    ]
}, { 
    name: 1, 
    borough: 1,
    cuisine: 1,
    _id: 0
}).pretty()
```