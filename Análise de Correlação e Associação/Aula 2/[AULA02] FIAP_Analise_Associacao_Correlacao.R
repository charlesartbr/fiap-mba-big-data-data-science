
#********************************EXEMPLO 01 GERACAO DE NUMEROS NO R*************************************

#Geração de numeros da megasena
# Effective way of generating 6 numbers to Megasena lottery
megasena <- View(as.data.frame(t(replicate(sort(sample(1:60, 6, replace = FALSE)), 
                                           n = 1000))))

#********************************EXEMPLO 02 GERACAO NUMEROS ALEATORIOS*******************************************

amostra_1000<-runif(1000,0,1)
amostra_1000
summary(amostra_1000)
system.time(amostra_1000<-runif(1000,0,1))


amostra_100000<-runif(100000,0,1)
amostra_100000
summary(amostra_100000)
system.time(amostra_100000<-runif(100000,0,1))

amostra_100000000<-runif(100000000,0,1)
amostra_100000000
summary(amostra_100000000)
system.time(amostra_100000000<-runif(100000000,0,1))

#********************************EXEMPLO 03 DIST NORMAL*********************************************
#Assuma que os scores de testes de admissao a um colegio se ajusta a distribuicao normal.
#Alem disso, o score medio eh 72 e o desvio padrao eh 15.2. Qual a porcentagem esperada
#de estudantes com score>84?

pnorm(84,mean=72, sd=15.2, lower.tail = FALSE)

#********************************EXEMPLO 04 DIST NORMAL*********************************************
# A distribuicao normal das alturas de homens nos EUA tem uma media de 70 polegadas e um
#desvio padrao de 4 polegadas. 

#a) Qual a proporcao esperada de homens entre 60 e 72 nos EUA?
pnorm(72,mean=70, sd=4)-pnorm(60,mean=70, sd=4)

#b) Qual a altura maxima para 75% da populacao?
qnorm(0.75, mean=70, sd=4)
pnorm(72.69796,mean=70,sd=4) #Prova real para ver se deu certo

#c) Simular um histograma com n=1000 com a distribuicao fornecida das alturas dos
# homens nos EUA
altura<-rnorm(1000,mean=70,sd=4)
mean(altura)
sd(altura)
hist(altura, col = "blue")

#*********************************EXEMPLO 05 DIST POISSON**********************************
#Uma loja vende 5 camisas todos os dias, entao qual a probabilidade de vender 3 camisas
#hoje?
ppois(3, lambda=5, lower=FALSE) #Probabilidade de 4 ou mais camisas
ppois(3, lambda=5) #Probabilidade de 3 ou menos
ppois(2, lambda=5, lower=FALSE) - ppois(3, lambda=5, lower=FALSE) #Probabilidade de exatamente 3 camisas

#*********************************EXEMPLO 06 DIST POISSON**********************************
#Se doze carros em média cruzam uma ponte por minuto, qual a probabilidade de ter 17 carros
#ou mais cruzando a ponte por minuto?
ppois(16, lambda=12, lower=FALSE) #Probabilidade de 17 ou mais carros

#*********************************EXEMPLO 07 TESTE HIPOTESES**********************************
#Os registros dos ultimos anos de um colegio atestam para os calouros admitidos uma nota 
#media de 115. Para testar a hipotese de que a media de uma nova turma  eh a mesma das 
# turmas anteriores, retirou-se uma amostra de 20 notas, obtendo-se media 118 e desvio
#padrao 20. Admitindo um nivel de significancia de 5% para o teste, qual a conclusao?
nota_a_ser_testada<-115
media_amostral<-118
desvio_padrao_amostral<-20
tamanho_amostra<-20
nivel_significancia<-0.05
t<-(media_amostral-nota_a_ser_testada)/(desvio_padrao_amostral/sqrt(tamanho_amostra))
t #estatistica de teste
t_meio_nivelsig<-qt(1-(nivel_significancia)/2, df=tamanho_amostra-1)
c(-t_meio_nivelsig, t_meio_nivelsig)

#*********************************EXEMPLO 08 TESTE HIPOTESES**********************************
#Desejando-se conhecer a média de gasto anual com medicamentos na  cidade Y, selecionou-se
#uma amostra aleatÃ³ria de 100 adultos maiores de 40 anos, com media igual a 95,10 e dp igual a 63,333.
#Teste a hipÃ³tese de que o gasto anual dessa população é inferior ao gasto médio de R$  120,00 a.a.
# com nível de significÃ¢ncia de 5%?  

gastomedio_a_ser_testado<-120
media_amostral<-95.10
desvio_padrao_amostral<-63.333
tamanho_amostra<-100
nivel_significancia<-0.05
t<-(media_amostral-gastomedio_a_ser_testado)/(desvio_padrao_amostral/sqrt(tamanho_amostra))
t #estatistica de teste
t_meio_nivelsig<-qt(nivel_significancia, df=tamanho_amostra-1)