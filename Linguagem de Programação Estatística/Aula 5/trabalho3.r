library(readxl)

# Abre o Arquivo Cadastral
Cadastral <- read_excel("Cadastral.xlsx")

# 1) Tire uma tabela de frequ�ncia usando a fun��o table na vari�vel Sexo. 
#    Quantos homens e quantas mulheres t�m no arquivo?
table(Cadastral$Sexo)

# 2) Ordenar a vari�vel ID
Cadastral <- Cadastral[order(Cadastral$ID),]
Cadastral

# 3) Remova os ID duplicados. Coloque esse arquivo dentro de um objeto chamado A.
A <- Cadastral[duplicated(Cadastral$ID, fromLast = FALSE),]
A

# 4) J� no objeto A. Tire uma tabela de frequ�ncia usando a fun��o table na vari�vel Sexo. 
#    Quantos homens e quantas mulheres t�m no arquivo?
table(A$Sexo)

# 5) Crie uma vari�vel data atual e acrescenta essa vari�vel ao objeto/ arquivo A.
data_atual <- Sys.Date()
A$DataAtual <- data_atual
A

# 6) Verifique se a vari�vel salario � num�rica?
is.numeric(A$salario)
# Sim, � num�rica

# 7) Mostre o m�nimo e o m�ximo da vari�vel salario.
min(A$salario)
max(A$salario)

# 8) Crie uma vari�vel faixa de salario com as seguintes quebras: 
#    1574, 3000, 5000, 7000, 13500  com as classes fechadas nas esquerda. 
#    Right = T. E coloque essa vari�vel no arquivo.
A$FaixaSalario <- cut(A$salario, 
                      breaks = c(1574, 3000, 5000, 7000, 13500), 
                      labels = c('1574 a 3000', '3001 a 5000', '5001 a 7000', '7001 a 13500'), right = TRUE)
A

# 9) Crie um visualizador/ matriz usando a fun��o View(A).
View(A)

# 10) Atribua o arquivo Transacional ao objeto B. 
#     E crie um visualizador/ matriz usando a fun��o View(B).
B <- read_excel("Transacional.xlsx")
View(B)

# 11) Crie um objeto chamado consolidado e fa�a uma uni�o dos arquivos A e B 
#     atrav�s do Left join. Usando a fun��o do R.
AB <- merge(A, B, by="ID", all.x=TRUE)
AB

# 12) Crie uma vari�vel comprometimento de renda usando as vari�veis ValorEmprestimo e Salario.  
#     Para isso utilize a express�o. (ValorEmprestimo / salario). 
AB$ComprometimentoRenda <- AB$ValorEmprestimo / AB$salario
AB
# Quantas vari�veis ficaram no arquivo?
dim(AB)[2]
# 18 variaveis

# 13) Tire uma frequ�ncia separadamente das vari�veis Sexo e default. 
#     Para isso utilize a fun��o Table. Quantos Homens, Mulheres, Adimplente e Inadimplente possui. 
#     Os valores precisam ser mostrados separadamente.
table(AB$Sexo)
table(AB$default)

# 14) Fa�a uma estat�stica Bivariada utilizando a fun��o CrossTable ente Sexo e default. 
#     Quem tem o maior percentual de inadimpl�ncia Homens ou Mulheres. E qual � esse valor? 
install.packages("gmodels")
library(gmodels)

CrossTable(AB$Sexo, AB$default)
# o maior percentual de inadimpl�ncia � de homens, com 54.3%
  
# 15) Fa�a os gr�ficos de histograma e Boxplot da vari�vel comprometimento de renda. 
#     Essas vari�veis se parece com uma distribui��o normal?
install.packages("ggplot2")
library(ggplot2)

boxplot(AB$ComprometimentoRenda)
hist(AB$ComprometimentoRenda)
# a distribui��o � normal

# 16) Crie um novo objeto chamado comprometimento de renda1 e substitui todos os valores 
#     maiores que 0.5 por 0.5 da vari�vel comprometimento de renda. 
#     Para tal opera��o utilize a fun��o replace. Verifique atrav�s do m�nimo e m�ximo se 
#     a vari�vel comprometimento de renda1 est� dentro dos limites, ou seja, se tem valores 
#     inferiores ou igual a 0.5. Coloque esse resultado no arquivo consolidado.
AB$ComprometimentoRenda1 <- replace(AB$ComprometimentoRenda, AB$ComprometimentoRenda > 0.5, 0.5)
summary(AB$ComprometimentoRenda1)
# Sim, os valores est�o dentro dos limites
View(AB)

# 17) Fa�a novamente os gr�ficos histograma e Boxplot da vari�vel comprometimento de renda1 
#     e verifique se ainda possui outliers? 
boxplot(AB$ComprometimentoRenda1)
hist(AB$ComprometimentoRenda1)
# N�o pussui mais outliners

# 18) Imprima o gr�fico das redes neurais
install.packages("neuralnet")
library(neuralnet)

net <-neuralnet(default1 ~ salario + ValorEmprestimo + QtdaParcelas + 
                           ComprometimentoRenda1 + TempodeResidencia +
                           TempodeServi�o
                , data=AB, hidden=10)
net

plot(net)
