# 1) Calcule a express�o num�rica:
aa <- ((sqrt(16) / 2) * 3 ^ 2) / 2 * (9 - 2 ^ 3)
aa

# 2) Calcule a express�o num�rica:
bb <- -(-2 ^ 3) + ((-1) ^ 0) - sqrt(25 - 3 ^ 2) - (5 ^ 3) / 25
bb

# 3) Crie um Data.Frame com as vari�veis nome, sobrenome, cpf, idade. 
#    Ao menos 5 linhas. Cria uma vari�vel digito_verificador extraindo 
#    o nono digito do cpf, crie uma vari�vel nome_completo concatenando 
#    nome e sobrenome e inclua no data.frame essas duas vari�veis. 
Nome <- c("Charles", "Elisabete", "Maria", "Camila", "Moacir")
Sobrenome <- c("Cavalcante", "Bueno", "Guimar�es", "Bueno", "Almeida")
Cpf <- c("269.983.718-99", "589.537.456-18", "159.753.486-25", "741.852.963-00", "784.512.895-63")
Idade <- c(40, 44, 82, 23, 59)
Cadastro <- data.frame(Nome, Sobrenome, Cpf, Idade)
Cadastro$digito_verificador <- substr(Cadastro$Cpf, 11, 11)
Cadastro$nome_completo <- paste(Cadastro$Nome, Cadastro$Sobrenome)
Cadastro

# 4) Soma o 2� com o 3� elemento da matriz A.
A <- matrix(4:7, nrow = 2)
sum(A[2:3])

# 5) No Arquivo Banco: Crie uma vari�vel faixasal a partir da vari�vel sal�rio com as seguintes quebras: 
#    E coloque essa vari�vel no Banco.

library(readxl)

setwd("C:/Users/logonrmlocal/Desktop/fiap-mba-big-data-data-science/Linguagem de Programa��o Estat�stica/Aula 3")

Banco <- read_excel("./Banco.xlsx")

attach(Banco)

faixas <- c(15000, 35000, 45000, 55000, 135000)
legendas <- c('15000 at� 35000', '35001 at� 45000', '45001 at� 55000', '55001 at� 135000')

Banco$faixasal = cut(Banco$sal�rio, breaks = faixas, labels = legendas, right = T)

Banco
