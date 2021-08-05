########-----Paquetes--------###########
# instalamos los paquetes si es que ya no los tenemos instalados 
# lista de paquetes requeridos para correr el script
paquetes_a_instalar <- c("tidyverse", "quanteda", "textreuse", "lubridate", 
                         "tidytext", "udpipe", "spacyr", "SnowballC", "tm")
# lista de paquetes faltantes
paquetes_faltantes <- paquetes_a_instalar[!(paquetes_a_instalar %in% installed.packages()[,"Package"])]
# orden para instalar solo los paquetes faltantes 
if(length(paquetes_faltantes)) install.packages(paquetes_faltantes)
# activamos los paquetes
require(tidyverse) # paquete de paquetes (gglopt2, dplyr, etc.)
require(quanteda)  # para corpus y matrices texto~documento
require(textreuse) # para comparar documentos
require(lubridate) # para series temporales
require(tidytext)  # para tokenizar
require(udpipe)    # para lematizar
require(spacyr)    # para lematizar
require(SnowballC) # para stems
require(tm)        # para corpus y matrices texto~documento
##### ---Notas--- #####
# cargamos las notas
base_lc_notas01 <- readRDS(url("https://estudiosmaritimossociales.org/Data_TalleR/muestra_10_lc.rds","rb"))
base_lc_notas02 <- readRDS(url("https://estudiosmaritimossociales.org/Data_TalleR/muestra_10_lc.rds","rb"))
# vemos su estructura
str(base_lc_notas01) # con la función base
glimpse(base_lc_notas02) # muestra lo mismo pero se ve distinto
# unificamos las bases
(base_lc_notas <- rbind(base_lc_notas01,base_lc_notas02) %>% mutate(fecha = dmy(fecha)) %>% arrange(desc(fecha)))
# dejamos solo los registros únicos
(base_lc_notas <- base_lc_notas %>% distinct(id, .keep_all = T))
(notas_distinct <- base_lc_notas %>% distinct(nota, fecha, titulo, .keep_all = T))
# vemos qué notas fueron eliminadas 
(notas_iguales <- anti_join(base_lc_notas,notas_distinct,by='id') %>% mutate(clase = 'eliminadas'))
(notas_comparadas <- notas_iguales[,c(1,5)] %>% rename(id_i=id) %>% left_join(base_lc_notas[,c(1,5)], by='nota'))
# eliminamos las notas con menos de 450 caracteres 
(base_lc_notas <- notas_distinct %>% filter(nchar(nota) >= 450))
# eliminaos los objetos que no usamos 
rm(base_lc_notas01,base_lc_notas02,notas_distinct,notas_iguales, notas_comparadas)
# transformamos el data.frame a tibble
base_lc_notas %>% as_tibble() # 1
base_lc_notas %>% as_tibble   # 2
as_tibble(base_lc_notas)      # 3
base_lc_notas <- as_tibble(base_lc_notas)
# modificamos los id
(base_lc_notas <- base_lc_notas %>% mutate(id = row_number()))
# comparamos las notas para detectar similitudes con el objetivo de borrar las notas repetidas
# Generar una función MinHash (https://es.wikipedia.org/wiki/MinHash)
(minhash <- minhash_generator(n = 111, seed = 235))
# Esta clase (TextReuseCorpus) contiene el texto de un documento y sus metadatos. 
# Cuando se carga el documento, el texto también se tokeniza. 
# A continuación, esos tokens se procesan mediante una función hash. 
# De forma predeterminada, los hashes se conservan y los tokens se descartan, 
# ya que usar solo hashes da como resultado un ahorro de memoria significativo
(corpus_minhash <- TextReuseCorpus(text = base_lc_notas$nota,
                       tokenizer = tokenize_ngrams, n = 4,
                       minhash_func = minhash))
# metadatos
corpus_minhash[1]
# documentos + metadatos
corpus_minhash[[1]]
# contenido documento
corpus_minhash[[1]] %>% .[1]
# tokens documentos
corpus_minhash[[1]] %>% .[2]
# hashes por documento
corpus_minhash[[1]] %>% .[3]
# Función accesoria para leer y escribir componentes de los objetos TextReuseTextDocument y TextReuseCorpus.
hashes(corpus_minhash)
# minhashes por documento
corpus_minhash[[1]] %>% .[4]
# metadatos por documento
corpus_minhash[[1]] %>% .[5]
# Locality Sensitive Hashing (LSH) descubre rápidamente las coincidencias potenciales entre un corpus de documentos, 
# de modo que sólo se pueden comparar los pares probables.
# Calculamos las coincidencias potenciales,
(cubo_lsh <- lsh(x = corpus_minhash, bands = 111, progress = FALSE))
# extraemos los candidatos,
(pares_candidatxs_lsh <- lsh_candidates(cubo_lsh))
# aplicamos una función de comparación solo a esos candidatos.
(scores <- lsh_compare(pares_candidatxs_lsh, corpus_minhash, jaccard_similarity, progress = FALSE))
# identificamos los artículos que teniendo un id único contienen contenido repetido
(scores_rep <- scores %>% 
  mutate(a2 = as.integer(str_remove(a,'doc-')), 
         b2 = as.integer(str_remove(b,'doc-')),
         dif = sqrt((a2-b2)^2)) %>% 
  filter(dif < 2 & score > .0026))
# seleccionamos los id's de artículos con contenido repetido que aparecen en segundo lugar
(notas_id_out <- scores_rep %>% select(b2) %>% rename(id = b2) %>% distinct())
# nos quedamos con notas únicas 
(base_lc_notas <-  base_lc_notas %>% anti_join(notas_id_out))
# eliminaos los objetos que no usamos 
rm(minhash,scores_rep,scores,pares_candidatxs_lsh,notas_id_out,cubo_lsh,corpus_minhash)
# Normalizamos el contenido de los textos
base_lc_notas$nota_limpia <- gsub('?(f|ht)tp\\S+', '', base_lc_notas$nota, perl = F) # eliminamos urls
base_lc_notas$nota_limpia <- gsub('\\S*@\\S*\\s?', '', base_lc_notas$nota_limpia, perl = F) # eliminamos @names y @mails
base_lc_notas$nota_limpia <- gsub('mail', '', base_lc_notas$nota_limpia, perl = F) # eliminamos un contenido particular 
base_lc_notas$nota_limpia <- gsub('</html>', '', base_lc_notas$nota_limpia, perl = F) # eliminamos un contenido particular
base_lc_notas$nota_limpia <- gsub('(?<=[[:digit:]])(\\.?)(?=[[:digit:]])', '', base_lc_notas$nota_limpia, perl = T) # eliminamos los '.' entre los dígitos
base_lc_notas$nota_limpia <- gsub('\\.(?=[[:upper:]])', '\\. ', base_lc_notas$nota_limpia, perl = T) # agregamos un espacio entre los '.' y las mayúsculas
base_lc_notas$nota_limpia <- gsub('(?=.)#', ' #', base_lc_notas$nota_limpia, perl = T) # agregamos un espacio antes del '#'
base_lc_notas <- base_lc_notas %>% mutate(hashtags = str_extract_all(nota_limpia, "#\\S+")) # extraemos los '#'
base_lc_notas$nota_limpia <- gsub('#\\S+', '', base_lc_notas$nota_limpia, perl = F) # eliminamos los '#'
base_lc_notas$nota_limpia <- gsub('[\n\t\r]', '', base_lc_notas$nota_limpia, perl = T) # borramos los saltos de línea los tabs y los espacios en blanco repetidos 
base_lc_notas$nota_limpia <- gsub('\\. +(?=[[:upper:]])', ' ', base_lc_notas$nota_limpia, perl = T) # borramos los espacios en blanco repetidos
base_lc_notas$nota_limpia <- gsub('\\.(?=[[:upper:]])', '\\. ', base_lc_notas$nota_limpia, perl = T) # agregamos un espacio después del '.' y seguido
base_lc_notas$nota_limpia <- gsub('(?<=[[:lower:]])(?=[[:upper:]])', ' ', base_lc_notas$nota_limpia, perl = T) # agregamos espacio entre las minúsculas y las mayúsculas
base_lc_notas$nota_limpia <- gsub('^ +(?=[[:upper:]])', '', base_lc_notas$nota_limpia, perl = T) # eliminamos el espacio inicial
base_lc_notas$nota_limpia[6]
# guardar la base con las notas limpias
# saveRDS(base_lc_notas,'./data/base_lc_notas_norm.rds')
# base_lc_notas <- readRDS('./data/base_lc_notas_norm.rds')
#
# actualizamos el id de notas y contamos las palabras
(base_lc_notas <- base_lc_notas %>% arrange(desc(fecha)) %>% 
  mutate(id = row_number()) %>% 
  filter(nota != '') %>% filter(!is.na(titulo)) %>% filter(!is.na(nota)) %>% 
  mutate(n_words_n = sapply(strsplit(nota, " "), length)) %>% 
  mutate(n_words_t = sapply(strsplit(titulo, " "), length)))
# pasamos de lista a string la variable hashtags
(hashtags_lc <- tidyr::unnest(base_lc_notas, hashtags, keep_empty = T))
(hashtags_lc <- hashtags_lc %>% group_by(id) %>% summarise(hashtags = paste0(hashtags, collapse = ' | ')))
(hashtags_lc <- hashtags_lc %>% rename(h_tag = hashtags))
# unimos las dos bases
(base_lc_notas <- base_lc_notas %>% left_join(hashtags_lc))
# recodificamos los NA's
(base_lc_notas <- base_lc_notas %>% mutate(h_tag = str_remove_all(h_tag, 'NA')))
# pegamos los hashtags en la variable nota
(base_lc_notas <- base_lc_notas %>% unite(nota_limpia, c('nota_limpia','h_tag'), sep = ' | ', remove = F) %>% 
  select(id, fecha, portal, titulo, nota, nota_limpia, hashtags, h_tag, n_words_n, n_words_t))
# incorporamos los títulos en las notas
(base_lc_notas <- base_lc_notas %>% 
  mutate(words = n_words_n - n_words_t) %>% filter(words > mean(base_lc_notas$n_words_t)) %>% 
  mutate(espacio = ' ') %>% unite('titulo', c(espacio,titulo), sep = '') %>% 
  unite('nota', c(titulo,nota), sep = ' | ', remove = FALSE) %>% 
  select(id, fecha, portal, titulo, nota, nota_limpia, hashtags, h_tag, n_words_n, n_words_t))
# guardamos el nuevo data set
# saveRDS(base_lc_notas,'./data/base_lc_notas_norm_2.rds')
# nos quedamos con las columnas id y notas
(solo_id_y_notas <- base_lc_notas %>% select(id,nota_limpia))
# tokenizamos y normalizamos las notas
(notas_norm <- solo_id_y_notas %>% tidytext::unnest_tokens(palabras,nota_limpia) %>% 
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
  ungroup() %>% full_join(base_lc_notas) %>% 
  select(id, fecha, portal, titulo, nota, nota_limpia, nota_norm))
# guardamos la base modificada
# saveRDS(notas_norm,'./data/notas_norm.rds')
# TOKENS
# ahora realizaremos una selección de palabras clave por nota
(notas_norm_keywords <- notas_norm %>% select(id,nota,nota_norm) %>% 
  unnest_tokens(palabras,nota_norm, drop = FALSE) %>% group_by(id,nota_norm) %>% count(palabras) %>% 
  arrange(id,desc(n)) %>% filter(n > 1) %>% slice_max(order_by = n, n = 10) %>% 
  summarise(keywords = paste0('| ', palabras, collapse = ' ')) %>% select(id,keywords) %>% 
  ungroup() %>% full_join(notas_norm, by = 'id') %>% 
  select(id, fecha, portal, titulo, nota, nota_limpia, nota_norm, keywords))
# guardamos la base modificada
# saveRDS(notas_norm_keywords,'./data/notas_norm_keywords.rds') 
# notas_norm_keywords <- readRDS('./data/notas_norm_keywords.rds')
# LEMAS
# volvemos a tokenizar
(notas_norm_keylemmas_id <- notas_norm_keywords %>% select(id, nota_norm) %>% 
  unnest_tokens(palabras,nota_norm, drop = TRUE) %>% filter(!is.na(palabras)) %>% 
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
  ))))
# contamos tokens
(notas_norm_keylemmas <- notas_norm_keylemmas_id %>% count(palabras) %>% 
  arrange(desc(n)) %>% filter(!is.na(palabras))) #Encoding(notas_norm_keylemmas$palabras) <- 'UTF-8'
# creamos una nueva columna sin acentos ni caracteres especiales 
(notas_norm_keylemmas$palabras_ascii <- stringi::stri_trans_general(notas_norm_keylemmas$palabras,"Latin-ASCII"))
# lematizamos con udpipe
es_model <- udpipe_download_model(language = "spanish")
es_model <- udpipe_load_model(es_model$file_model)
# lematización con tildes
# ejemplo simple
texto_ejemplo <- c("Los municipales piden un aumento de salarios",
                   "El movimiento de mujeres realizó una protesta en el centro de la ciudad")
ejemplo_lema <- udpipe_annotate(es_model, x =  iconv(texto_ejemplo, to = 'UTF-8'))
as.data.frame(ejemplo_lema) %>% as_tibble() %>% select(token,lemma,upos,feats) %>% 
  anti_join(tibble(lemma = c(tm::stopwords(kind='es'))))
# lematizamos el listado de palabras
lemmas_udpipe <- udpipe_annotate(es_model, x = notas_norm_keylemmas$palabras)
(lemmas_udpipe <- as.data.frame(lemmas_udpipe))
(lemmas_udpipe <- lemmas_udpipe %>% select(token,lemma,upos,feats) %>% 
  distinct(token, .keep_all = T) %>% as_tibble() %>% rename(palabras = token))
# lematización sin tildes
lemmas_udpipe_ascii <- udpipe_annotate(es_model, x = notas_norm_keylemmas$palabras_ascii)
(lemmas_udpipe_ascii <- as.data.frame(lemmas_udpipe_ascii))
(lemmas_udpipe_ascii <- lemmas_udpipe_ascii %>% select(token,lemma,upos,feats) %>% 
  distinct(token, .keep_all = T) %>% as_tibble() %>% 
  rename(palabras_ascii = token, upos_ascii = upos, lemma_ascii = lemma))
# juntamos la base notas_norm_keylemmas con las dos lematizaciones hechas con udpipe
(notas_norm_keylemmas_completa <- notas_norm_keylemmas %>% 
  left_join(lemmas_udpipe, by = 'palabras') %>% 
  left_join(lemmas_udpipe_ascii, by = 'palabras_ascii') %>% 
  select(palabras, n, palabras_ascii, lemma, lemma_ascii, upos, upos_ascii))
# simplificamos la base de lemas
(listado_lemas  <- notas_norm_keylemmas_completa %>% 
  mutate(lemas_ok = lemma) %>% 
  mutate(lemas_ok = case_when(is.na(lemas_ok) ~ lemma_ascii, TRUE ~ as.character(lemas_ok))))
# guardamos la base modificada
#saveRDS(listado_lemas,'./data/listado_lemas.rds')
# nos quedamos con los NA's
(listado_lemas_na  <- listado_lemas %>% select(palabras,lemas_ok,upos) %>% filter(is.na(lemas_ok)))
# guardamos la base de NA's
# saveRDS(listado_lemas,'./data/listado_lemas.rds')
# listado de lemas simplificado
(listado_lemas_simplificado  <- listado_lemas %>% select(palabras,lemas_ok,upos) %>% filter(!is.na(lemas_ok)))
# ahora realizaremos una selección de lemas por nota
(notas_norm_keylemmas_ok <- notas_norm_keylemmas_id %>% 
  left_join(listado_lemas_simplificado) %>% filter(!is.na(lemas_ok)) %>% 
  group_by(id) %>% count(lemas_ok) %>% arrange(id,desc(n)) %>% 
  filter(n > 1) %>% slice_max(order_by = n, n = 10) %>% 
  summarise(keylemas = paste0('| ', lemas_ok, collapse = ' ')) %>% ungroup())
# unificamos la base con el resumen de palabras y lemas
(notas_norm_key_words_lemmas <- notas_norm_keywords %>% left_join(notas_norm_keylemmas_ok))
# notas_norm_key_words_lemmas[is.na(notas_norm_key_words_lemmas)] <- 'nota_sin_freq_palabras_mayor_1'
# guardamos la base modificada
# saveRDS(notas_norm_key_words_lemmas,'./data/notas_norm_key_words_lemmas.rds')
# ahora realizaremos una selección de raíces de palabras clave por nota 
(notas_norm_keystem <- notas_norm %>% select(id,nota,nota_norm) %>% 
  unnest_tokens(palabras,nota_norm, drop = FALSE) %>% 
  mutate(palabras = SnowballC::wordStem(palabras, language = 'spanish')) %>% 
  group_by(id,nota_norm) %>% count(palabras) %>% 
  arrange(id,desc(n)) %>% filter(n > 1) %>% slice_max(order_by = n, n = 10) %>% 
  summarise(keystem = paste0('| ', palabras, collapse = ' ')) %>% select(id,keystem) %>% 
  ungroup() %>% full_join(notas_norm, by = 'id') %>% 
  select(id, fecha, portal, titulo, nota, nota_limpia, nota_norm, keystem))
# unificamos todos los resumenes 
(notas_norm_key_words_lemmas_sten <- notas_norm_key_words_lemmas %>% left_join(notas_norm_keystem[,c(1,8)]))
# guardamos
# saveRDS(notas_norm_key_words_lemmas_sten,'./data/notas_norm_key_words_lemmas_sten.rds')
# ahora un ejemplo con spacyR
(txt_id_nota <- corpus(notas_norm_key_words_lemmas_sten$nota_norm,
                      docnames = notas_norm_key_words_lemmas_sten$id))
#saveRDS(txt_id_nota,'./data/txt_id_nota.rds')
# spacy_install()
# spacy_finalize()
# spacy_download_langmodel("es_core_news_md")
# cargamos el modelo es
spacy_initialize(model = "es_core_news_md")#es_core_news_md
# un ejemplo acotado
spacy_parse(corpus('El Sindicato realizó una manifestación violenta en el centro de la ciudad de Córdoba.',
                   docnames = 'doc-1'))
# analizamos con spacyR las notas
(txt_id_nota_spacyR <- spacy_parse(txt_id_nota, 
            pos = TRUE,
            tag = FALSE,
            lemma = TRUE,
            entity = TRUE,
            dependency = TRUE,
            nounphrase = FALSE,
            multithread = FALSE) %>% 
    as_tibble() %>% select(-head_token_id))
# saveRDS(txt_id_nota_spacyR,'./data/txt_id_nota_spacyR.rds')
#
# Documentación
# textreuse: https://cran.r-project.org/web/packages/textreuse/vignettes/textreuse-introduction.html
# r-for-newspaper-data: https://bookdown.org/yann_ryan/r-for-newspaper-data/detecting-text-reuse-in-newspaper-articles-.html
