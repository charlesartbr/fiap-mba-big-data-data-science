let res = [
    db.createCollection("alunos"),
    db.alunos.insert({ "nome": "Charles Cavalcante", "rm": "334409" })
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
