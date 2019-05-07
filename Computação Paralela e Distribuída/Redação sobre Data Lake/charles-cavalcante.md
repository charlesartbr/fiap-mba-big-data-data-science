# Os prós e contras que as empresas devem considerar ao construir um Data Lake

Para contextualizar as diferenças entre um Data Warehouse e um Dake Lake temos que primeiramente definir quais são as principais características de cada um:

## Data Warehouse

- Representa um modelo abstrato do negócio, organizado por áreas.
- É altamente transformado e já possui modelos bem estruturados.
- Os dados não são carregados no data warehouse sem que o uso não tenha sido definido.

## Data Lake

- Todos os dados da empresa são carregados de todas as fontes, nenhum dado é descartado.
- Os dados são armazenados no formato original, sem modificações.
- Os dados são transformados e modelados para atender às necessidades de análise.

Dadas estas definições, podemos destacar as principais vantagens do data lake nos aspectos a seguir.

## Data Lake mantém todos os dados
Enquanto no data warehouse nós inserimos somente os dados que já fazem sentido para o negócio e já estão estruturados e prontos para serem utilizados, no data lake inserimos todos os dados, mesmo os que nunca foram utilizados, pois eles podem ser utilizados um dia. No data lake podemos manter todos os dados e todo o histórico por ser muito mais fácil e barato para escalonar.

## Data Lake suporta todos os tipos de dados
No data warehouse os dados são bem estruturados e foram extraídos de sistemas transacionais na empresa. No data lake podemos adicionar todos os tipo de dados, estruturados (transacionais, tabelas), semi-estruturados (logs, xml, json) e não estruturados (textos, imagens, áudios, vídeos). Os dados serão transformados e modelados somente no momento de seu uso.

## Data Lake atende a todos os usuários
O data lake atende a necessidade dos usuários que precisamos apenas de seus relatórios já estruturados quanto aos cientistas de dados que poderão fazer análises mais profundas dos dados, utilizando ferramentas para análises estatisticas e de predição.

## Data Lake se adapta facilmente
No data warehouse as mudanças podem ser realizadas, porém podem ser demoradas ou ter um custo elevado, por exemplo adicionar uma nova coluna em uma tabela com bilhões de registros pode demorar muito tempo e consumir muito recurso. No data lake como os dados são armazenados no estado bruto é muito mais simples ser substituído ou modificado.

## Data Lake possibilita mais análises
O cientista de dados pode explorar dados que não são normalmente utilizados pela empresa para extrair informações importantes para a empresa, as possibilidades são muito maiores considerando que alguns tipos de dados nem sequer poderiam ser utilizados no data warehouse.
