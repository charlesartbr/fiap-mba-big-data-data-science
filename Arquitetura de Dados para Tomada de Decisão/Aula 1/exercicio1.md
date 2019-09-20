## 1) Como armazenar o histórico de alterações no cadastro de clientes de uma corretora de valores?

### Modo 1: tabela auxiliar de histórico com todos os campos e data de alteração

- Cadastro
  - CPF (PK)
  - Nome
  - DataNascimento

- CadastroHistorico
  - CPF (PK)
  - Nome
  - DataNascimento
  - DataAlteracao

-----

### Modo 2: tabela auxiliar de histórico com todos os campos serializados

- Cadastro
  - CPF (PK)
  - Nome
  - DataNascimento

- CadastroHistorico
  - CPF (PK)
  - Dados (JSON)

-----

### Modo 3: tabela com campo versão

- Cadastro
  - CPF (PK)
  - Versao (PK)
  - Nome
  - DataNascimento
