# Aula 2 - MongoDB

## Create Collection
```javascript
db.createCollection("user");
```

## Insert
```javascript
db.user.insert({ name: "Charles" });  
db.user.insert({ name: "Charles", date: new Date() });  
```
## Update
```javascript
// atualiza todo o documento  
db.user.update({ name: "Charles" }, { name: "Charles", date: new ISODate() });  

// atualiza somente alguns dados  
db.user.update({ name: "Charles" }, { $set: { date: new ISODate() } });  

// atualiza todos que seguirem o criterio  
db.user.update({ name: "Charles" }, { $set: { date: new ISODate() } }, { multi: true });  

// upsert: se existir altera, se não existir insere  
db.user.update({ name: "Charles" }, { $set: { date: new ISODate() } }, { upsert: true });  
```

## Find
```javascript
db.user.find({}).pretty();  
db.user.find({ name: "Charles" }).pretty();  
db.user.findOne({ name: "Charles" });  
db.user.find({ date: { $gt: new ISODate('2019-08-13') } });  
db.user.find({ date: { $ne: null } });  
db.user.find({ date: { $exists: true } });  
db.user.findOne({ name: /Ch/ });  
db.user.find({}).sort({ nome: 1, date: -1 });  
db.user.find({}).skip(2).limit(10);  
db.user.find({ $or: [{ name: "Charles" }, { name: "Charless" } ] });  
db.user.find({ $and: [{ name: "Charles" }, { date: { $exists: true } } ] });  
```

## Remove
```javascript
db.user.remove({ name: "Charles" });  
```

## Index
```javascript
db.user.createIndex({ name: 1 })
```

## Aggregate
```javascript
db.pedidos.aggregate([
    { $unwind: "$produtos" },
    { $match: { status: "Pagamento Confirmado" } },
    { $group: { _id: "$numeroPedido", total: { $sum: { $multiply: [ "$produtos.valor", "$produtos.quantidade" ] } } } }
]);
```