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


## 2) Como armazenar o registro de pagamentos em uma processadora de pagamentos, dado que uma compra pode ter várias tentativas de pagamento?

### Modo 1: tabela auxiliar de histórico com todos os campos e data de alteração

- Transacao
  - TransacaoId (PK)
  - Data

- Pagamento
  - TransacaoId (FK)
  - FormaPagamento
  - Status
  - Data

### Modo 2: tabela única com status

- Transacao
  - TransacaoId (PK)
  - FormaPagamento
  - Status
  - Data

## 3) Aplicativo de perfil de cliente

- Cliente
  - ClienteId (PK)
  - Usuario
  - Senha
  - Nome
  - Email
  - Endereco
  - Telefone
  - NumeroIdentidade
  - DataCriacao
  - Dataalteracao
  
- AnaliseCadastral
  - ClienteId (FK)
  - Status
  - Documento
  - Analise
  - Data
