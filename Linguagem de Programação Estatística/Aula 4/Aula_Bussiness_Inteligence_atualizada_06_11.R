
library(readxl)
Banco <- read_excel("D:/FIAP/BI/Banco.xlsx")
View(Banco)

attach(Banco_1)
names(Banco_1)

install.packages(c("plotly","ggplot2","plotrix","GGally","gridExtra","gganimate","gifski","png","av","esquisse"))

library(plotly)
library(ggplot2)
library(plotrix)
library(GGally)
library(gridExtra)
library(gganimate)
library(gifski)
library(png)
library(av)
library(esquisse)

#########################################################################

                # Gráfico de Barras

#########################################################################

# Grafico Simples
barplot(table(Banco$sexo))

##########################################################################

# Grafico Colorido
barplot(prop.table(table(Banco$sexo))*100,
  col=c("blue","red"))
  title("Tabela de Frequência", xlab = "Sexo", ylab="%")
  
prop.table(table(Banco$sexo))

##########################################################################

# Grafico package Plotly - Gráficos interativos com qualidade em publicação.
#install.packages("plotly")
#library(plotly)

barras <-plot_ly(x=Banco$sexo, y=Banco$salário, type ="bar")
barras


##########################################################################

# Gráfico Package ggplot.
#install.packages("ggplot2")
#library(ggplot2)

#fill=sexo cor.
#possition = dodge ajusta a posição para evitar sobreposição
grafico_barras <-ggplot(Banco, aes(x=catemp, fill=sexo))+
  geom_bar(position = 'dodge')+
  xlab("Grupos definido por sexo")+
  ylab("Numeros de clientes")+
  ggtitle("Gráfico de Barra")

grafico_barras

# Gráfico Package ggplot com plotly.
#ggplotly converte ggplot em plotly.
grafico_barras1 <-ggplotly(grafico_barras)
grafico_barras1

###########################################################################

                #Gráfico de Pizza

###########################################################################

# Gráfico simples
pizza <- pie(table(Banco$sexo))


# Gráfico 3D
# plotrix graficos platagem varios
#install.packages("plotrix")
#library(plotrix)

pie <-pie3D(table(Banco$sexo))


# Gráfico colorido e interativo

#as.data.frame transfere sexo var1
grafico_pie <-table(Banco$sexo)
grafico_pie1 <-as.data.frame(grafico_pie)
grafico_pie1

#%>% concatena as linhas da esquerda com a direita
grafico_pie2 <-plot_ly(grafico_pie1,
                       labels = ~Var1,
                       values = ~Freq,
                       type   = 'pie') %>%
                       layout(title = "Gráfico de Pizza")

grafico_pie2


##############################################################################

              #  Gráfico de Histograma

##############################################################################

# Gráfico simples
hist(Banco$salário)

# Gráfico colorido pacote ggplot
#fill lightblue azul claro
# ggtitle titulo grafico
# bin quantidade de faixa
# theme personaliza o grafico
histograma <-ggplot(Banco, aes(x=salário))+
  geom_histogram(color="blue", fill="lightblue", bins = 10)+
  xlab("variancia")+
  ylab("Frequencia contagem")+
  ggtitle("Gráfico_Histogrma")+
  theme()

histograma

# Grafico ggplot com plotly
ggplotly(histograma)


# ploty
plot_ly(x=Banco$salário, type='histogram')


# ggplot - plotly e função face_grid
# face_grid forma matrix
grafico_histograma_catemp <-ggplot(Banco, aes(x=salário))+
  geom_histogram(color="red", fill="lightblue", bins=30)+
  xlab("Variancia")+
  ylab("Frequencia")+
  ggtitle("Gráfico histograma")+
  facet_grid(~catemp)


grafico_histograma_catemp

interativo_histograma <-ggplotly(grafico_histograma_catemp)
interativo_histograma

#grafico densidade
# geom_density contorno
densidade <-ggplot(Banco, aes(x=salário, fill=catemp))+
  geom_density(alpha=0.5)+
  xlab("Variancia")+
  ylab("Frequência")+
  ggtitle("Grafico_densidade")+
  facet_grid(~catemp)


densidade

ggplotly(densidade)


#########################################################

                # Gráfico de dispersão/ linhas

#########################################################

#Gráfico simples
plot(Banco$salário~Banco$estudo)

#Gráfico ggplot
dispersao <-ggplot(Banco, aes(x=estudo, y=salário, color=sexo))+
geom_point()

dispersao
ggplotly(dispersao)

#Gráfico ggplot com função face_wrap
dispersao1 <-ggplot(Banco, aes(x=estudo, y=salário))+
  geom_point()+facet_wrap(~sexo)

dispersao1

#Gráfico ggplot com legenda
#size tamanho das bolinas
dispersao2 <-ggplot(Banco, aes(x=estudo, y=salário, color=sexo))+
  geom_point(size=1)+
  xlab("Variancia_estudo")+
  ylab("Variancia_salario")+
  ggtitle("Gráfico de dispersao")


dispersao2
ggplotly(dispersao2)


#Gráfico ggplot com plotly
dispersao <-plot_ly(x=Banco$estudo, y=Banco$salário, color=Banco$sexo)
dispersao

#Gráfico ggplot com legenda
dispersao4 <-ggplot(Banco, aes(x=estudo, y=salário, color=sexo))+
  geom_point(aes(size=5))+
  xlab("Variancia_estudo")+
  ylab("Variancia_salario")+
  ggtitle("Gráfico de dispersao")+
  facet_grid(~sexo)

dispersao4
ggplotly(dispersao4)


#####################################################################

            # Gráfico BoxPlot

#####################################################################



# Gráfico Simples
boxplot(Banco$cartao_credito)

# Gráfico colorido e separado por categoria de emprego
boxplot(Banco$cartao_credito~Banco$catemp,
        main="Cartao Credito por categoria emprego",
        xlab= "Catemp", ylab="Cartao Credito",
        col=c("blue","red","yellow"))


# Gráfico colorido e separado por categoria de emprego sem outliers.
boxplot(Banco$cartao_credito~Banco$catemp,
        main="Cartao Credito por categoria emprego",
        xlab= "Catemp", ylab="Cartao Credito",
        col=c("blue","red","yellow"), outline=FALSE, horizontal = TRUE)



# Gráfico ggplot colorido por categoria de emprego
boxplot<-ggplot(Banco, aes(x=Banco$cartao_credito , y=salário, fill=catemp))+
        geom_boxplot()+
        xlab("cartao de credito")+ 
        ylab("Cartao Credito")+
        ggtitle("Cartao Credito e salario por categoria emprego")


boxplot


# Gráfico BoxPlot interativo
boxplot_interativo<-
  plot_ly(x=Banco$catemp, y=Banco$cartao_credito,
        main="Gráfico interativo",
        xlab="Catemp",ylab="Cartao Credito",
        color=(Banco$catemp), outline = TRUE,type='box')

boxplot_interativo

# Gráfico interativo simples.
plot_ly (Banco, x=Banco$cartao_credito, type='box')



#########################################################################

            # Gráfico de linhas

#########################################################################

# Gráfico Simples
plot(Banco$cartao_credito, type='line')



# Gráfico colorido interativo
grafico_linha2 <- plot_ly(Banco, y=Banco$cartao_credito, type='scatter', mode='lines')
grafico_linha2


#Gráfico duplo interativo
duplo1 <-plot_ly(Banco, y=Banco$cartao_credito)%>%
  add_trace(y=~cartao_credito, type='scatter', name='Cartao Credito', mode='lines')%>%
  add_trace(y=~Emprestimos, type='scatter', name='Emprestimos', mode='lines')

duplo1

#Gráfico GGplot
linha <-ggplot(Banco, aes(x=datanasc, y=Emprestimos))+
  geom_line(col="blue")+
  xlab("Ano")+
  ylab("Emprestimos")+
  ggtitle("Emprestimos por ano")

linha
ggplotly(linha)


##############################################################################

                      # Gráfico na mesmo janela

#############################################################################

#install.packages("GGally")
#install.packages("gridExtra")
#library(GGally)
#library(gridExtra)
#library(plotly)

#Gráfico na mesma janela
grid.arrange(
  grafico_barras,
  histograma,
  linha,
  boxplot,
  dispersao2,
  grafico_barras,
  ncol=3, nrow=2)
  
  
# Gráfico Interativos
interativo <-ggpairs(iris,aes(color=Species))
ggplotly(interativo)


##############################################################

          # Gráficos de animação

##############################################################

#library(readxl)
#Banco_1 <- read_excel("F:/BI/Banco_1.xlsx")
#View(Banco_1)

#attach(Banco_1)

#install.packages("gganimate")
#library(gganimate)

# Gráficos com pacote gganimation
animacao <-ggplot(Banco_1, aes(x=estudo, y=salário,
                             size=Emprestimos, colour=catemp))+
                             geom_point(show.legend = FALSE, alpha=0.5)+
                             scale_color_viridis_d()+
                             scale_size(range=c(2,12))+
                             scale_x_log10()+
                             labs(x="Estudo", y="Salario")
                            
animacao

# Continuacao para animação
#install.packages("gifski")
#install.packages("png")
#library(gifski)
#library(png)

                          
# Primeira Animação
animacao + transition_time(Ano)+
  labs(title = "Ano:{frame_time}")



# Segunda Animação
animacao + facet_wrap(~catemp)+
  transition_time(Ano)+
  labs(title="Ano:{frame_time}")

# Terceira Animacao
animacao + transition_time(Ano)+
  labs(title = "Ano:{frame_time}")+
  view_follow(fixed_y = TRUE)

# Quarta Animacao
animacao + transition_time(Ano)+
  labs(title = "Ano:{frame_time}")+
  shadow_wake(wake_length = 0.1, alpha = FALSE)

# Quinta Animacao
animacao + transition_time(Ano)+
  labs(title = "Ano:{frame_time}")+
  shadow_mark(alpha = 0.3, size = 0.5)


###################  outra animação #########################

# Animação com ggplot

animacao_ggplot <-ggplot(Banco_1, aes(Ano, salário, group = catemp, color=factor(catemp)))+
  geom_line()+
  scale_color_viridis_d()+
  labs(x="Ano", y="Salario")+
  theme(legend.position = "top")

animacao_ggplot

# Primeira Animacao
animacao_ggplot + transition_reveal(Ano)

# Segunda Animacao
animacao_ggplot + geom_point()+
  transition_reveal(Ano)

#Terceira Animação
animacao_ggplot + geom_point(aes(group = seq_along(Ano)))+
  transition_reveal(Ano)



#############################################################

          #Animação com video

#############################################################

#install.packages("av")
#library(av)

# Primeira animação com video
video <-ggplot(Banco_1, aes(x=estudo, y=salário))+
  geom_point(aes(colour = catemp), size=2)+
  transition_states(catemp, transition_length = 10,
                    state_length = 1)

video
# Segunda animação
video + enter_fade()+
  exit_shrink()


# Agora com video - video outup
# Terceira Animação
animate (video + enter_fade()+
                   exit_fly(y_loc = 1),
                   renderer = av_renderer())
                            


###################################################################

              # Pacote esquisse

###################################################################

#install.packages("esquisse")
#library(esquisse)


janela <-esquisser(Banco_1)

Banco_1 <- Banco_1 %>%
  filter(datanasc >= "1947-02-09 14:24:00" & datanasc <= "1971-02-10 00:00:00") %>%
  
  filter(estudo >= 13L & estudo <= 21L)

ggplot(Banco_1) +
  aes(x = salário, y = estudo, colour = sexo, group = catemp) +
  geom_point(size = 1L) +
  scale_color_hue() +
  theme_minimal()





















  











































































