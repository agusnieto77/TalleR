
# Script ------------------------------------------------------------------

#download.file('https://raw.githubusercontent.com/agusnieto77/TalleR/main/scripts/ejercicios/ejercicio06.R', destfile = './ejercicio06.R')

# Instalación y activación de paquetes ------------------------------------
#
# instalamos los paquetes solo si no los tenemos instalados 
# lista de paquetes requeridos para correr el script
paquetes_a_instalar <- c("tidyverse", "quanteda", "textreuse", "lubridate", "caret","seededlda","e1071",
                         "tidytext", "udpipe", "spacyr", "tm", "quanteda.textmodels","randomForest","ROCR")

# lista de paquetes faltantes
paquetes_faltantes <- paquetes_a_instalar[!(paquetes_a_instalar %in% installed.packages()[,"Package"])]

# orden para instalar solo los paquetes faltantes 
if(length(paquetes_faltantes)) install.packages(paquetes_faltantes)

# activamos los paquetes
require(tidyverse)           # para activar varios paquetes (gglopt2, dplyr, etc.)
require(quanteda)            # para corpus y matrices texto~documento
require(quanteda.textmodels) # para modelos de escala y clasificadores sobre objetos matriciales dispersos que representan datos textuales en forma de una matriz de características de documento
require(seededlda)           # para implementar el seeded-LDA en el modelado de temas semi-supervisados usando quanteda
require(randomForest)        # para clasificación y regresión basadas en un bosque de árboles con entradas aleatorias
require(caret)               # para agilizar el proceso de entrenamiento del modelo para problemas complejos de regresión y clasificación
require(textreuse)           # para comparar documentos
require(lubridate)           # para series temporales
require(tidytext)            # para tokenizar
require(udpipe)              # para lematizar
require(spacyr)              # para lematizar
require(ROCR)                # para curva ROC
require(tm)                  # para corpus y matrices texto~documento
require(e1071)

# Cargamos las notas ------------------------------------------------------

# cargamos la base 1
base_lc_notas01 <- read.csv("https://estudiosmaritimossociales.org/Data_TalleR/muestra_etiquetada.csv", 
                            sep = ';', fileEncoding="UTF-8-BOM") %>% 
  mutate(id = row_number(), .before = fecha)

# cargamos la base 2
base_lc_notas02 <- read.csv("https://estudiosmaritimossociales.org/Data_TalleR/muestra_etiquetada.csv", 
                            sep = ';', fileEncoding="UTF-8-BOM") %>% 
  mutate(id = c(1:100,201:248), .before = fecha)

# vemos su estructura
glimpse(base_lc_notas02) 

# unificamos las dos bases
(base_lc_notas <- rbind(base_lc_notas01,base_lc_notas02) %>% mutate(fecha = as.Date(fecha)) %>% arrange(desc(fecha)))

# Eliminamos duplicados y resolvemos redundancias -------------------------

# dejamos solo los registros únicos según id
(base_lc_notas <- base_lc_notas %>% distinct(id, .keep_all = T))

# dejamos solo los registros únicos según fecha y nota
(notas_distinct <- base_lc_notas %>% distinct(fecha, nota, .keep_all = T))

# a partir del id vemos qué notas fueron eliminadas 
(notas_iguales <- anti_join(base_lc_notas,notas_distinct,by='id') %>% mutate(clase = 'eliminadas'))

# vemos id + nota
(notas_comparadas <- notas_iguales[,c(1,4)] %>% rename(id_i=id) %>% 
    left_join(base_lc_notas[,c(1,4)], by='nota') %>% filter(id_i != id))

# eliminamos las notas que tienen 450 caracteres o menos
# primero vemos qué notas tienen menos de 451 caracteres
notas_distinct %>% filter(nchar(nota) <= 450)

# las imprimimos en pantalla
notas_distinct %>% filter(id_duplicadas == 34 | id_duplicadas == 61) %>% .[,4]

# luego las eliminamos y nos quedamos con las que tienen 451 caracteres o más
(base_lc_notas <- notas_distinct %>% filter(nchar(nota) >= 450))

# eliminamos los objetos que no usamos 
rm(base_lc_notas01,base_lc_notas02,notas_distinct,notas_iguales, notas_comparadas,paquetes_a_instalar,paquetes_faltantes)

# transformamos el data.frame a tibble
base_lc_notas <- as_tibble(base_lc_notas)

# modificamos los id
(base_lc_notas <- base_lc_notas %>% mutate(id = row_number()))

# comparamos las notas para detectar similitudes con el objetivo de borrar las notas repetidas
# Generar una función MinHash 
# https://es.wikipedia.org/wiki/MinHash
# https://towardsdatascience.com/understanding-locality-sensitive-hashing-49f6d1f6134
# https://skeptric.com/minhash-lsh/
# http://snap.stanford.edu/class/cs246-2017/slides/LSH-1.pdf
(minhash <- minhash_generator(n = 120, seed = 9234))

# Creamos un corpus_minhash con la función TextReuseCorpus()
# Esta clase (TextReuseCorpus) contiene el texto de un documento y sus metadatos. 
# Cuando se carga el documento, el texto también se tokeniza. 
# A continuación, esos tokens se procesan mediante una función hash. 
# De forma predeterminada, los hashes se conservan y los tokens se descartan, 
# ya que usar solo hashes da como resultado un ahorro de memoria significativo
(corpus_minhash <- TextReuseCorpus(text = base_lc_notas$nota,
                       tokenizer = tokenize_ngrams, n = 7,
                       minhash_func = minhash))

# ahora identificamos las coincidencias con la función lsh()
# Locality Sensitive Hashing (LSH) descubre rápidamente las coincidencias potenciales entre un corpus de documentos, 
# de modo que sólo se pueden comparar los pares probables.
# Calculamos las coincidencias potenciales,
(cubo_lsh <- lsh(x = corpus_minhash, bands = 20, progress = FALSE))

# extraemos los candidatos con la función lsh_candidates(),
(pares_candidatxs_lsh <- lsh_candidates(cubo_lsh))

# aplicamos una función de comparación sobre esos candidatos.
(scores <- lsh_compare(pares_candidatxs_lsh, corpus_minhash, jaccard_similarity, progress = FALSE))

# identificamos los artículos que teniendo un id único contienen contenido repetido
(scores_rep <- scores %>% 
  mutate(a2 = as.integer(str_remove(a,'doc-')), 
         b2 = as.integer(str_remove(b,'doc-')),
         dif = sqrt((a2-b2)^2)) %>% arrange(desc(score)))

# generamos una tabla con pares de id's 
(scores_rep_for_anti_join <- scores_rep %>% select(b2,score,a2) %>% rename(id = b2, id_par = a2))

# seleccionamos los id's de artículos con contenido repetido que aparecen en segundo lugar para hacer un anti_join
(notas_id_out <- scores_rep_for_anti_join %>% select(id) %>% distinct())

# hacemos una tabla de notas con contenido repetido según el algoritmo mishash
(par_notas_rep <- scores_rep_for_anti_join %>% 
    left_join(base_lc_notas[,c(1,4)], by = c('id' = 'id')) %>% rename(nota_id = nota) %>% 
    left_join(base_lc_notas[,c(1,4)], by = c('id_par' = 'id')) %>% rename(nota_id_par = nota))

# nos quedamos con notas únicas 
(base_lc_notas <-  base_lc_notas %>% anti_join(notas_id_out))

# modificamos los id's
(base_lc_notas <- base_lc_notas %>% mutate(id = row_number()))

# eliminamos los objetos que no usamos 
rm(minhash,scores_rep,scores,pares_candidatxs_lsh,notas_id_out,cubo_lsh,
   corpus_minhash,par_notas_rep,scores_rep_for_anti_join)

# ahora nos vamos a ocupar de las notas que no son duplicadas pero reiteran información sobre un mismo evento
# volvemos a aplicar la función minhash para detectar similitudes,
(minhash <- minhash_generator(n = 120, seed = 9234))

# creamos un corpus minhash,
(corpus_minhash <- TextReuseCorpus(text = base_lc_notas$nota,
                                   tokenizer = tokenize_ngrams, n = 4, # cambiamos el n_grams
                                   minhash_func = minhash))

# Calculamos las coincidencias potenciales con la función Locality Sensitive Hashing (LSH),
(cubo_lsh <- lsh(x = corpus_minhash, bands = 120, progress = FALSE)) # cambiamos el n de bands
# El número de bands (filas) que se utilizará para el hashing sensible a la localidad. 
# El número de hashes (120) en los documentos del corpus debe ser divisible por el número de filas (120).

# extraemos los candidatos con la función lsh_candidates(),
(pares_candidatxs_lsh <- lsh_candidates(cubo_lsh))

# aplicamos una función de comparación sobre esos candidatos.
(scores <- lsh_compare(pares_candidatxs_lsh, corpus_minhash, jaccard_similarity, progress = FALSE))

# identificamos los artículos que teniendo un id único contienen contenido repetido
(scores_rep <- scores %>% 
    mutate(a2 = as.integer(str_remove(a,'doc-')), 
           b2 = as.integer(str_remove(b,'doc-')),
           dif = sqrt((a2-b2)^2)) %>% arrange(desc(score)) %>% 
    filter(dif < 2))

# generamos una tabla con pares de id's
(scores_rep_join <- scores_rep %>% select(b2,score,a2) %>% rename(id = b2, id_par = a2))

# incorporamos las fechas para calcular la distancia en días entre nota y nota
(scores_rep_join_fechas <- scores_rep_join %>% left_join(base_lc_notas[,1:2], by = c('id' = 'id')) %>% 
    rename(fecha_id = fecha) %>% left_join(base_lc_notas[,1:2], by = c('id_par' = 'id')) %>% 
    rename(fecha_id_par = fecha) %>% mutate(dif_fecha = fecha_id-fecha_id_par) %>% 
    mutate(dif_fecha = as.numeric(dif_fecha)) %>% mutate(dif_fecha = sqrt(dif_fecha^2)))

# nos quedamos con aquellos pares de notas que no tienen más de 1 día de distancia
(scores_rep_id <- scores_rep_join_fechas %>% filter(dif_fecha < 2))

# hacemos una tabla de notas con contenido compartido según el algoritmo mishash
(par_notas_red <- scores_rep_id %>% 
    left_join(base_lc_notas[,c(1,4)], by = c('id' = 'id')) %>% rename(nota_id = nota) %>% 
    left_join(base_lc_notas[,c(1,4)], by = c('id_par' = 'id')) %>% rename(nota_id_par = nota))

# vemos el contenido de los pares de notas
par_notas_red[,7:8]

# seleccionamos los id's de artículos con contenido compartido que aparecen en segundo lugar
(notas_id_red <- par_notas_red %>% select(id) %>% distinct())

# nos quedamos con notas únicas 
(base_lc_notas_unicas <-  base_lc_notas %>% select(-duplicada) %>% anti_join(notas_id_red))

# comprobamos que no hay duplicas según la variable id_duplicadas
as.vector(as_vector(base_lc_notas_unicas %>% count(id_duplicadas) %>% 
                      summarise(sum(n)))) == length(base_lc_notas_unicas$id_duplicadas)

# creamos una nueva columna con las notas de contenido similar que fueron eliminadas 
(base_lc_notas_unicas <- base_lc_notas_unicas %>% 
    left_join(par_notas_red[,c(3,7)], by =c('id' = 'id_par')) %>% 
  rename(nota_dupli = nota_id) %>% select(id,fecha,portal,nota,nota_dupli))

# transformamos los NA's en una cadena de caracteres vacía
base_lc_notas_unicas[is.na(base_lc_notas_unicas)] <- ''

# vemos el resultado
base_lc_notas_unicas

# ahora creamos una nueva columna que una el contenido de las notas de ambas columnas
(base_lc_notas_unicas <- base_lc_notas_unicas %>% 
  unite(mas_notas, nota:nota_dupli, sep = ' [NUEVA NOTA]> ', remove = FALSE) %>% 
  mutate(mas_notas = str_replace_all(mas_notas,'..NUEVA NOTA...$','')) %>% 
  left_join(base_lc_notas[,c(1,5)]) %>% select(id,fecha,portal,nota,mas_notas,clase))

# eliminamos los objetos que no usamos 
rm(minhash,scores_rep,scores,pares_candidatxs_lsh,notas_id_red,cubo_lsh,corpus_minhash,
   par_notas_red,scores_rep_id,base_lc_notas,scores_rep_join,scores_rep_join_fechas)

# actualizamos el id de notas y contamos las palabras
(base_lc_notas_unicas <- base_lc_notas_unicas %>% arrange(desc(fecha)) %>% 
  mutate(id          = row_number(),
         n_words_n   = sapply(strsplit(nota, " "), length),
         n_words_m_n = sapply(strsplit(mas_notas, " "), length),
         más_info    = ifelse((n_words_m_n-n_words_n) != 0, 'SI', 'NO')))

# Resumen del contenido de las notas --------------------------------------

# nos quedamos con las columnas id y notas
(solo_id_y_notas <- base_lc_notas_unicas %>% select(id,mas_notas))

# tokenizamos y normalizamos las notas
(notas_norm <- solo_id_y_notas %>% tidytext::unnest_tokens(palabras,mas_notas) %>% 
  filter(!str_detect(palabras, '[[:punct:]]')) %>% filter(!str_detect(palabras, '[[0-9]]')) %>% 
  anti_join(tibble(palabras = c(tm::stopwords(kind='es'),'mar','plata','buenos','aires','general',
                                'pueyrredon','pueyrredón','años','año','anos','ano','ciudad',
                                'dos','además','provincia','así','tres','sólo','mismo','mismos',
                                'parte','ser','según','días','vez','luego','lugar','ayer','hoy','dijo',
                                'tras','tres','mientras','después','cada','mismo','hora','horas',
                                'día','pasado','hacer','local','explicó','semana','mañana','junto',
                                'solo','puede','través','momento','mientras','aunque','sino','señaló',
                                'aseguró','julio','carlos','último','ver','meses','agregó','respecto',
                                'primer','misma','hacia','siempre'
                                ))) %>% 
  filter(nchar(palabras) > 2) %>% group_by(id) %>% 
  summarise(nota_norm = paste0(palabras, collapse = ' ')) %>% 
  ungroup() %>% full_join(base_lc_notas_unicas) %>% 
  select(id, fecha, portal, nota, mas_notas, nota_norm, clase))

# TOKENS
# ahora realizaremos una selección de palabras clave por nota
(notas_norm_keywords <- notas_norm %>% select(id,nota,nota_norm) %>% 
  unnest_tokens(palabras,nota_norm, drop = FALSE) %>% group_by(id,nota_norm) %>% count(palabras) %>% 
  arrange(id,desc(n)) %>% filter(n > 1) %>% slice_max(order_by = n, n = 10) %>% 
  summarise(keywords = paste0('| ', palabras, collapse = ' ')) %>% select(id,keywords) %>% 
  ungroup() %>% full_join(notas_norm, by = 'id') %>% 
  select(id, fecha, portal, nota, mas_notas, nota_norm, keywords,clase))

# LEMAS
# lematizamos con udpipe
# descargamos el modelo en español
es_model <- udpipe_download_model(language = "spanish")

# lo cargamos
es_model <- udpipe_load_model(es_model$file_model)

# lematizamos el listado de palabras
lemmas_udpipe <- udpipe_annotate(es_model, x = iconv(notas_norm_keywords$nota, to = 'UTF-8')) # lematización con tildes

# lo transformamos en data.frame
(lemmas_udpipe <- as.data.frame(lemmas_udpipe))

# hacemos una selección de variables 
(lemmas_udpipe <- lemmas_udpipe %>% select(doc_id,paragraph_id,sentence_id,token_id, token,lemma,upos,feats) %>% 
    mutate(id = as.integer(str_remove_all(doc_id,'doc')), .before = doc_id) %>% select(-doc_id) %>% as_tibble())

# guardamos las notas lemmatizadas
#saveRDS(lemmas_udpipe,'./data/notas_lemmas.rds')

# ahora realizaremos una selección de palabras clave por nota
(notas_norm_key_words_lemmas <- lemmas_udpipe %>% select(id,lemma) %>% 
    filter(!str_detect(lemma, '[[:punct:]]')) %>% filter(!str_detect(lemma, '[[0-9]]')) %>% 
    anti_join(tibble(lemma = c(tm::stopwords(kind='es'),'mar','plata','buenos','aires','general',
                                  'pueyrredon','pueyrredón','años','año','anos','ano','ciudad',
                                  'dos','además','provincia','así','tres','sólo','mismo','mismos',
                                  'parte','ser','según','días','vez','luego','lugar','ayer','hoy','dijo',
                                  'tras','tres','mientras','después','cada','mismo','hora','horas',
                                  'día','pasado','hacer','local','explicó','semana','mañana','junto',
                                  'solo','puede','través','momento','mientras','aunque','sino','señaló',
                                  'aseguró','julio','carlos','último','ver','meses','agregó','respecto',
                                  'primer','misma','hacia','siempre','|'))) %>% 
    group_by(id) %>% count(lemma) %>% 
    arrange(id,desc(n)) %>% filter(n > 1) %>% slice_max(order_by = n, n = 10) %>% 
    summarise(keylemmas = paste0('| ', lemma, collapse = ' ')) %>% select(id,keylemmas) %>% 
    ungroup() %>% full_join(notas_norm_keywords, by = 'id') %>% 
    select(id, fecha, portal, nota, mas_notas, nota_norm, keywords, keylemmas,clase) %>% 
    mutate(keylemmas = str_to_lower(keylemmas))
  )

# ENTITY
# con spacyR identificamos entidades
# creamos el corpus de textos
(corpus_notas <- corpus(notas_norm_key_words_lemmas$nota,
                      docnames = notas_norm_key_words_lemmas$id))

# spacy_install()
# spacy_finalize()

# bajamos el modelo en español
# spacy_download_langmodel("es_core_news_md")

# cargamos el modelo es
spacy_initialize(model = "es_core_news_md")

# analizamos con spacyR las notas
(corpus_notas_spacyR <- spacy_parse(corpus_notas, 
            pos = TRUE,
            tag = FALSE,
            lemma = TRUE,
            entity = TRUE,
            dependency = TRUE,
            nounphrase = FALSE,
            multithread = FALSE) %>% 
    as_tibble() %>% select(-head_token_id))

# guardamos la base de datos devuelta por spacyR
# saveRDS(corpus_notas_spacyR,'./data/corpus_notas_spacyR.rds')

# ahora realizaremos una selección de entidades por nota
(notas_norm_key_words_lemmas_entities <- corpus_notas_spacyR %>% select(doc_id,token,entity) %>% 
    mutate(id = as.integer(doc_id), .before = doc_id) %>% select(-doc_id) %>% 
    filter(entity != "" & 
          token != "El" & token != "Los" & token != "La" & 
          token != "Las" & token != "De" & token != "LA" & token != "En" &
          token != "Capital" & token != "CAPITAL" & token != "Mar" & 
          token != "Plata" & token != "Por" & token != "Que" & token != "Con" &
          token != "Este" & token != "Nº" & token != "Según" & token != "Hay" &
          token != "Para" & token != "A" & token != "Al" & token != "No" &
          token != "Una" & token != "Si" & token != "Hoy" & token != "Pero" &
          token != "Allí" & token != "Ante" & token != "Ayer" & token != "Está" &
          token != "Esta" & token != "Lo" & token != "Uno" & token != "Así" &
          token != "Esa" & token != "Eso" & token != "Desde" & token != "MdP" &
          token != "Paro" & token != ",Según" & token != "“Habrá" & token != "2016).Por" &
          token != "2017.Desde" & token != "5º.En" & token != "Acá" & 
          token != "AgradecimientosLuego" & token != "Ahora" & token != "Amparo-confl" & 
          token != "AnsesManifestantes" & token != "actividades.-Judiciales" &
          token != "Añade" & token != "añoPor" & token != "Bomberos).Además" & 
          token != "Boquerón”" & token != "SMN)anunció" & token != "Corresponsal).-" &
          token != "Brasil).Buenos" & token != "C" & token != "“Cada" & token != "Cambios" &
          token != "Cómo" & token != "DAC.\"El" & token != "“EN" & token != "IAMC.Los" & 
          token != "Martín.#NoALaReformaPrevisionalMañana" & token != "LU6.Según" &
          token != "Bomberos).Además") %>% 
    filter(str_detect(token,'[[A-Z]]')) %>% 
    group_by(id) %>% summarise(entities = paste0('| ', token, collapse = ' ')) %>% select(id,entities) %>% 
    ungroup() %>% full_join(notas_norm_key_words_lemmas, by = 'id') %>% 
    select(id, fecha, portal, nota, mas_notas, nota_norm, keywords, keylemmas, entities, clase)
)

# ahora realizaremos una selección de acciones por nota
(notas_norm_key_words_lemmas_entities_acc <- corpus_notas_spacyR %>% select(doc_id,token,pos) %>% 
    mutate(id = as.integer(doc_id), .before = doc_id) %>% select(-doc_id) %>% filter(pos == 'VERB' | pos == 'NOUN') %>% 
    group_by(id) %>% summarise(acciones = paste0('| ', token, collapse = ' ')) %>% select(id,acciones) %>% 
    ungroup() %>% full_join(notas_norm_key_words_lemmas_entities, by = 'id') %>% 
    select(id, fecha, portal, nota, mas_notas, nota_norm, keywords, keylemmas, entities, acciones, clase)
)

# eliminamos los objetos que no usamos 
rm(base_lc_notas_unicas,corpus_notas_spacyR,es_model,lemmas_udpipe,notas_norm,notas_norm_key_words_lemmas,
   notas_norm_key_words_lemmas_entities,notas_norm_keywords,solo_id_y_notas,corpus_notas)

# Clasificación de las notas según refieran o no a conflictos -------------

# Clasificación haciendo uso de diccionarios
# creamos un diccionario con palabras referidas a conflictos
(dicc_breve <- c('protesta','conflict','huelg','corte de ca','corte de ru','plan de lucha','movilización','piqueter','medida de fuerza',
                 'piquete','paro de','medidas de fuerza','reclaman','reclamo','manifestantes','asambleas','paralizar','manifestación'))

# clasificamos las notas en función de la presencia o ausencia de palabras del diccionario 
(notas_clas <- notas_norm_key_words_lemmas_entities_acc %>% 
  mutate(clase_nota_dicc = ifelse(str_detect(str_to_lower(nota), paste0(dicc_breve, collapse = '|')), 'conflicto', 'no_conflicto'),
         correspondencia = ifelse(clase == clase_nota_dicc, 'SI', 'NO')))
# vemos su rendimiento
# absoluto
table(notas_clas$correspondencia)

# porcentaje
prop.table(table(notas_clas$correspondencia))

# matriz
table(notas_clas$clase, notas_clas$clase_nota_dicc, dnn = c("Etiq Manual", "Etiq Dicc"))

# clasificamos las notas en función de la cantidad de palabras del diccionario en las notas
(notas_clas_2 <- notas_norm_key_words_lemmas_entities_acc %>% 
    mutate(frec_pal_confli = str_count(str_to_lower(nota), paste0(dicc_breve, collapse = '|')),
           clase_nota_dicc = ifelse(frec_pal_confli > 1, 'conflicto', 'no_conflicto'),
           correspondencia = ifelse(clase == clase_nota_dicc, 'SI', 'NO')))

# vemos su rendimiento
# absoluto
table(notas_clas_2$correspondencia)

# porcentaje
prop.table(table(notas_clas_2$correspondencia))

# matriz
table(notas_clas_2$clase, notas_clas_2$clase_nota_dicc, dnn = c("Etiq Manual", "Etiq Dicc"))

### Clasificador bayesiano ingenuo (supervisado) ####
# Naive Bayes es un modelo supervisado que se suele utilizar para clasificar documentos en dos o más categorías. Entrenamos al clasificador 
# usando etiquetas de clase adjuntas a los documentos y predecimos la(s) clase(s) más probables de nuevos documentos sin etiquetar.
# creamos el corpus
(corpus_notas_norm <- corpus(notas_norm_key_words_lemmas_entities_acc$nota_norm,
                        docnames = notas_norm_key_words_lemmas_entities_acc$id))

# creamos la variable id
corpus_notas_norm$id    <- notas_norm_key_words_lemmas_entities_acc$id

# creamos la variable clase
corpus_notas_norm$clase <- notas_norm_key_words_lemmas_entities_acc$clase

# imprimimos las variables creadas
docvars(corpus_notas_norm)

# imprimimos un resumen del contenido del corpus
summary(corpus_notas_norm, 5)

# generar 90 números aleatorios sin reemplazo
set.seed(123)
(id_entrenamiento <- sample(1:134, 90, replace = FALSE))

# tokenizamos las notas
(tokens_notas <- quanteda::tokens(corpus_notas_norm, remove_punct = TRUE, remove_number = TRUE) %>% 
  tokens_remove(pattern = c('lunes','martes','miércoles','jueves','viernes','sábado','domingo')) %>% 
  tokens_wordstem())

# Creamos una matriz documento-términos
(dfm_notas <- dfm(tokens_notas))

# creamos el conjunto de entrenamiento
(dfm_entrenamiento <- dfm_subset(dfm_notas, id %in% id_entrenamiento))

# creamos el conjunto de testeo
(dfm_testeo <- dfm_subset(dfm_notas, !id %in% id_entrenamiento))

# entrenamos al clasificador bayesiano ingenuo usando textmodel_nb()
(entr_mod_nb <- textmodel_nb(dfm_entrenamiento, dfm_entrenamiento$clase))

# imprimimos un resumen del modelo nb
summary(entr_mod_nb)

# Naive Bayes solo puede tener en cuenta las características que ocurren tanto en el conjunto de entrenamiento como en el conjunto de prueba,
# por eso usamos la función dfm_match()
# Esta función hace coincidir el conjunto de características de un dfm con un vector especificado de nombres de características. 
# Se incluirán las características existentes en x para las que haya una coincidencia exacta con un elemento de features. 
# Cualquier característica en x que no sea features se descartará, y cualquier nombre de característica especificado en features 
# pero que no se encuentre en x se añadirá con todos los recuentos de cero.
(dfm_matched <- dfm_match(dfm_testeo, features = featnames(dfm_entrenamiento)))

# ahora inspeccionamos el rendimiento del moldeo entrenado 
# creamos un vector con las clases del etiquetado manual
(etiq_manual <- dfm_matched$clase)

# ahora aplicamos el modelo entrenado sobre los datos de testeo
(etiq_nb     <- predict(entr_mod_nb, newdata = dfm_matched))

# creamos la tabla de clasificación 
(tabla_clasificacion <- table(etiq_manual, etiq_nb)) # solo tres falsos positivos

# utilizamos la función confusionMatrix() del paquete caret para evaluar el rendimiento de la clasificación.
caret::confusionMatrix(tabla_clasificacion, mode = "everything")

# repetimos los paso para recuperar las 134 etiquetas
# aplicamos dfm_match()
(dfm_matched_2 <- dfm_match(dfm_notas, features = featnames(dfm_entrenamiento)))

# creamos un vector con las clases del etiquetado manual
(etiq_manual <- dfm_matched_2$clase)

# ahora aplicamos el modelo entrenado sobre todos los datos
(etiq_nb_2     <- predict(entr_mod_nb, newdata = dfm_matched_2))

# creamos la tabla de clasificación 
(tabla_clasificacion <- table(etiq_manual, etiq_nb_2))

# incorporamos la predicción como nueva variable en la base
(notas_clas_3 <- notas_norm_key_words_lemmas_entities_acc %>% 
    mutate(clase_nb = etiq_nb_2,
           correspondencia = ifelse(clase == clase_nb, 'SI', 'NO')))

# dejo algunas referencias:
# Jurafsky, Daniel, and James H. Martin. 2018. Speech and Language Processing. An Introduction to Natural Language Processing, 
# Computational Linguistics, and Speech Recognition. Draft of 3rd edition, September 23, 2018 (Chapter 4).

### ahora probamos con el algoritmo Random Forest ####
# preparamos la base de datos
# creamos un listado con las palabras de menor frecuencia 
(min_freq <- notas_norm_key_words_lemmas_entities_acc %>% unnest_tokens(palabras,nota_norm) %>% select(id,palabras,clase) %>%
    anti_join(tibble(palabras = c('lunes','martes','miércoles','jueves','viernes','sábado','domingo'))) %>% 
    count(palabras) %>% arrange(desc(n)) %>% filter(n < 14) %>% select(1))

# preparamos el corpus para aplicar la función randomForest
(corpus_rf <- notas_norm_key_words_lemmas_entities_acc %>% unnest_tokens(palabras,nota_norm) %>% select(id,palabras,clase) %>%
    anti_join(tibble(palabras = c('lunes','martes','miércoles','jueves','viernes','sábado','domingo'))) %>% 
    anti_join(min_freq) %>% group_by(id,clase) %>% count(palabras) %>% spread(palabras,n) %>% ungroup() %>% as.data.frame())

# reemplazamos los NA's por 0
corpus_rf[is.na(corpus_rf)] <- 0

# transformamos en factor la variable clase
corpus_rf$clase <- as.factor(corpus_rf$clase)

# definimos una semilla y extraemos los id de entrenamiento 
set.seed(2021)
id_entrenamiento <- createDataPartition(corpus_rf$clase, p = 0.7, list = F)

# entrenamos el modelo
(mod <- randomForest(clase ~ ., corpus_rf[id_entrenamiento,],
                     ntree = 500,
                     keep.forest = TRUE))

# hacemos la predicción 
pred <- predict(mod, corpus_rf[-id_entrenamiento,], type = "class")

# vemos su rendimiento
table(corpus_rf[-id_entrenamiento,"clase"] %>% as_vector(), pred, dnn= c("Actual", "Predicho"))

# visualizamos su rendimiento con un curva roc
probs <- predict(mod, corpus_rf[-id_entrenamiento,], type = "prob")

pred <- prediction(probs[,2], corpus_rf[-id_entrenamiento,"clase"])

perf <- performance(pred, "tpr", "fpr")

# imprimimos el plot
plot(perf, xlab = 'Razón de verosimilitud negativa', ylab = 'Razón de verosimilitud positiva',
           main = 'Random-Forest', col = 'red')

# Clasificamos con modelado de tópicos (no supervisado) -------------------

### Agrupamiento Jerárquico ####
# creamos el corpus
(corpus_us <- Corpus(VectorSource(notas_norm_key_words_lemmas_entities_acc$acciones)))

# lo normalizamos
(corpus_us <- tm_map(corpus_us,removeWords,c('lunes','martes','miércoles','jueves','viernes','sábado','domingo')))

# quitamos los espacios en blanco
(corpus_us <- tm_map(corpus_us,stripWhitespace))

# lo transformamos en una matriz documento-término
(dtm <- DocumentTermMatrix(corpus_us))

# estimamos la TF-IDF (Term Frequency - Inverse Document Frequency)
(dtm_tfi <- weightTfIdf(dtm))

# removemos una parte de los términos
dtm_tfi <- removeSparseTerms(dtm_tfi, 0.999)

# la transformamos en matriz común
dtm_tfi_matrix <- as.matrix(dtm_tfi) 

# estimamos la similitud coseno
# La similitud coseno es una medida de la similitud existente entre dos vectores en un espacio que 
# posee un producto interior con el que se evalúa el valor del coseno del ángulo comprendido entre ellos. 
# Esta función trigonométrica proporciona un valor igual a 1 si el ángulo comprendido es cero, es decir 
# si ambos vectores apuntan a un mismo lugar.
dist_cos <- proxy::dist(dtm_tfi_matrix, method = "cosine")

# aplicamos la función hclust() para análisis jerárquico de conglomerados
Hierarchical_Clustering <- hclust(dist_cos, method = "ward.D2") 

# determinamos dos grupos de ramificaciones
Hierarchical_Clustering_2 <- cutree(Hierarchical_Clustering, k = 2) 

# escalamos los datos como putos en un plano.
# Escalamiento Multidimensional Clásico (MDS)
puntos <- cmdscale(dist_cos, k = 2) 

# vizualizamos
plot(puntos, main = 'Agrupamiento Jerárquico', col = as.factor(Hierarchical_Clustering_2), 
     mai = c(0, 0, 0, 0), mar = c(0, 0, 0, 0),  
     xaxt = 'n', yaxt = 'n', xlab = '', ylab = '')

# incorporamos la predicción como nueva variable en la base
(notas_clas_4 <- notas_norm_key_words_lemmas_entities_acc %>% 
    mutate(clase_sh = as.vector(Hierarchical_Clustering_2),
           clase_sh = ifelse(clase_sh == 2, 'no_conflicto', 'conflicto'),
           correspondencia = ifelse(clase == clase_sh, 'SI', 'NO')))

# vemos su rendimiento
# absoluto
table(notas_clas_4$correspondencia)

# porcentaje
prop.table(table(notas_clas_4$correspondencia))

# matriz 
table(notas_clas_4$clase, notas_clas_4$clase_sh, dnn = c("Etiq Manual", "Etiq cluster"))

### Modelado de tópicos ####
# creamos un corpus
(corpus_notas_norm <- corpus(notas_norm_key_words_lemmas_entities_acc$nota_norm,
                             docnames = notas_norm_key_words_lemmas_entities_acc$id))

# creamos la variable id
corpus_notas_norm$id    <- notas_norm_key_words_lemmas_entities_acc$id

# creamos la variable clase
corpus_notas_norm$clase <- notas_norm_key_words_lemmas_entities_acc$clase

# imprimimos las variables creadas
docvars(corpus_notas_norm)

# imprimimos un resumen del contenido del corpus
summary(corpus_notas_norm, 5)

# tokenizamos las notas y, después de eliminar las palabras vacías y la puntuación, nos quedamos con el 5% de los términos más frecuentes y
# nos quedamos con los términos que aparecen en menos del 10% de todos los documentos,
# esto para centrarnos en los rasgos comunes pero distintivos.
(tokens_notas <- quanteda::tokens(corpus_notas_norm, remove_punct = TRUE, remove_number = TRUE, remove_symbol = TRUE) %>% 
    tokens_remove(pattern = c('lunes','martes','miércoles','jueves','viernes','sábado','domingo')))

# creamos la matriz documento-término
(dfm_notas <- dfm(tokens_notas) %>% 
  dfm_trim(min_termfreq = 0.7, termfreq_type = "quantile",
           max_docfreq = 0.09, docfreq_type = "prop"))

# imprimimos un resumen del contenido de la matriz
summary(dfm_notas)

# creamos el modelo de tópicos
set.seed(890)
(tm_lda_notas <- textmodel_lda(dfm_notas, k = 2))

# guardamos el modelo
#saveRDS(tm_lda_notas,'tm_lda_notas_seed_123.rds')
#saveRDS(tm_lda_notas,'tm_lda_notas_seed_678.rds')
#saveRDS(tm_lda_notas,'tm_lda_notas_seed_890.rds')

# imprimimos los primeros 30 términos de los tópicos
terms(tm_lda_notas, 30)

# asignar los tópicos como una nueva variable a nivel de documento
dfm_notas$topico <- topics(tm_lda_notas)

# tabla de frecuencia de los tópicos
table(dfm_notas$topico)

# incorporamos la predicción como nueva variable en la base
(notas_clas_5 <- notas_norm_key_words_lemmas_entities_acc %>% 
    mutate(clase_tm = dfm_notas$topico,
           clase_tm = ifelse(clase_tm == 'topic1', 'no_conflicto', 'conflicto'),
           correspondencia = ifelse(clase == clase_tm, 'SI', 'NO')))

# vemos su rendimiento
# absoluto
table(notas_clas_5$correspondencia)

# porcentaje
prop.table(table(notas_clas_5$correspondencia))

# matriz
table(notas_clas_5$clase, notas_clas_5$clase_tm, dnn = c("Etiq Manual", "Etiq tópico"))

# Análisis de conflictividad con diccionarios -----------------------------

# aquí vamos a desarrollar un análisis completo de un corpus textual 
# referido a los puertos pesqueros argentinos 
# para explorar la conflictividad en el sector

download.file('https://raw.githubusercontent.com/agusnieto77/TalleR/main/scripts/ejercicios/ejercicio07.R', destfile = './ejercicio07.R')

# Referencias de interés --------------------------------------------------

# Blei, David M., Andrew Y. Ng, and Michael I. Jordan. 2003. “Latent Dirichlet Allocation.” The Journal of Machine Learning Research 3(1): 993-1022.
# Lu, B., Ott, M., Cardie, C., & Tsou, B. K. 2011. “Multi-aspect sentiment analysis with topic models". Proceeding of the 2011 IEEE 11th International Conference on Data Mining Workshops, 81–88.
# Documentación
# textreuse: https://cran.r-project.org/web/packages/textreuse/vignettes/textreuse-introduction.html
# r-for-newspaper-data: https://bookdown.org/yann_ryan/r-for-newspaper-data/detecting-text-reuse-in-newspaper-articles-.html
