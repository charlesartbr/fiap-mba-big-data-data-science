let res = [
    db.createCollection("alunos"),
    db.alunos.insert({ "nome": "Charles", "rm": "334409" }),
    db.alunos.insert({ "nome": "Aline", "rm": "334407" })
];

print('------------------------------------');
print('');
print('-----  INICIANDO TABELA alunos -----');
print('');
printjson(res);
print('');
print('-----   TABELA alunos CRIADA   -----');
print('');
print('------------------------------------');
