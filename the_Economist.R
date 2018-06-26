#Visualización Económica

#Se recreará este diagrama que fue publicado en el diario The Economist:

#https://www.economist.com/graphic-detail/2011/12/02/corrosive-corruption

#Importamos las bibliotecas ggplot2 data.table y use fread para cargar el archivo csv 'Economist_Assignment_Data.csv' en un dataframe llamado df (Usar drop = 1 para omitir la primera columna)

library(ggplot2)
library(data.table)
df <- fread('C:/Users/Mario/Documents/Economist_Assignment_Data.csv',drop=1)

#Primero valores de df 


head(df)

#Usamos ggplot() + geom_point() para crear un scatter plot llamado pl. Se necesita especificar x=CPI y y=HDI y color=Region como aesthetics

pl <- ggplot(df,aes(x=CPI,y=HDI,color=Region)) + geom_point()
pl

#Cambiamos los puntos por círculos...huecos. (Añadimos otros argumentos a geom_point() y reasignamos a pl.) 
                                                 
pl <- ggplot(df,aes(x=CPI,y=HDI,color=Region)) + geom_point(size=4,shape=1)
pl

#Añadimos geom_smooth(aes(group=1)) para añadir la línea de tendecia

pl + geom_smooth(aes(group=1))

#segumos editando esta línea de tendencia. Los argumentos de  geom_smooth (fuera de aes):
  
method = 'lm'
formula = y ~ log(x)
se = FALSE
color = 'red'

#Asignamos todo esto a pl2

pl2 <- pl + geom_smooth(aes(group=1),method ='lm',formula = y~log(x),se=FALSE,color='red')
pl2

#Se añaden notas y etiquetas

pl2 + geom_text(aes(label=Country))

#Es complicado etiquetar este subset 

pointsToLabel <- c("Rusia", "Venezuela", "Iraq", "Myanmar", "Sudán",
"Afganistán", "Congo", "Grecia", "Argentina", "Brasil",
"India", "Italia", "China", "Sudáfrica", "Spane",
"Botswana", "Cabo Verde", "Bhután", "Ruanda", "Francia",
"Estados Unidos", "Alemania", "Gran Bretaña", "Barbados", "Noruega", "Japón",
"Nueva Zelanda", "Singapur")

pl3 <- pl2 + geom_text(aes(label = País), color = "gray20", 
data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)

pl3

#Añadimos theme_bw()y salvamos esto como pl4

pl4 <- pl3 + theme_bw() 
pl4

#También añadimos scale_x_continuous() con estos argumetos:
  
#name = Como en la gráfica original
#limits = los límites del eje
#breaks = 1:10

pl5 <- pl4 + scale_x_continuous(name = "Índice de perpecpción de Corrupción, 2011 (10=menos corrupto)",
                                limits = c(.9, 10.5),breaks=1:10) 
pl5

#Ahora usamos scale_y_continuous para hacer operaciones en el eje y 
  
pl6 <- pl5 + scale_y_continuous(name = "Index de Desarrollo Humano, 2011 (1=Mejor)",
                                  limits = c(0.2, 1.0))
pl6

#Ahora ggtitle() para añadir una string como título.

pl6 + ggtitle("Corrupción y Desarrollo Humano")

#Usando ggthemes:

library(ggthemes)
pl6 + theme_economist_white()

#FIN



