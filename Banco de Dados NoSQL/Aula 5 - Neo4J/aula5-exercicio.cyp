// cria nós
CREATE (u1:Usuario { Nome: 'Usuário 1', Id: 1 })
CREATE (u2:Usuario { Nome: 'Usuário 2', Id: 2 })
CREATE (u3:Usuario { Nome: 'Usuario 3', Id: 3 })

// retorna nós
MATCH (u1:Usuario { Nome: 'Usuário 1', Id: 1 }) RETURN u1
MATCH (u2:Usuario { Nome: 'Usuário 2', Id: 2 }) RETURN u2
MATCH (u3:Usuario { Nome: 'Usuario 3', Id: 3 }) RETURN u3
MATCH(u) WHERE id(u) >= 0 RETURN u
MATCH(u) RETURN u
MATCH(u) WHERE u.Nome='Usuário 1' RETURN u

// cria relacionamentos
MATCH(u1) WHERE u1.Id=1
MATCH(u2) WHERE u2.Id=2
MATCH(u3) WHERE u3.Id=3
CREATE (u1)-[r1:CONHECE]->(u2)
CREATE (u2)-[r2:CONHECE]->(u3)
CREATE (u3)-[r3:CONHECE]->(u1)

// relacionamento errado
CREATE (u1: Usuario { Id: 2 })-[r:VIU]->(u2: Usuario { Id: 1 })
// excluir relacionamento errado
MATCH (n)<-[r:VIU]-(u) DELETE n, r, u

// deleta tudo
MATCH (n) DETACH DELETE n 

// alterar o label
MATCH(u) WHERE u.Id = 1 SET u:User RETURN u

// remover um label
MATCH(u) WHERE u.Id = 1 REMOVE u:User RETURN u