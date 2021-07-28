# Instalar los paquetes que no tengan instalados

# Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------

require(dplyr)
require(rvest)
require(tibble)

# Creamos la función para raspar El País cuyo nombre será 'scraping_links()' ---------------------

url_wiki <- "https://es.wikipedia.org/wiki/Población_mundial"    # creamos el objeto url_wiki con la url de la pág. web que contiene las tablas

(pob__mun__t_tablas <-  read_html(url_wiki) %>%           # creamos un objeto y llamamos a la función read_html() para leer la pág. web.

                        html_table())                     # llamamos a la función html_table() para quedarnos con todas las tablas existentes.

(pob_mun_tablas_1y2 <-  read_html(url_wiki) %>%           # creamos un objeto y llamamos a la función read_html() para leer la pág. web.

                        html_table() %>% .[1:2])          # llamamos a la función html_table() e indicamos con qué tablas queremos quedarnos.

(pob__mun__tabla__1 <- read_html(url_wiki) %>%            # creamos un objeto y llamamos a la función read_html() para leer la pág. web.

                       html_table() %>% .[[1]])           # llamamos a la función html_table() e indicamos con qué tabla queremos quedarnos.

(pob__mun__tabla__2 <- read_html(url_wiki) %>%            # creamos un objeto y llamamos a la función read_html() para leer la pág. web.

                       html_table() %>% .[[2]])           # llamamos a la función html_table() e indicamos con qué tabla queremos quedarnos.

saveRDS(pob_mun_tablas_1y2, 'pob_mun_tablas_1y2.rds')     # guardamos como archivo .rds la lista con los dos tibbles.

# Fin del script ----------------------------------------------------------------------------------

# Pueden copiar y pegar o descargarlo desde RStudio con esta línea de comando:

download.file("https://estudiosmaritimossociales.org/ejercicio04.R", "ejercicio04.R")

