# Scraping
# Instalar los paquetes que no tengan instalados
# Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------

require(dplyr)
require(purrr)
require(rvest)
require(tidyr)
require(tibble)
require(stringr)
require(quanteda)            # para corpus y matrices texto~documento
require(quanteda.textmodels) # para modelos de escala y clasificadores sobre objetos matriciales dispersos que representan datos textuales en forma de una matriz de características de documento
require(seededlda)           # para implementar el seeded-LDA en el modelado de temas semi-supervisados usando quanteda
require(lubridate)           # para series temporales
require(ROCR)                # para curva ROC
require(tm)                  # para corpus y matrices texto~documento

# Creamos la función para raspar cuyo nombre será 'scraping_links()' ---------------------
# Links

ln_links <- c('https://www.lanacion.com.ar/espectaculos/',
              'https://www.lanacion.com.ar/deportes/',
              'https://www.lanacion.com.ar/politica/',
              'https://www.lanacion.com.ar/economia/comercio-exterior/')

scraping_links <- function(pag_web, tag_link) {   # abro función para raspado web y le asigno un nombre: scraping_links.
  
  read_html(pag_web) %>%                   # llamo a la función read_html() para obtener el contenido de la página.
    
    html_elements(tag_link) %>%            # llamo a la función html_elements() y especifico las etiquetas de los títulos 
    
    html_attr("href") %>%                  # llamo a la función html_attr() para especificar el formato 'chr' del título.
    
    url_absolute(pag_web) %>%              # llamo a la función absolute() para completar las URLs relativas
    
    as_tibble() %>%                        # llamo a la función as_tibble() para transforma el vector en tabla
    
    rename(link = value)                   # llamo a la función rename() para renombrar la variable 'value'
  
}                                                 # cierro la función para raspado web

# Usamos la función para scrapear los links a las notas de La Nación -------------------------------

(la_nacion_ar_links <- pmap_dfr(list(ln_links,"h2 a"), scraping_links)) # scrapeamos.

# Creamos la función para raspar cuyo nombre será 'scraping_notas()' ---------------------

scraping_notas <- function(pag_web, tag_fecha, tag_titulo, tag_nota) { # abro función para raspado web: scraping_notas().
  
  tibble(                                 # llamo a la función tibble.
    
    fecha =  html_elements(                       # declaro la variable fecha y llamo a la función html_elements().
      
      read_html(pag_web), tag_fecha) %>%   # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) de la fecha. 
      
      html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' de la fecha.
    
    titulo = html_elements(                       # declaro la variable titulo y llamo a la función html_elements().
      
      read_html(pag_web), tag_titulo) %>%  # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) del titulo.  
      
      html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' del título.
    
    nota =  html_elements(                        # declaro la variable nota y llamo a la función html_elements(). 
      
      read_html(pag_web), tag_nota) %>%     # llamo a la función html_elements() y especifico la(s) etiqueta(s) de la nota. 
      
      html_text(),                          # llamo a la función html_text() para especificar el formato 'chr' de la nota.
    
    links = pag_web
    
  )                                               # cierro la función tibble().
  
}                                                 # cierro la función para raspado web.

# Raspamos las notas del periódico La Nación.

(la_nacion_ar <- pmap_dfr(list(la_nacion_ar_links$link,".com-date.--twoxs",".com-title.--threexl",".col-12 p"), scraping_notas) %>% 
  group_by(fecha,titulo,links) %>% 
    summarise(nota = paste0(nota, collapse = '\n')) %>% 
    ungroup() %>% select(fecha, titulo, nota, links)) # scrapeamos.

# Guardamos el objeto 'la_nacion_ar' como objeto .rds
saveRDS(la_nacion_ar, "la_nacion_ar.rds")

# Normalizamos la fecha
la_nacion_ar <- la_nacion_ar %>% mutate(fecha = dmy(fecha))

# Sección = tópico
la_nacion_ar <- la_nacion_ar %>% mutate(topico = case_when(str_detect(links,'economia')~'ECONOMIA',
                                                           str_detect(links, 'politica')~'POLITICA',
                                                           str_detect(links, 'deportes')~'DEPORTE',
                                                           str_detect(links, 'espectaculos')~'ESPECTACULO')) %>% 
  filter(!is.na(topico)) %>% 
  mutate(id = row_number(), .before = fecha)

### Modelado de tópicos ####
# creamos un corpus
(corpus_notas_norm <- corpus(la_nacion_ar$nota,
                             docnames = la_nacion_ar$id))

# creamos la variable id
corpus_notas_norm$id  <- la_nacion_ar$id

# creamos la variable clase
corpus_notas_norm$topico <- la_nacion_ar$topico

# imprimimos las variables creadas
docvars(corpus_notas_norm)

# imprimimos un resumen del contenido del corpus
summary(corpus_notas_norm, 5)

# tokenizamos las notas y, después de eliminar las palabras vacías y la puntuación, nos quedamos con el 5% de los términos más frecuentes y
# nos quedamos con los términos que aparecen en menos del 10% de todos los documentos,
# esto para centrarnos en los rasgos comunes pero distintivos.
(tokens_notas <- quanteda::tokens(corpus_notas_norm, remove_punct = TRUE, remove_number = TRUE, remove_symbol = TRUE) %>% 
    tokens_remove(pattern = c(stopwords("es"), c('lunes','martes','miércoles','jueves','viernes','sábado','domingo'))))

tokens_tolower(tokens_notas)

# creamos la matriz documento-término
(dfm_notas <- dfm(tokens_notas) %>% 
    dfm_trim(min_termfreq = 0.7, termfreq_type = "quantile",
             max_docfreq = 0.09, docfreq_type = "prop"))

# imprimimos un resumen del contenido de la matriz
summary(dfm_notas)

# creamos el modelo de tópicos
set.seed(890)
(tm_lda_notas <- textmodel_lda(dfm_notas, k = 4))

# guardamos el modelo
#saveRDS(tm_lda_notas,'tm_lda_notas_seed_123.rds')
#saveRDS(tm_lda_notas,'tm_lda_notas_seed_678.rds')
#saveRDS(tm_lda_notas,'tm_lda_notas_seed_890.rds')

# imprimimos los primeros 30 términos de los tópicos
terms(tm_lda_notas, 30)

# asignar los tópicos como una nueva variable a nivel de documento
dfm_notas$topico_asignado <- topics(tm_lda_notas)

# tabla de frecuencia de los tópicos
table(dfm_notas$topico_asignado)

# incorporamos la predicción como nueva variable en la base
(notas_clasificadas <- la_nacion_ar %>% 
    mutate(topico_asignado = dfm_notas$topico_asignado) %>% 
    mutate(topico_asignado = case_when(topico_asignado == 'topic1' ~ 'ECONOMIA',
                                       topico_asignado == 'topic2' ~ 'ESPECTACULO',
                                       topico_asignado == 'topic3' ~ 'POLITICA',
                                       topico_asignado == 'topic4' ~ 'DEPORTE')) %>% 
    mutate(correspondencia = ifelse(topico == topico_asignado, 'SI', 'NO')))

# vemos su rendimiento
# absoluto
table(notas_clasificadas$correspondencia)

# porcentaje
prop.table(table(notas_clasificadas$correspondencia))

# matriz
table(notas_clasificadas$topico, notas_clasificadas$topico_asignado, dnn = c("Etiq Manual", "Etiq Automático"))

# Referencias

# https://tutorials.quanteda.io/machine-learning/topicmodel/
# https://quanteda.io/articles/pkgdown/quickstart_es.html
# https://slcladal.github.io/topicmodels.html
# https://www.tidytextmining.com/topicmodeling.html
# https://medium.com/swlh/topic-modeling-in-r-with-tidytext-and-textminer-package-latent-dirichlet-allocation-764f4483be73
# http://www.aic.uva.es/cuentapalabras/topic-modeling.html
# https://content-analysis-with-r.com/6-topic_models.html
# https://sicss.io/2020/materials/day3-text-analysis/topic-modeling/rmarkdown/Topic_Modeling.html
# https://cran.r-project.org/web/packages/stm/vignettes/stmVignette.pdf
# https://pdfs.semanticscholar.org/9e73/f8cd638d74c2b8e9731f5f0ae4a61f56c8bc.pdf
# https://cran.r-project.org/web/packages/BTM/index.html
# https://rpubs.com/chelseyhill/672546
# https://medium.com/data-folks-indonesia/recent-works-in-topic-modeling-56c38da8dfc4

# Herramientas

# https://pitt.libguides.com/textmining/topicmodeling

# Plus

# https://cbail.github.io/textasdata/Text_as_Data.html