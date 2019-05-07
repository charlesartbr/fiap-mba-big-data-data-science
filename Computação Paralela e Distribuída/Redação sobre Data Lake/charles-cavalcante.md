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
