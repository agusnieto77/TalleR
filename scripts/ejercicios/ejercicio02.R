# Instalar los paquetes que no tengan instalados

# Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------

require(dplyr)
require(purrr)
require(rvest)
require(tidyr)
require(tibble)
require(stringr)
require(lubridate)

# Creamos la función para raspar El País cuyo nombre será 'scraping_links()' ---------------------

scraping_links <- function(pag_web, tag_link) {   # abro función para raspado web y le asigno un nombre: scraping_links.

         read_html(pag_web) %>%                   # llamo a la función read_html() para obtener el contenido de la página.

           html_elements(tag_link) %>%            # llamo a la función html_elements() y especifico las etiquetas de los títulos 

           html_attr("href") %>%                  # llamo a la función html_attr() para especificar el formato 'chr' del título.

           url_absolute(pag_web) %>%              # llamo a la función absolute() para completar las URLs relativas

           as_tibble() %>%                        # llamo a la función as_tibble() para transforma el vector en tabla

           rename(link = value)                   # llamo a la función rename() para renombrar la variable 'value'

}                                                 # cierro la función para raspado web

# Usamos la función para scrapear el diario El Mundo ----------------------------------------------

(links_EM <- scraping_links(pag_web = "https://www.elmundo.es/economia.html", tag_link = "a.ue-c-cover-content__link"))

# Usamos la función para scrapear el diario El País -----------------------------------------------

(links_EP <- scraping_links(pag_web = "https://elpais.com/espana/", tag_link = "h2 a")) 

# Creamos la función para raspar El País cuyo nombre será 'scraping_links()' ---------------------

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

            html_text()                           # llamo a la función html_text() para especificar el formato 'chr' del título.

  )                                               # cierro la función tibble().

}                                                 # cierro la función para raspado web.

# Usamos la función para scrapear las notas del diario El País u otras páginas web ---------------------------

(notas_EP  <- scraping_notas(pag_web = "https://elpais.com/espana/2021-01-16/madrid-una-semana-enterrada-en-la-nieve.html", 

                             tag_fecha = ".a_ti",

                             tag_titulo = "h1",

                             tag_nota = ".a_b")) 

# ¿Cómo reparar fechas? --------------------------------------------------------------------------------------

fecha_sin_normalizar <- "16 ene 2021 - 23:30 UTC"   # creamos el objeto 'fecha_sin_normalizar'.

(str_sub(fecha_sin_normalizar, 1, 11) %>%  # llamamos a la función str_sub() para quedarnos con los primeros 11 caracteres. 
    
    str_replace_all("ene", "jan") %>%      # llamamos a la función str_remplace_all() para cambiar la denominación de los mes.                   

    str_replace_all("abr", "apr") %>% 

    str_replace_all("ago", "aug") %>% 

    str_replace_all("dic", "dec") %>% 
    
    dmy() -> fecha_normalizada)             # finalmente llamamos a la función dmy() para transformar el string en un valor tipo 'date'.

class(fecha_normalizada)                      # examinamos su clase.

# Seleccionamos los links que refieren a la sección que nos interesa y nos quedamos solo con 10 notas --------

(links_EP_limpio <- links_EP %>% 

          filter(str_detect(link, "https://elpais.com/espana/")) %>% 

          filter(!str_detect(link,"en-clave-de-bienestar")) %>% .[1:10,])

# Usamos la función pmap_dfr() para emparejar los links y la función de web scraping y creamos el objeto el_pais_esp con las 10 notas completas

(el_pais_esp <-                     # abrimos la función print '(' y asignamos un nombre al objeto que vamos a crear.

    pmap_dfr(                       # llamamos a la función pmap_dfr() para emparejar links y función de rascado.

      list(                         # Llamamos a la función list() para crear una lista con los múltiples argumentos de la función de rascado.

        links_EP_limpio$link,       # vector de links.

        ".a_ti",                    # etiqueta de fecha.

        "h1",                       # etiqueta de título.

        ".a_b"),                    # etiqueta de nota y cierro la función list().

      scraping_notas))              # función scraping_notas() sin los `()` y cierro la función pmap_dfr() y la función print `)`.

# Usamos la función para scrapear los links a las notas de La Nación -------------------------------

# Repetimos el raspado, ahora lo aplicamos al periódico La Nación. Replicamos todo en una sola línea de código.

(ln_sec_pol <- scraping_links(pag_web = "https://www.lanacion.com.ar/politica", tag_link = "h2 a")) # creamos la lista de links.

(la_nacion_ar <- pmap_dfr(list(ln_sec_pol$link[1:10],".com-date.--twoxs",".com-title.--threexl",".col-12 p"), scraping_notas)) # scrapeamos.

# Guardamos el objeto 'la_nacion_ar' como objeto .rds

saveRDS(la_nacion_ar, "la_nacion_ar.rds")

# Cargamos el objeto la_nacion_ar.

(la_nacion_ar <- readRDS("la_nacion_ar.rds"))

# Imprimimos en consola sus valores completos, las notas completas.

la_nacion_ar$nota[1:30] # los corchetes me permiten seleccionar los valores según su número de fila

# Detectamos que hay algunas filas que son recurrente y debemos borrar:

# "Celdas vacías"
# "Espacios en blanco"

# Con el uso del paquete stringr vamos a remover estos fragmentos de información no útil.

(la_nacion_ar_limpia <- la_nacion_ar %>%         # creamos un nuevo objeto clase tibble.

           mutate(nota = str_trim(nota)) %>%     # con las funciones mutate() y str_trim() quitamos los espacios en blanco sobrantes.

           filter(nota != ""))                   # con la función filter() descartamos las celdas vacías.

# Ahora colapsaremos los párrafos de cada nota en una sola celda, de esta forma volveremos a un tibble de 10 filas (observaciones), una por nota.

(la_nacion_ar_limpia_norm <- la_nacion_ar_limpia %>%                                  # creamos un nuevo objeto clase tibble.

           group_by(fecha, titulo) %>%                                                # con la función group_by() agrupamos por fecha y título.

           summarise(nota_limpia = paste(nota, collapse = " ||| ")) %>%               # con las funciones summarise() y paste() colapsamos los párrafos.

           select(fecha, titulo, nota_limpia) %>%                                     # con la función select() seleccionamos las variables. 

           mutate(fecha = dmy(fecha)))                                                # con las funciones mutate() y str_remove_all() normalizamos el string de fechas.

# Imprimimos en consola sus valores completos, las notas completas.

la_nacion_ar_limpia_norm$nota_limpia[1:10] # los corchetes me permiten seleccionar los valores según su número de fila

# Fin del script ----------------------------------------------------------------------------------

# Pueden copiar y pegar o descargarlo desde RStudio con esta línea de comando:

download.file("https://estudiosmaritimossociales.org/ejercicio02.R", "ejercicio02.R")

