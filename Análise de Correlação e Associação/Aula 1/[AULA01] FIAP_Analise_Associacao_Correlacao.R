
# Define Working directory
# setwd("~/FIAP")

# Basic summarization using table mtcars (a built-in dataframe)
data() # Show datasets already loaded in R
mtcars # Show table mtcars
View(mtcars) # View table mtcars mtcars
str(mtcars) # Show the structure of the table mtcars
help(mtcars) # Show data description
dim(mtcars) # Show amount of rows and columns to table mtcars
nrow(mtcars) # Show amount of lines to table mtcars
ncol(mtcars) # Show amount of columns to table mtcars

mtcars_first5lines <- mtcars[1:5,] # Filter first 5 rows and all columns of table mtcars
mtcars_first5lines
mtcars_filter1 <- subset(mtcars, mpg > 20 & cyl > 4) # Selectrows with mpg>20 and cyl>4
mtcars_filter1 # Show object mtcars_filter1
mtcars_filter2 <- subset(mtcars, hp > 200 | wt >= 3.570) # Select rows with wt>200 or wt>3.9
mtcars_filter2 # Show object mtcars_filter1
mtcars_filter3 <- subset(mtcars, carb == 8) # Select rows with carb=8
mtcars_filter3 # Show object mtcars_filter3
mtcars_filter4 <- subset(mtcars, carb == 8, select = c(carb, mpg)) # Select rows with carb=8, retaining just columns carb and mpg
mtcars_filter4 # Show object mtcars_filter4
mtcars_filter5 <- subset(mtcars, carb == 8, select = -c(carb, mpg)) # Select rows with carb=8, keeping all variables, except carb and mpg
mtcars_filter5 # Show object mtcars_filter5
amostra_mtcars <- mtcars[sample(1:nrow(mtcars), 10, replace = FALSE), ] # Select a sample of 10 rows of table mtcars
amostra_mtcars # Show object amostra_mtcars

summary(mtcars) # Show a summary of quantitative variable of table mtcars
summary(mtcars$mpg) # Show a summary of the variable mpg

#Using psych package to describe variables
install.packages("psych")
library(psych)
describeBy(mtcars$mpg, mtcars$cyl) # Descriptive summarization of mpf variable, by cyl variable

#Using the pastecs package to provide descriptive statistics
install.packages("pastecs")
library(pastecs)
#Checking cv statistics manually
stat.desc(mtcars$mpg)
cv_mpg<-sd(mtcars$mpg)/mean(mtcars$mpg)
cv_mpg

#Using summrytools package to provide descriptive statistics
install.packages("summarytools")
library(summarytools)
View(dfSummary(mtcars))

#Calculating quantiles to mpg variable
quantile(mtcars$hp) # Calculate some descriptive statistics to hp variable
quantile(mtcars$hp, seq(0, 1, 0.25)) # Calculate hp quartiles, from table mtcars
quantile(mtcars$hp, seq(0, 1, 0.1)) # Calculate hp deciles, from table mtcars

#Using summarytools package to produce frequency tables for categorical variables
freq(mtcars$cyl)

#Using gmodels package to produce frequency tables for categorical variables
install.packages("gmodels")
library(gmodels)
CrossTable(mtcars$cyl)

#Exploratory charts
par(mar = rep(2, 4))
hist(mtcars$mpg, col=rainbow(12))
boxplot(mtcars$hp, col = "red")
boxplot(mtcars$mpg ~ mtcars$cyl, 
        horizontal = T, frame = F, col = "lightgray", 
        main = "Distribution")


#Show multiple charts
attach(mtcars)
par(mfrow=c(2,2))
plot(wt,mpg, main="Scatterplot of wt vs. mpg")
plot(wt,disp, main="Scatterplot of wt vs disp")
hist(wt, main="Histogram of wt")
boxplot(wt, main="Boxplot of wt")

cor(mtcars$disp, mtcars$wt)
cor(mtcars$wt, mtcars$mpg)
round(cor(mtcars), 2)

plot(qsec, drat, main="Scatterplot of qsec vs drat") # low correlation

#Show multiple charts
library(ggplot2)
p1 <- qplot(mpg, wt, data = mtcars, colour = cyl)
p2 <- qplot(mpg, data = mtcars) + ggtitle("title")
p3 <- qplot(mpg, data = mtcars, geom = "dotplot")
grid.arrange(p1,p2, nrow=1)


#Use plotly package to draw exploratory charts
install.packages("plotly")
library(plotly)
plot_ly(y=mtcars$hp, type = "box", boxpoints = "all", jitter = 0.3,pointpos = -1.8)

#Multiple box plots in the same chart
plot_ly(ggplot2::diamonds, y = ~price, color = ~cut, type = "box")

#Simple Scatterplots
plot_ly(data = mtcars, x = ~mpg, y = ~hp)

#Stylish scatterplot
plot_ly(data = mtcars, x = ~mpg, y = ~hp,
             marker = list(size = 10,
                           color = 'rgba(255, 182, 193, .9)',
                           line = list(color = 'rgba(152, 0, 0, .8)',
                                       width = 2))) %>%
  layout(title = 'Styled Scatter',
         yaxis = list(zeroline = FALSE),
         xaxis = list(zeroline = FALSE))

#Adding color and size mapping to the scatterplot
d <- diamonds[sample(nrow(diamonds), 1000), ]
plot_ly(d, x = ~carat, y = ~price,
  color = ~carat, size = ~carat
)

#*****************ATIVIDADE EM CLASSE************************************

# Importing MS Excel sheet
hr <- read_excel("HR_Analytics.xlsx", sheet = "Plan1")
View(hr)


