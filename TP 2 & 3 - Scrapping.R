library(rvest)
library(tidyverse)

# Ejercicio 2

# Scrapeamos los datos

crpyto_url <- read_html("https://www.tradingview.com/markets/cryptocurrencies/prices-all/")

crypt_table <- html_nodes(crpyto_url, css = "table")

crypt_table <- html_table(crypt_table, fill = T) %>% 
  as.data.frame()

# Quitamos caracteres que estan en las tablas descargadas para quedarnos con los numeros

crypt_table$Var.2 <- gsub("B","", crypt_table$Var.2)
crypt_table$Var.2 <- gsub("M","", crypt_table$Var.2)
crypt_table$Var.2 <- gsub("K","", crypt_table$Var.2)
crypt_table$Var.3 <- gsub("B","", crypt_table$Var.3)
crypt_table$Var.3 <- gsub("M","", crypt_table$Var.3)
crypt_table$Var.3 <- gsub("K","", crypt_table$Var.3)
crypt_table$Var.4 <- gsub("B","", crypt_table$Var.2)
crypt_table$Var.4 <- gsub("M","", crypt_table$Var.4)
crypt_table$Var.4 <- gsub("K","", crypt_table$Var.4)
crypt_table$Var.5 <- gsub("B","", crypt_table$Var.5)
crypt_table$Var.5 <- gsub("M","", crypt_table$Var.5)
crypt_table$Var.5 <- gsub("K","", crypt_table$Var.5)
crypt_table$Var.6 <- gsub("B","", crypt_table$Var.6)
crypt_table$Var.6 <- gsub("M","", crypt_table$Var.6)
crypt_table$Var.6 <- gsub("K","", crypt_table$Var.6)
crypt_table$Var.7 <- gsub("B","", crypt_table$Var.7)
crypt_table$Var.7 <- gsub("M","", crypt_table$Var.7)
crypt_table$Var.7 <- gsub("K","", crypt_table$Var.7)
crypt_table$Var.8 <- gsub("B","", crypt_table$Var.8)
crypt_table$Var.8 <- gsub("M","", crypt_table$Var.8)
crypt_table$Var.8 <- gsub("K","", crypt_table$Var.8)
crypt_table$Var.8 <- gsub("%","", crypt_table$Var.8)

# Imputamos los nombres correspondientes a las Columnas

x <- c("Crypto","Capitalizacion_Mercado", "Fd_Capitalizacion_Mercado", "Ultima_Cotiz", "Q_disponible", 
       "Q_total", "Volumen_operado", "Evolucion")

names(crypt_table) <- x

# Convertimos nuestros valores a numericos 

crypt_table <- 
  data.frame(apply(crypt_table[2:8],2, as.numeric)) %>% 
  cbind(Crypto = crypt_table$Crypto) %>% 
  select(8,1:7)

# Ejercicio 3

# Veamos cuales son las monedas mas operadas segun volumen

crypt_table %>% 
  select(Crypto, Volumen_operado) %>% 
  filter(Volumen_operado > 600) %>% 
  ggplot(., aes(reorder(Crypto, Volumen_operado), Volumen_operado )) +
  geom_bar(stat = "identity", aes(fill = Volumen_operado)) + coord_flip() +
  ggtitle("Top 10 Monedas operadas segun volumen") +
  xlab("Crypto") + ylab("Volumen_operado") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 15),
        axis.title.x = element_text(face = "bold", size =  13),
        axis.title.y = element_text(face = "bold", size = 13))

# Veamos las monedas que mas incrementaron su valor

crypt_table %>% 
  select(Crypto, Evolucion) %>% 
  filter(Evolucion > 10) %>% 
  ggplot(., aes(reorder(Crypto, Evolucion), Evolucion )) +
  geom_bar(stat = "identity", aes(fill = Evolucion)) + coord_flip() +
  ggtitle("Cryptomonedas con mayor valuacion en las ultimas 24hs") +
  xlab("Crypto") + ylab("Evolucion") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 15),
        axis.title.x = element_text(face = "bold", size =  13),
        axis.title.y = element_text(face = "bold", size = 13))