# Instalar los paquetes que no tengan instalados

# Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------

require(tidyverse)
require(rvest)
require(RSelenium) 

# El objetivo de RSelenium es facilitar la conexión a un servidor remoto desde dentro de R. 
# RSelenium proporciona enlaces R para el API de Selenium Webdriver. 
# Selenio es un proyecto centrado en la automatización de los navegadores web. 

# Descargamos los binarios, iniciamos el controlador y obtenemos el objeto cliente.

servidor <- rsDriver(browser = "firefox", port = 5664L)            # iniciar un servidor y un navegador de Selenium (cambiar los números del puerto en cada sesión)

cliente <- servidor$client                                         # objeto 'cliente' (objeto que contiene un vínculo dinámico con el servidor)

cliente$navigate("https://www.lanacion.com.ar/politica")           # cargamos la página a navegar

# Ahora debemos encontrar el botón de carga y hacemos clic sobre él.

VerMas <- cliente$findElement(using = "css selector", ".col-12.--loader") # Encontramos el botón

for (i in 1:6){                 # abrimos función for para reiterar n veces la acción (clic)

        print(i)                # imprimimos cada acción

  VerMas$clickElement()         # hacemos clic

        Sys.sleep(7)            # estimamos tiempo de espera entre clic y clic

}                               # cerramos la función for()

html_data <- cliente$getPageSource()[[1]]                          # obtenemos datos HTML y los analizamos

ln_sec_pol <- html_data %>%                                        # obtenemos los links a las notas de la sección Política

         read_html() %>%                                           # leemos el objeto html_data con la función read_html()

         html_nodes("h2.com-title.--xs a.com-link") %>%            # ubicamos los tags de los links a las notas

         html_attr("href") %>%                                     # extraemos los links de las notas

         url_absolute("https://www.lanacion.com.ar/politica") %>%  # llamo a la función absolute() para completar las URLs relativas

         as_tibble() %>%                                           # llamo a la función as_tibble() para transformar el objeto en una tibble.

         rename(link = value)                                      # llamo a la función rename() para renombrar la variable creada.

# Creamos la función scraping_notas() para scrapear los links obtenidos ---------------------

scraping_notas <- function(pag_web, tag_fecha, tag_titulo, tag_nota) { # abro función para raspado web: scraping_notas().

          tibble(                                       # llamo a la función tibble.

                 fecha = html_nodes(                    # declaro la variable fecha y llamo a la función html_nodes().

                   read_html(pag_web), tag_fecha) %>%   # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) de la fecha. 

                   html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' de la fecha.

                 titulo = html_nodes(                   # declaro la variable 'titulo' y llamo a la función html_nodes().

                   read_html(pag_web), tag_titulo) %>%  # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) del título.  

                   html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' del título.

                 nota = html_nodes(                     # declaro la variable nota y llamo a la función html_nodes(). 

                   read_html(pag_web), tag_nota) %>%    # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) de la nota.  

                   html_text()                          # llamo a la función html_text() para especificar el formato 'chr' de la nota.

  )                                                     # cierro la función tibble().

}                                                       # cierro la función para raspado web.

# Usamos la función pmap_dfr() para emparejar los links y la función de web scraping y 

# creamos el objeto la_nacion_politica con las 100 notas completas

(la_nacion_politica <- pmap_dfr(list(ln_sec_pol$link[1:20],".com-date.--twoxs",".com-title.--threexl",".col-12 p"), scraping_notas))

# Guardamos el objeto 'la_nacion_politica' como objeto .rds

saveRDS(la_nacion_politica, "la_nacion_politica.rds")

# Fin del script ----------------------------------------------------------------------------------

# Pueden copiar y pegar o descargarlo desde RStudio con esta línea de comando:

download.file("https://estudiosmaritimossociales.org/ejercicio03.R", "ejercicio03.R")

