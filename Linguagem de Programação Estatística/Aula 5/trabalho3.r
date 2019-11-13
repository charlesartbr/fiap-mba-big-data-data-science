library(readxl)

# Abre o Arquivo Cadastral
Cadastral <- read_excel("Cadastral.xlsx")

# 1) Tire uma tabela de frequência usando a função table na variável Sexo. 
#    Quantos homens e quantas mulheres têm no arquivo?
table(Cadastral$Sexo)

# 2) Ordenar a variável ID
Cadastral <- Cadastral[order(Cadastral$ID),]
Cadastral

# 3) Remova os ID duplicados. Coloque esse arquivo dentro de um objeto chamado A.
A <- Cadastral[duplicated(Cadastral$ID, fromLast = FALSE),]
A

# 4) Já no objeto A. Tire uma tabela de frequência usando a função table na variável Sexo. 
#    Quantos homens e quantas mulheres têm no arquivo?
table(A$Sexo)

# 5) Crie uma variável data atual e acrescenta essa variável ao objeto/ arquivo A.
data_atual <- Sys.Date()
A$DataAtual <- data_atual
A

# 6) Verifique se a variável salario é numérica?
is.numeric(A$salario)
# Sim, é numérica

# 7) Mostre o mínimo e o máximo da variável salario.
min(A$salario)
max(A$salario)

# 8) Crie uma variável faixa de salario com as seguintes quebras: 
#    1574, 3000, 5000, 7000, 13500  com as classes fechadas nas esquerda. 
#    Right = T. E coloque essa variável no arquivo.
A$FaixaSalario <- cut(A$salario, 
                      breaks = c(1574, 3000, 5000, 7000, 13500), 
                      labels = c('1574 a 3000', '3001 a 5000', '5001 a 7000', '7001 a 13500'), right = TRUE)
A

# 9) Crie um visualizador/ matriz usando a função View(A).
View(A)

# 10) Atribua o arquivo Transacional ao objeto B. 
#     E crie um visualizador/ matriz usando a função View(B).
B <- read_excel("Transacional.xlsx")
View(B)

# 11) Crie um objeto chamado consolidado e faça uma união dos arquivos A e B 
#     através do Left join. Usando a função do R.
AB <- merge(A, B, by="ID", all.x=TRUE)
AB

# 12) Crie uma variável comprometimento de renda usando as variáveis ValorEmprestimo e Salario.  
#     Para isso utilize a expressão. (ValorEmprestimo / salario). 
AB$ComprometimentoRenda <- AB$ValorEmprestimo / AB$salario
AB
# Quantas variáveis ficaram no arquivo?
dim(AB)[2]
# 18 variaveis

# 13) Tire uma frequência separadamente das variáveis Sexo e default. 
#     Para isso utilize a função Table. Quantos Homens, Mulheres, Adimplente e Inadimplente possui. 
#     Os valores precisam ser mostrados separadamente.
table(AB$Sexo)
table(AB$default)

# 14) Faça uma estatística Bivariada utilizando a função CrossTable ente Sexo e default. 
#     Quem tem o maior percentual de inadimplência Homens ou Mulheres. E qual é esse valor? 
install.packages("gmodels")
library(gmodels)

CrossTable(AB$Sexo, AB$default)
# o maior percentual de inadimplência é de homens, com 54.3%
  
# 15) Faça os gráficos de histograma e Boxplot da variável comprometimento de renda. 
#     Essas variáveis se parece com uma distribuição normal?
install.packages("ggplot2")
library(ggplot2)

boxplot(AB$ComprometimentoRenda)
hist(AB$ComprometimentoRenda)
# a distribuição é normal

# 16) Crie um novo objeto chamado comprometimento de renda1 e substitui todos os valores 
#     maiores que 0.5 por 0.5 da variável comprometimento de renda. 
#     Para tal operação utilize a função replace. Verifique através do mínimo e máximo se 
#     a variável comprometimento de renda1 está dentro dos limites, ou seja, se tem valores 
#     inferiores ou igual a 0.5. Coloque esse resultado no arquivo consolidado.
AB$ComprometimentoRenda1 <- replace(AB$ComprometimentoRenda, AB$ComprometimentoRenda > 0.5, 0.5)
summary(AB$ComprometimentoRenda1)
# Sim, os valores estão dentro dos limites
View(AB)

# 17) Faça novamente os gráficos histograma e Boxplot da variável comprometimento de renda1 
#     e verifique se ainda possui outliers? 
boxplot(AB$ComprometimentoRenda1)
hist(AB$ComprometimentoRenda1)
# Não pussui mais outliners

# 18) Imprima o gráfico das redes neurais
install.packages("neuralnet")
library(neuralnet)

net <-neuralnet(default1 ~ salario + ValorEmprestimo + QtdaParcelas + 
                           ComprometimentoRenda1 + TempodeResidencia +
                           TempodeServiço
                , data=AB, hidden=10)
net

plot(net)
