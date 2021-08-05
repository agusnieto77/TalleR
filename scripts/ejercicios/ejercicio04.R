# Ejercicio 4
# cargar paquetes
require(tidyverse)
require(lubridate)
require(tidytext)
require(udpipe)
# PRIMERA PARTE
# creamos una base
(Tabla <- tibble(fecha=c('02/02/2021','09/04/2021','02/07/2021','02/07/2021','02/07/2021',NA,NA), 
                 titulo=c('El clima            en Mar del            Plata https://www.lacapitalmdp.com/',
                          'Los    trabajadores        estatales estan            en huelga @lacapitalmdq',
                          '@lacapitalmdq El sindicato docente__ declaró un paro por tiempo indeterminado', 
                          '@lacapitalmdq El sindicato docente__ declaró un paro por tiempo indeterminado', 
                          'El clima            en Mar del            Plata https://www.lacapitalmdp.com/',
                          NA, NA)))
# eliminamos los valores perdidos 
(Tabla <- Tabla %>% filter(!is.na(titulo)))
# eliminamos los duplicados 
(Tabla <- Tabla %>% unique())
# eliminamos el contenido redundante 
(Tabla <- Tabla %>% distinct(titulo, .keep_all = T))
# incorporamos un id
(Tabla <- Tabla %>% mutate(id = row_number(), .before = fecha))
# guardamos la tabla
saveRDS(Tabla,'./Tabla.rds')
# SEGUNDA PARTE
# cargamos la base
Tabla <- readRDS('./Tabla.rds')
# imprimimos en pantalla los títulos
Tabla$titulo
# normalizamos el contenido de los textos
(Tabla$titulo_limpio <- gsub('?(f|ht)tp\\S+', '', Tabla$titulo))    # eliminamos urls
(Tabla$titulo_limpio <- gsub('@\\S*\\s?', '', Tabla$titulo_limpio)) # eliminamos @names y @mails
(Tabla$titulo_limpio <- gsub('__', '', Tabla$titulo_limpio))        # eliminamos un contenido particular 
(Tabla$titulo_limpio <- gsub(' +', ' ', Tabla$titulo_limpio))       # borramos los espacios en blanco repetidos
(Tabla$titulo_limpio <- gsub(' +$', '', Tabla$titulo_limpio))       # borramos los espacios en blanco finales
# imprimimos en pantalla los títulos limpios
Tabla$titulo_limpio
# transformamos la fecha en fecha
(Tabla <- Tabla %>% mutate(fecha = dmy(fecha)))
# guardamos la tabla
saveRDS(Tabla,'./Tabla.rds')
# TERCERA PARTE
# cargamos la base
Tabla <- readRDS('./Tabla.rds')
# tokenizamos
(Tabla <- Tabla %>% tidytext::unnest_tokens(palabras,titulo_limpio, drop = FALSE) %>% select(id,palabras))
# borramos las palabras vacías
(Tabla <- Tabla %>% anti_join(tibble(palabras = c('en','el','un','por','del','los','mar','plata'))))
# guardamos la tabla
saveRDS(Tabla,'./Tabla_tokens.rds')
# CUARTA PARTE
# bajamos el modelo para español 
es_model <- udpipe_download_model(language = "spanish")
# lo activamos 
es_model <- udpipe_load_model(es_model$file_model)
# cargamos la base
Tabla <- readRDS('./Tabla.rds')
# lematizamos
(Tabla_lemas <- udpipe_annotate(es_model, x = iconv(Tabla$titulo_limpio, to = 'UTF-8')))
# lo pasamos a formato data frame
(Tabla_lemas <- as.data.frame(Tabla_lemas) %>% select(doc_id,token,lemma,upos,feats) %>% 
    anti_join(tibble(token = c('en','el','El','un','por','del','Los','de','Mar','Plata'))))
# guardamos la tabla
saveRDS(Tabla_lemas,'./Tabla_lemas.rds')
# QUINTA PARTE
# cargamos la base
Tabla_lemas <- readRDS('./Tabla_lemas.rds')
# armamos un diccionario sobre conflictos
(dicc_conf <- Tabla_lemas %>% filter(doc_id != 'doc1') %>% .[,3])
# rearmamos los títulos con los lemmas
(Tabla_notas <- Tabla_lemas %>% group_by(doc_id) %>% summarise(titulo = paste0(lemma, collapse = ' ')))
# vemos si contiene referencias a conflictos o no
Tabla_notas %>% mutate(p_conf = str_count(titulo, paste0(dicc_conf, collapse = '|')))
# guardamos la tabla
saveRDS(Tabla_notas,'./Tabla_notas.rds')
# bajamos el ejercicio 5
utils::download.file("https://estudiosmaritimossociales.org/ejercicio05.R", "ejercicio05.R")
