require(tidyverse)
require(vosonSML)
require(tidytext)
require(tidyr)
require(stopwords)

# Cargmos los datos 
# tw8mcomp <- readRDS(url('https://estudiosmaritimossociales.org/archivos/8Mcompleto.rds','rb'))

# Preparamos los datos 
class(tw8mcomp) <- c("tbl_df","tbl","data.frame","datasource","twitter")

# Inspeccionamos las características de la red 
# Los nodos son tweets y los bordes son la relación 
# con otros tweets como reply, retweet o quote.
rasgos_red <- tw8mcomp %>% Create("activity")

rasgos_red$nodes

rasgos_red$edges

# Recortamos la base
tw8mcompsub <- tw8mcomp[1:10000]
rasgos_red_sub <- tw8mcompsub %>% Create("activity")

# Le damos formato graph
datos_graph <- rasgos_red %>% Graph(writeToFile = TRUE)

# Red de actorxs
# Los nodos son usuarixs de Twitter y los bordes son la relación 
# con otrxs usuarixs en la red, tales como reply, mention, retweety quote. 
# Las menciones se pueden excluir configurando el parámetro inclMentions con el valor FALSE
red_actorxs <- tw8mcomp %>%  Create("actor", inclMentions = TRUE)

red_actorxs$nodes

red_actorxs$edges

# Le damos formato graph
datos_graph_actorxs <- red_actorxs %>% Graph(writeToFile = TRUE)

# Red semántica (co-ocurrencia)
# Los nodos son conceptos representados como palabras comunes y hashtags. 
# Los bordes representan la aparición de una palabra en particular y 
# un hashtag en particular en el mismo tweet.
# Creamos una red semántica excluyendo el hashtag #8m, incluimos como nodos solo el 10% 
# palabras más frecuentes y 20% de hashtags más frecuentes.
red_semantica <- tw8mcomp %>% Create("semantic",
         removeTermsOrHashtags = c("#8m"),
         termFreq = 10,
         hashtagFreq = 20)

# Red de modos alternativos
# Los nodos son usuarixs o hashtags. 
# Los bordes representan el uso de un hashtag o la referencia a otrx usuarix en un tweet.
red_multiple <- tw8mcomp %>%  Create("twomode", removeTermsOrHashtags = c("#8m"), weighted = TRUE)

red_multiple$nodes
  
red_multiple$edges

# Le damos formato graph
datos_graph_multiple <- red_multiple %>% Graph(writeToFile = TRUE)
