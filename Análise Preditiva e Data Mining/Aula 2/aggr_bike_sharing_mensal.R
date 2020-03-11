library(readxl)

arquivo <- read_excel('aggr_bike_sharing_mensal.xlsx')

View(arquivo)

arquivo$periodo <- arquivo$ano + '-' + arquivo$mes
  
plot(arquivo)
