# Aula 2 - MongoDB

db.createCollection("user");

## Insert
db.user.insert({ name: "Charles" });  
db.user.insert({ name: "Charles", date: new Date() });  

## Update
// atualiza todo o documento  
db.user.update({ name: "Charles" }, { name: "Charles", date: new ISODate() });  

// atualiza somente alguns dados  
db.user.update({ name: "Charles" }, { $set: { date: new ISODate() } });  

// atualiza todos que seguirem o criterio  
db.user.update({ name: "Charles" }, { $set: { date: new ISODate() } }, { multi: true });  

// upsert: se existir altera, se não existir insere  
db.user.update({ name: "Charles" }, { $set: { date: new ISODate() } }, { upsert: true });  

## Find
db.user.find({}).pretty();  
db.user.find({ name: "Charles" }).pretty();  
db.user.findOne({ name: "Charles" });  
db.user.find({ date: { $gt: new ISODate('2019-08-13') } });  
db.user.find({ date: { $ne: null } });  
db.user.find({ date: { $exists: true } });  
db.user.findOne({ name: /Ch/ });  
db.user.find({}).sort({ nome: 1, date: -1 });  
db.user.find({}).skip(2).limit(10);  
db.user.find({ $or: [{ name: "Charles" }, { name: "Charless" } ] })
db.user.find({ $and: [{ name: "Charles" }, { date: { $exists: true } } ] })

## Remove
db.user.remove({ name: "Charles" });  

## Index
db.user.createIndex({ name: 1 })
