# Web Scraping en R con el paquete rvest

## ¿Qué es el Web Scraping?

Se denomina ‘web scraping’ (en inglés = arañado o raspado web) a la
extracción (automatizada y dirigida) y almacenamiento computacional del
contenido de páginas web. La información raspada puede ser de diverso
tipo. Por ejemplo, contactos telefónicos, correo electrónico,
direcciones físicas, información censal, notas periodísticas o de
opinión, comentarios de lectorxs, precios, etc. Esta información se
almacena en formatos diversos: vectores lógicos, numéricos o de texto
plano, marcos de datos, tablas, listas, matrices, arrays. Los objetos de
clase arrays son poco usuales. En este encuentro nos vamos a centrar en
los objetos de tipo tabular (tibbles y data frames). También usaremos
objetos de clase lista y vector.

![](https://estudiosmaritimossociales.org/Data_TalleR/tipos_objetos_r.png)

En términos generales, el web scraping toma información web
semi-estructurada y la devuelve en un formato estructurado. Como
dijimos, aquí usaremos el formato tibble.

## Web Scraping y el giro digital

En las últimas dos décadas el crecimiento de la información online se
dio de forma acelerada, al punto de tornar imprescindible el uso del
raspado web para la recuperación masiva de parte de esa información
nacida digital. Internet alberga una cantidad infinita de datos
“extraibles”. Parte de esta información subyace en bases de datos,
detrás de API o en texto plano enmarcados en estructuras HTML/XML. Como
vimos en los encuentros anteriores, por distintas razones podemos querer
obtener información de redes sociales como Twitter o de foros de
usuarixs para ver qué está pensando la población sobre distintos temas y
tópicos. De todas formas, la accesibilidad no siempre está al alcance de
la mano, muchas páginas web bloquean el acceso mediante programación o
configuran “muros de pago” que requieren que se suscriba a una API para
acceder. Esto es lo que hacen, por ejemplo, *The New York Times* y *El
ABC*. Pero, finalmente, esas medidas no son una traba definitiva.
Existen muchas formas para obtener los datos que nos interesan.

## ¿Cuándo se usa el Web Scraping?

-   Cuando no hay un conjunto de datos disponible para la problemática
    que queremos abordar.
-   Cuando no hay una API (interfaz de programación de aplicaciones)
    pública disponible que permita un intercambio fluido con los datos
    que necesitamos recopilar.

## El Web Scraping y su legalidad

En términos generales, el raspado web (no comercial) de información
publicada en la web y de acceso público no es ilegal. Sin embargo,
existen protocolos de buenas prácticas de raspado que debemos intentar
respetar por cuestiones éticas. Para más detalles sobre este asunto
pueden leer los siguientes artículos: James Phoenix (2020) [‘Is Web
Scraping Legal?’](https://understandingdata.com/is-web-scraping-legal/),
Tom Waterman (2020) [‘Web scraping is now
legal’](https://medium.com/@tjwaterman99/web-scraping-is-now-legal-6bf0e5730a78),
Krotov, V., Johnson, L., & Silva, L. (2020) [‘Tutorial: Legality and
Ethics of Web
Scraping’](https://aisel.aisnet.org/cgi/viewcontent.cgi?article=4240&context=cais),
Edward Roberts (2018) [‘Is Web Scraping Illegal? Depends on What the
Meaning of the Word
Is’](https://www.imperva.com/blog/is-web-scraping-illegal/).

## ¿Para qué hacer Web Scraping?

Los usos del raspado web son infinitamente variados. Todo depende del
problema que queramos resolver. Puede ser la recuperación de la serie
histórica de precios de los pasajes de autobús en la ciudad de Mar del
Plata. O el análisis de las tendencias actuales en las agendas
periodísticas en la prensa española. Quizás la detección de cambios en
el lenguaje a lo largo del tiempo referido al uso del lenguaje
inclusivo, por ejemplo. O el monitoreo del humor social en determinado
lugar y tiempo en torno a tópicos políticos, sociales, culturales o
económicos. Etcétera. Etcétera. Etcétera. O el análisis de la
conflictividad social visibilizada en la prensa online, que es lo que
nos ocupa.

Todo esto es independiente de la herramienta que usemos para hacer el
raspado web. Pero no es así en este TalleR 😉.

## ¿Cómo hacer Web Scraping en R?

Esta pregunta la vamos a responder con un enfoque práctico, gracias a
las funciones del paquete `rvest`.

Lo primero que vamos a hacer es activar los paquetes que vamos a
utilizar a lo largo de los ejercicios. El primero de los ejercicios nos
permitirá desarrollar una función de web scraping. En este caso
aplicaremos la función creada a un diario español: *El Mundo*. La
función nos permitirá quedarnos con los titulares de una de sus
secciones. Luego analizaremos esos titulares con técnicas de
tonkenización y, finalmente, visualizaremos los resultados con `ggplot2`
que nos devolverá un gráfico de barras con las palabras más frecuentes.
Esto nos permitirá tener un primer pantallazo sobre la agenda
periodística del periódico en cuestión. Sin más preámbulo, pasemos la
primer ejercicio.

### Ejercicio 1

¿Cuáles son los tópicos más importantes de la agenda del diario *El
Mundo* según las últimas notas de su sección ‘España’? Veamos:

    # Pueden copiar y pegar el script o descargarlo desde RStudio con esta línea de comando:
    # utils::download.file("https://estudiosmaritimossociales.org/ejercicio01.R", "ejercicio01.R")
    # Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------
    require(tidyverse)
    require(rvest)
    require(stringr)
    require(tidytext)
    # Creamos la función para raspar El Mundo cuyo nombre será 'scraping_EM()' ------------------------
    scraping_EM <- function (x){          # abro función para raspado web y le asigno un nombre: scraping_EM
      
      rvest::read_html(x) %>%             # llamo a la función read_html() para obtener el contenido de la página
        
        rvest::html_elements(".ue-c-cover-content__headline-group") %>%  # llamo a la función html_elements() y especifico las etiquetas de los títulos 
        
        rvest::html_text() %>%            # llamo a la función html_text() para especificar el formato 'chr' del título.
        
        tibble::as_tibble() %>%           # llamo a la función as_tibble() para transforma el vector en tabla 
        
        dplyr::rename(titulo = value)     # llamo a la función rename() para renombrar la variable 'value'
      
    }                                     # cierro la función para raspado web
    # Usamos la función para scrapear el diario El Mundo ----------------------------------------------
    (El_Mundo <- scraping_EM("https://www.elmundo.es/espana.html"))

    ## # A tibble: 67 x 1
    ##    titulo                                                                       
    ##    <chr>                                                                        
    ##  1 "Ceuta. Abascal, al PP: \"Se ríen de nosotros. Votaremos lo que queramos en ~
    ##  2 "Entrevista. Juan Jesús Vivas: \"Marruecos se frota las manos con las tesis ~
    ##  3 "Política. Igualdad anima a los comercios a tener un espacio seguro para ate~
    ##  4 "Interior. Marlaska faculta a los técnicos expertos en delitos de odio para ~
    ##  5 "UE. El PP recurre al TC el veto del Gobierno a que una autoridad independie~
    ##  6 "Cataluña. \"Fascista, colono\", los insultos a un profesor en el Claustro d~
    ##  7 "'Procés'. El Tribunal de Cuentas fuerza a Sánchez a decir si acepta avalar ~
    ##  8 "Tribunales. El juez manda a juicio al empresario López Madrid por contratar~
    ##  9 "Justicia. Indemnizan a una limpiadora por una plaga de chinches en su casa ~
    ## 10 "País Vasco. Continúa en estado grave el joven que recibió una paliza en Amo~
    ## # ... with 57 more rows

    # Tokenizamos los títulos de la sección 'España' del periódico El Mundo ---------------------------
    El_Mundo %>%                                          # datos en formato tabular extraídos con la función scraping_EM()
      
      tidytext::unnest_tokens(                            # función para tokenizar
        
        palabra,                                          # nombre de la columna a crear
        
        titulo) %>%                                       # columna de datos a tokenizar
      
      dplyr::count(                                       # función para contar
        
        palabra) %>%                                      # columna de datos a contar
      
      dplyr::arrange(                                     # función para ordenar columnas
        
        dplyr::desc(                                      # orden decreciente
          
          n)) %>%                                         # columna de frecuencia a ordenar en forma decreciente
      
      dplyr::filter(n > 4) %>%                            # filtramos y nos quedamos con las frecuencias mayores a 2
      
      dplyr::filter(!palabra %in% 
                      tm::stopwords("es")) %>%            # filtramos palabras comunes
      
      dplyr::filter(palabra != "españa") %>%              # filtro comodín
      
      dplyr::filter(palabra != "años") %>%                # filtro comodín
      
      ggplot2::ggplot(                                    # abrimos función para visualizar
        
        ggplot2::aes(                                     # definimos el mapa estético del gráfico
          
          y = n,                                          # definimos la entrada de datos de y
          
          x = stats::reorder(                             # definimos la entrada de datos de x
            
            palabra,                                      # con la función reorder() 
            
            + n                                           # para ordenar de mayor a menos la frecuencia de palabras
            
          )                                               # cerramos la función reorder()
          
        )                                                 # cerramos la función aes()
        
      ) +                                                 # cerramos la función ggplot()
      
      ggplot2::geom_bar(                                  # abrimos la función geom_bar()
        
        ggplot2::aes(                                     # agregamos parámetros a la función aes()
          
          fill = as_factor(n)                             # definimos los colores y tratamos la variable n como factores
          
        ),                                                # cerramos la función aes()
        
        stat = 'identity',                                # definimos que no tiene que contar, que los datos ya están agrupados 
        
        show.legend = F) +                                # establecemos que se borre la leyenda
      
      ggplot2::geom_label(                                # definimos las etiquetas de las barras
        
        aes(                                              # agregamos parámetros a la función aes()
          
          label = n                                       # definimos los valores de ene como contenido de las etiquetas
          
        ),                                                # cerramos la función aes()
        
        size = 5) +                                       # definimos el tamaño de las etiquetas
      
      ggplot2::labs(                                      # definimos las etiquetas del gráfico
            
        title = "Temas en la agenda periodística",        # definimos el título
        
        x = NULL,                                         # definimos la etiqueta de la x
        
        y = NULL                                          # definimos la etiqueta de la y
        
      ) +                                                 # cerramos la función labs()
      
      ggplot2::coord_flip() +                             # definimos que las barras estén acostadas                     
      
      ggplot2::theme_bw() +                               # definimos el tema general del gráfico
      
      ggplot2::theme(                                     # definimos parámetros para los ejes
        
        axis.text.x = 
          ggplot2::element_blank(),                       # definimos que el texto del eje x no se vea
        
        axis.text.y = 
          ggplot2::element_text(                          # definimos que el texto del eje y 
            
            size = 16                                     # definimos el tamaño del texto del eje y
            
          ),                                              # cerramos la función element_text()
        
        plot.title = 
          ggplot2::element_text(                          # definimos la estética del título
            
            size = 18,                                    # definimos el tamaño
            
            hjust = .5,                                   # definimos la alineación 
            
            face = "bold",                                # definimos el grosor de la letra
            
            color = "darkred"                             # definimos el color de la letra
            
          )                                               # cerramos la función element_text()
        
      )                                                   # cerramos la función theme()

<img src="Segundo_encuentro_1_files/figure-markdown_strict/paquetes-1.png" width="80%" style="display: block; margin: auto;" />

Parece que durante los últimos días los temas centrales fueron la covid,
las políticas publicas en torno al coronavirus (toque de queda,
restricciones, confinamiento), disputas políticas entre el gobierno y la
oposición.

### Ejercicio 2

Gracias al Ejercicio 1 tenemos una idea general sobre cómo y para qué
hacer web scraping. En el ejercicio 1 hicimos todo en uno, desde la
extracción hasta la visualización. Ahora nos ocuparemos de ir paso a
paso. Además, haremos un raspado un poco más profundo.

Arranquemos por la función de web scraping:

    # Pueden copiar y pegar o descargarlo desde RStudio con esta línea de comando:
    # utils::download.file("https://estudiosmaritimossociales.org/ejercicio02.R", "ejercicio02.R")
    # Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------
    require(dplyr)
    require(rvest)
    require(tibble)
    # Creamos la función para raspar El País cuyo nombre será 'scraping_links()' ---------------------
    scraping_links <- function(pag_web, tag_link) {   # abro función para raspado web y le asigno un nombre: scraping_links.
      
      rvest::read_html(pag_web) %>%                   # llamo a la función read_html() para obtener el contenido de la página.
        
        rvest::html_elements(tag_link) %>%            # llamo a la función html_elements() y especifico las etiquetas de los títulos 
        
        rvest::html_attr("href") %>%                  # llamo a la función html_attr() para especificar el formato 'chr' del título.
        
        rvest::url_absolute(pag_web) %>%              # llamo a la función url::absolute() para completar las URLs relativas
        
        tibble::as_tibble() %>%                       # llamo a la función as_tibble() para transforma el vector en tabla
        
        dplyr::rename(link = value)                   # llamo a la función rename() para renombrar la variable 'value'
      
    }                                                 # cierro la función para raspado web
    # Usamos la función para scrapear el diario El Mundo ----------------------------------------------
    (links_EM <- scraping_links(pag_web = "https://www.elmundo.es/economia.html", tag_link = "a.ue-c-cover-content__link"))

    ## # A tibble: 66 x 1
    ##    link                                                                         
    ##    <chr>                                                                        
    ##  1 https://www.elmundo.es/economia/macroeconomia/2021/07/28/61018acbfc6c8368198~
    ##  2 https://www.elmundo.es/economia/2021/07/28/61015632e4d4d83d3b8b4621.html     
    ##  3 https://www.elmundo.es/economia/2021/07/28/610113bc21efa0be4a8b4600.html     
    ##  4 https://www.elmundo.es/economia/actualidad-economica/2021/07/28/61001bf221ef~
    ##  5 https://www.elmundo.es/economia/empresas/2021/07/28/610140befdddff98838b4653~
    ##  6 https://www.elmundo.es/economia/2021/07/27/61000ea3e4d4d8980a8b461c.html     
    ##  7 https://www.elmundo.es/economia/empresas/2021/07/28/6100f077e4d4d8db038b4628~
    ##  8 https://www.elmundo.es/economia/empresas/2021/07/28/6100f28b21efa03a5f8b4617~
    ##  9 https://www.elmundo.es/economia/empresas/2021/07/26/60feea9bfdddff55a08b463b~
    ## 10 https://www.elmundo.es/economia/actualidad-economica/2021/07/28/60fffd65e4d4~
    ## # ... with 56 more rows

    # Usamos la función para scrapear el diario El País -----------------------------------------------
    (links_EP <- scraping_links(pag_web = "https://elpais.com/espana/", tag_link = "h2 a")) 

    ## # A tibble: 27 x 1
    ##    link                                                                         
    ##    <chr>                                                                        
    ##  1 https://elpais.com/espana/catalunya/2021-07-28/la-fiscalia-investiga-el-aval~
    ##  2 https://elpais.com/espana/2021-07-28/el-pp-desprecia-la-conferencia-de-presi~
    ##  3 https://elpais.com/espana/2021-07-28/los-delitos-de-odio-repuntan-hasta-alca~
    ##  4 https://elpais.com/espana/2021-07-28/el-parlament-respalda-a-torrent-y-tilda~
    ##  5 https://elpais.com/espana/2021-07-28/la-abogacia-del-estado-defendio-ante-el~
    ##  6 https://elpais.com/espana/2021-07-28/el-matrimonio-ruso-kokorev-vendio-679-m~
    ##  7 https://elpais.com/espana/2021-07-28/el-97-de-los-menores-migrantes-acogidos~
    ##  8 https://elpais.com/espana/2021-07-28/urkullu-ira-a-la-conferencia-de-preside~
    ##  9 https://elpais.com/espana/2021-07-28/jubilado-por-incapacidad-permanente-el-~
    ## 10 https://elpais.com/espana/2021-07-28/el-juez-deja-a-un-paso-del-banquillo-a-~
    ## # ... with 17 more rows

Cumplido el primer paso (la obtención de los links a las notas
completas), nos toca construir una función para ‘raspar’ el contenido
completo de cada nota. ¡Manos a la obra!

    # Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------
    require(dplyr)
    require(rvest)
    require(tibble)
    # Creamos la función para raspar El País cuyo nombre será 'scraping_links()' ---------------------
    scraping_notas <- function(pag_web, tag_fecha, tag_titulo, tag_nota) { # abro función para raspado web: scraping_notas().
      
      tibble::tibble(                               # llamo a la función tibble.
      
      fecha = rvest::html_elements(                 # declaro la variable fecha y llamo a la función html_elements().
        
        rvest::read_html(pag_web), tag_fecha) %>%   # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) de la fecha. 
        
        rvest::html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' de la fecha.
      
      titulo = rvest::html_elements(                # declaro la variable titulo y llamo a la función html_elements().
        
        rvest::read_html(pag_web), tag_titulo) %>%  # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) del titulo.  
        
        rvest::html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' del título.
      
      nota = rvest::html_elements(                  # declaro la variable nota y llamo a la función html_elements(). 
        
        rvest::read_html(pag_web), tag_nota) %>%    # llamo a la función html_elements() y especifico la(s) etiqueta(s) de la nota. 
        
        rvest::html_text()                          # llamo a la función html_text() para especificar el formato 'chr' del título.
      
      )                                             # cierro la función tibble().
      
    }                                               # cierro la función para raspado web.
    # Usamos la función para scrapear las notas del diario El País u otras páginas web ---------------------------
    (notas_EP  <- scraping_notas(pag_web = "https://elpais.com/espana/2021-01-16/madrid-una-semana-enterrada-en-la-nieve.html", 
                                 tag_fecha = ".a_ti",
                                 tag_titulo = "h1",
                                 tag_nota = ".a_b")) 

    ## # A tibble: 1 x 3
    ##   fecha          titulo                 nota                                    
    ##   <chr>          <chr>                  <chr>                                   
    ## 1 17 ene 2021 -~ Madrid: una semana en~ El portavoz de la Agencia Estatal de Me~

Resultó bien, pero ya tenemos un primer problema de normalización: el
formato de la fecha. Cuando miramos el tibble vemos que la variable
fecha es identificada y tratada como de tipo ‘chr’ (caracter). Debemos
transformarla en una variable de tipo ‘date’ (fecha). ¿Cómo lo hacemos?
Hay muchas formas. Acá vamos a hacerlo en dos pasos. Primero vamos a
quedarnos con los 11 caracteres iniciales (“dd mmm yyyy”) y luego
removemos los restantes. Finalmente, transformamos esos 11 caracteres en
un valor ‘date’ con la función `dmy()` del paquete `lubridate` de
`tidyverse`. Veamos cómo…

    # Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------
    require(lubridate)
    require(stringr)
    require(magrittr)
    fecha_sin_normalizar <- "16 ene 2021 - 23:30 UTC"   # creamos el objeto 'fecha_sin_normalizar'.
    (stringr::str_sub(fecha_sin_normalizar, 1, 11) %>%  # llamamos a la función str_sub() para quedarnos con los primeros 11 caracteres.   
      
      stringr::str_replace_all("ene", "jan") %>%        # llamamos a la función str_remplace_all() para cambiar la denominación de los mes.             
      stringr::str_replace_all("abr", "apr") %>% 
      stringr::str_replace_all("ago", "aug") %>% 
      stringr::str_replace_all("dic", "dec") %>% 
      
      lubridate::dmy() -> fecha_normalizada)            # finalmente llamamos a la función dmy() para transformar el string en un valor tipo 'date'.

    ## [1] "2021-01-16"

    base::class(fecha_normalizada)                      # examinamos su clase.

    ## [1] "Date"

Bien. Hemos logrado transformar la cadena de caracteres que contenía la
fecha en un valor que R reconoce y trata como ‘date’. Sin embargo,
seguimos con un problema no menor. Pudimos recuperar con al función
scraping\_notas() el contenido de una nota, pero la idea es recuperar el
contenido de un set completo de notas. Para lograrlo tendremos que hacer
uso de una nueva función de la familia tidyverse que perteneciente al
paquete `purrr`. Nos referimos a la función `pmap_dfr()`. Esta función
es una variante de la función `map()` de `purrr` que itera sobre
múltiples argumentos simultáneamente y en paralelo.

    # Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------
    require(dplyr)
    require(rvest)
    require(tibble)
    require(purrr)
    # Creamos la función para raspar los links a las notas cuyo nombre será 'scraping_links()' -------
    scraping_links <- function(pag_web, tag_link) {   # abro función para raspado web y le asigno un nombre: scraping_links
      
      rvest::read_html(pag_web) %>%                   # llamo a la función read_html() para obtener el contenido de la página
        
        rvest::html_elements(tag_link) %>%            # llamo a la función html_elements() y especifico las etiquetas de los títulos 
        
        rvest::html_attr("href") %>%                  # llamo a la función html_attr() para especificar el formato 'chr' del título.
        
        rvest::url_absolute(pag_web) %>%              # llamo a la función url::absolute() para completar las URLs relativas
        
        tibble::as_tibble() %>%                       # llamo a la función as_tibble() para transforma el vector en tabla
        
        dplyr::rename(link = value)                   # llamo a la función rename() para renombrar la variable 'value'
      
    }                                                 # cierro la función para raspado web
    # Usamos la función para scrapear los links a las notas de El País -------------------------------
    (links_EP  <- scraping_links(pag_web = "https://elpais.com/espana/", tag_link = "h2 a")) 

    ## # A tibble: 27 x 1
    ##    link                                                                         
    ##    <chr>                                                                        
    ##  1 https://elpais.com/espana/catalunya/2021-07-28/la-fiscalia-investiga-el-aval~
    ##  2 https://elpais.com/espana/2021-07-28/el-pp-desprecia-la-conferencia-de-presi~
    ##  3 https://elpais.com/espana/2021-07-28/los-delitos-de-odio-repuntan-hasta-alca~
    ##  4 https://elpais.com/espana/2021-07-28/el-parlament-respalda-a-torrent-y-tilda~
    ##  5 https://elpais.com/espana/2021-07-28/la-abogacia-del-estado-defendio-ante-el~
    ##  6 https://elpais.com/espana/2021-07-28/el-matrimonio-ruso-kokorev-vendio-679-m~
    ##  7 https://elpais.com/espana/2021-07-28/el-97-de-los-menores-migrantes-acogidos~
    ##  8 https://elpais.com/espana/2021-07-28/urkullu-ira-a-la-conferencia-de-preside~
    ##  9 https://elpais.com/espana/2021-07-28/jubilado-por-incapacidad-permanente-el-~
    ## 10 https://elpais.com/espana/2021-07-28/el-juez-deja-a-un-paso-del-banquillo-a-~
    ## # ... with 17 more rows

    # Creamos la función para raspar El País cuyo nombre será 'scraping_links()' ---------------------
    scraping_notas <- function(pag_web, tag_fecha, tag_titulo, tag_nota) { # abro función para raspado web: scraping_notas().
      
      tibble::tibble(                               # llamo a la función tibble.
      
      fecha = rvest::html_elements(                 # declaro la variable fecha y llamo a la función html_elements().
        
        rvest::read_html(pag_web), tag_fecha) %>%   # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) de la fecha. 
        
        rvest::html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' de la fecha.
      
      titulo = rvest::html_elements(                # declaro la variable titulo y llamo a la función html_elements().
        
        rvest::read_html(pag_web), tag_titulo) %>%  # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) del titulo.  
        
        rvest::html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' del título.
      
      nota = rvest::html_elements(                  # declaro la variable nota y llamo a la función html_elements(). 
        
        rvest::read_html(pag_web), tag_nota) %>%    # llamo a la función html_elements() y especifico la(s) etiqueta(s) de la nota. 
        
        rvest::html_text()                          # llamo a la función html_text() para especificar el formato 'chr' del título.
      
      )                                             # cierro la función tibble().
      
    }                                               # cierro la función para raspado web.
    # Seleccionamos los links que refieren a la sección que nos interesa y nos quedamos solo con 10 notas --------
    (links_EP_limpio <- links_EP %>% filter(str_detect(link, "https://elpais.com/espana/")) %>% filter(!str_detect(link,"en-clave-de-bienestar")) %>% .[1:10,])

    ## # A tibble: 10 x 1
    ##    link                                                                         
    ##    <chr>                                                                        
    ##  1 https://elpais.com/espana/catalunya/2021-07-28/la-fiscalia-investiga-el-aval~
    ##  2 https://elpais.com/espana/2021-07-28/el-pp-desprecia-la-conferencia-de-presi~
    ##  3 https://elpais.com/espana/2021-07-28/los-delitos-de-odio-repuntan-hasta-alca~
    ##  4 https://elpais.com/espana/2021-07-28/el-parlament-respalda-a-torrent-y-tilda~
    ##  5 https://elpais.com/espana/2021-07-28/la-abogacia-del-estado-defendio-ante-el~
    ##  6 https://elpais.com/espana/2021-07-28/el-matrimonio-ruso-kokorev-vendio-679-m~
    ##  7 https://elpais.com/espana/2021-07-28/el-97-de-los-menores-migrantes-acogidos~
    ##  8 https://elpais.com/espana/2021-07-28/urkullu-ira-a-la-conferencia-de-preside~
    ##  9 https://elpais.com/espana/2021-07-28/jubilado-por-incapacidad-permanente-el-~
    ## 10 https://elpais.com/espana/2021-07-28/el-juez-deja-a-un-paso-del-banquillo-a-~

    # Usamos la función pmap_dfr() para emparejar los links y la función de web scraping y creamos el objeto el_pais_esp con las 10 notas completas
    (el_pais_esp <-                     # abrimos la función print '(' y asignamos un nombre al objeto que vamos a crear.
        
        purrr::pmap_dfr(                # llamamos a la función pmap_dfr() para emparejar links y función de rascado.
          
          base::list(                   # Llamamos a la función list() para crear una lista con los múltiples argumentos de la función de rascado.
            
            links_EP_limpio$link,       # vector de links.
            
            ".a_ti",                    # etiqueta de fecha.
            
            "h1",                       # etiqueta de título.
            
            ".a_b"),                    # etiqueta de nota y cierro la función list().
          
          scraping_notas))              # función scraping_notas() sin los `()` y cierro la función pmap_dfr() y la función print `)`.

    ## # A tibble: 10 x 3
    ##    fecha        titulo                           nota                           
    ##    <chr>        <chr>                            <chr>                          
    ##  1 28 jul 2021~ "La Fiscalía investiga el aval ~ "El aval concedido por la Gene~
    ##  2 28 jul 2021~ "El PP desprecia la Conferencia~ "El PP no considera la XVIII C~
    ##  3 28 jul 2021~ "Los delitos de odio repuntan h~ "El aumento de noticias sobre ~
    ##  4 28 jul 2021~ "El Parlament respalda a Torren~ "La junta de portavoces del Pa~
    ##  5 28 jul 2021~ "La abogacía del Estado defendi~ "El extesorero del PP Luis Bár~
    ##  6 28 jul 2021~ "El matrimonio ruso Kokorev ven~ "Vladimir Kokorev durante la v~
    ##  7 28 jul 2021~ "El 97% de los menores migrante~ "Uno de los menores rescatados~
    ##  8 28 jul 2021~ "Urkullu irá a la Conferencia d~ "El lehendakari, Iñigo Urkullu~
    ##  9 28 jul 2021~ "El Poder Judicial jubila por i~ "El juez Manuel Penalva en los~
    ## 10 28 jul 2021~ "El juez deja a un paso del ban~ "El empresario Javier López Ma~

    # Usamos la función para scrapear los links a las notas de La Nación -------------------------------
    (links_LN <- scraping_links(pag_web = "https://www.lanacion.com.ar/politica", tag_link = "h2 a"))

    ## # A tibble: 30 x 1
    ##    link                                                                         
    ##    <chr>                                                                        
    ##  1 https://www.lanacion.com.ar/politica/denuncian-penalmente-a-alberto-fernande~
    ##  2 https://www.lanacion.com.ar/politica/elisa-carrio-redoblo-el-ataque-contra-f~
    ##  3 https://www.lanacion.com.ar/politica/tras-la-escalada-entre-facundo-manes-y-~
    ##  4 https://www.lanacion.com.ar/politica/sergio-palazzo-pide-debatir-la-reduccio~
    ##  5 https://www.lanacion.com.ar/politica/gildo-insfran-de-las-medidas-sanitarias~
    ##  6 https://www.lanacion.com.ar/politica/alberto-fernandez-aprovecha-su-visita-a~
    ##  7 https://www.lanacion.com.ar/politica/hay-casi-7-millones-de-dosis-distribuid~
    ##  8 https://www.lanacion.com.ar/politica/un-gobierno-que-no-dice-la-verdad-nid27~
    ##  9 https://www.lanacion.com.ar/politica/duro-cruce-en-el-senado-por-la-candidat~
    ## 10 https://www.lanacion.com.ar/politica/nadie-puede-creer-que-esta-decision-fue~
    ## # ... with 20 more rows

    # Usamos la función para scrapear las notas de La Nación. Replicamos todo en una sola línea de código.
    (la_nacion_ar <- purrr::pmap_dfr(list(links_LN$link[1:10],".com-date.--twoxs",".com-title.--threexl",".col-12 p"), scraping_notas)) # "section.fecha","h1.titulo","#cuerpo p" scraping_notas))

    ## # A tibble: 105 x 3
    ##    fecha       titulo                           nota                            
    ##    <chr>       <chr>                            <chr>                           
    ##  1 28 de juli~ Denuncian penalmente a Alberto ~ "Yamil Santoro, precandidato a ~
    ##  2 28 de juli~ Denuncian penalmente a Alberto ~ "La denuncia que quedo radicada~
    ##  3 28 de juli~ Denuncian penalmente a Alberto ~ "Acaba de ingresar una denuncia~
    ##  4 28 de juli~ Denuncian penalmente a Alberto ~ "En la presentación judicial, a~
    ##  5 28 de juli~ Denuncian penalmente a Alberto ~ "Pacchi es una modelo que tiene~
    ##  6 28 de juli~ Denuncian penalmente a Alberto ~ ""                              
    ##  7 28 de juli~ Elisa Carrió redobló el ataque ~ "Elisa Carrió quedó dolida con ~
    ##  8 28 de juli~ Elisa Carrió redobló el ataque ~ "“Estoy harta de las mentiras”,~
    ##  9 28 de juli~ Elisa Carrió redobló el ataque ~ "“Cuando yo miento descaradamen~
    ## 10 28 de juli~ Elisa Carrió redobló el ataque ~ "La exdiputada nacional advirti~
    ## # ... with 95 more rows

    # Guardamos el objeto 'la_nacion_ar' como objeto .rds
    base::saveRDS(la_nacion_ar, "la_nacion_ar.rds")

Bueno, parece que finalmente realizamos todos los pasos para hacer un
web scraping completo. Pero esto no termina aquí. Seguro notaron que las
notas se trasformaron de 10 a 100, esto puede ser contraproducente en el
momento del análisis. Tenemos que normalizar la base. ¡Hagámoslo!

    # Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------
    require(dplyr)
    require(rvest)
    require(tibble)
    require(stringr)
    require(tidyr)
    require(lubridate)
    # Cargamos el objeto la_nacion_ar.
    la_nacion_ar <- base::readRDS("la_nacion_ar.rds")
    # Imprimimos en consola sus valores completos, las notas completas.
    la_nacion_ar$nota[1:30] # los corchetes me permiten seleccionar los valores según su número de fila

    ##  [1] "Yamil Santoro, precandidato a legislador porteño en la lista de Ricardo López Murphy, anunció hoy que el presidente Alberto Fernández fue denunciado penalmente junto con la modelo Sofía Pacchi por “violaciones a las normas” dispuestas en el marco de la pandemia del coronavirus luego de la filtración de listas con visitas a la Quinta de Olivos. “Tendrán que explicar en la Justicia qué hacían”, advirtió Santoro."                                                                                                                                                                                                                                                                                                                                                                              
    ##  [2] "La denuncia que quedo radicada en el Juzgado Criminal y Correccional Federal N°7 a cargo del juez Casanello y fue realizada por Marcos Longoni y Abril Férnandez Soto, dos dirigentes juveniles de Republicanos Unidos y presentada con el patrocinio del abogado Juan Martín Fazio."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
    ##  [3] "Acaba de ingresar una denuncia penal contra @alferdez y Sofia Pacchi por las múltiples violaciones a las normas sanitarias. Fue formulada por dos dirigente juveniles de @repunidosCABA, @Marcos_Longoni y @abriifer. Tendrán que explicar en la Justicia que hacían."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    ##  [4] "En la presentación judicial, a la que LA NACION tuvo acceso, los denunciantes piden que se investigue si Fernández y Pacchi, quien habría visitado Olivos en reiteradas oportunidades, incumplieron el artículo 205 del Código Penal en el contexto del Aislamiento Social Preventivo y Obligatorio (ASPO) que comenzó en marzo del año pasado. Quienes incumplían la cuarentena podían ser imputados con este artículo que reprime con “reclusión o prisión de tres a quince años” al que “propagare una enfermedad peligrosa y contagiosa para las personas”. En la misma además se detallan algunas de los supuestos ingresos de Pacchi en la quinta presidencial."                                                                                                                                      
    ##  [5] "Pacchi es una modelo que tiene relación con Fabiola Yáñez, la pareja del Presidente. En los registros de ingreso a Olivos, Pacchi figura en varias oportunidades y en horarios diversos. Fue designada en planta permanente de la Secretaría General de la Presidencia el 31 de agosto de 2020, según consta en la denuncia judial. "                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
    ##  [6] ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    ##  [7] "Elisa Carrió quedó dolida con Facundo Manes. Hoy, volvió a cuestionar con dureza al precandidato a diputado Facundo Manes quien aseguró a LA NACION que la líder de la Coalición Cívica (CC)-Ari, le pidió que la secundara en la fórmula hacia la Casa Rosada, en 2015. Además de desmentir sus dichos otra vez, Carrió disparó: “Le causó daño a [Horacio Rodríguez] Larreta sin necesidad”."                                                                                                                                                                                                                                                                                                                                                                                                             
    ##  [8] "“Estoy harta de las mentiras”, replicó la exdiputada en diálogo con LN+. “Nunca contesto una opinión, jamás he querellado a nadie por un agravio, en todo caso un delito de opinión sobre otra persona, pero lo que sí creo, sobre todo en el conocimiento científico, religioso y práctico, y en las relaciones familiares, que la primera regla que existe con el otro es no mentir”, señaló Carrió al ser consultada por las recientes declaraciones del precandidato a diputado Facundo Manes."                                                                                                                                                                                                                                                                                                         
    ##  [9] "“Cuando yo miento descaradamente sobre los hechos, tengo un problema de salud mental o estoy repitiendo el modelo cristinista de mentir hasta que se crea algo”, acusó la líder de la Coalición Cívica."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
    ## [10] "La exdiputada nacional advirtió en referencia a Manes: “Dicen que son la nueva política, pero llevan en la lista a Jesús Cariglino y a Stolbizer”."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
    ## [11] "A lo largo de la entrevista, Carrió volvió a negar la afirmación del médico, que dijo que la exdiputada fue a su casa a ofrecerle una vicepresidencia en la fórmula hacia la Casa Rosada, en 2015. “Si recuerdan Manes estaba con el radicalismo, con Ernesto Sanz y yo, que soy parte de la Coalición Cívica, estaba con Toty Flores, mi candidato a vice desde 2013. Nunca pude pedirle algo así”, aclaró Carrió."                                                                                                                                                                                                                                                                                                                                                                                        
    ## [12] "La líder de la Coalición Cívica contó que en aquella oportunidad quien la invitó a la casa de Manes fue Toty Flores, aunque, según sostuvo, ella “no quería ir”. Y en ese sentido, sumó: “Nunca le hubiera pedido a Manes [la vicepresidencia] por razones que no tengo que explicar”."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
    ## [13] "Manes competirá en la interna bonaerense con Diego Santilli, del Pro, el candidato de Larreta."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    ## [14] "Noticia en desarrollo"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    ## [15] ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    ## [16] "Los primeros chispazos de la interna entre el Pro y la UCR en la provincia de Buenos Aires encendieron las luces de alarma en Juntos por el Cambio. El cruce de acusaciones entre el médico Facundo Manes, quien se medirá Diego Santilli en las PASO del 12 de septiembre, Elisa Carrió (CC) y espadas del macrismo exhibió la dificultad que enfrenta la principal coalición opositora, en plena etapa de reconfiguración de liderazgos, para unificar un mensaje de campaña y coordinar la estrategia electoral. Y aceleraron la elaboración de un “reglamento de convivencia” para las primarias."                                                                                                                                                                                                      
    ## [17] "Como adelantó LA NACION, La idea de confeccionar “un manual de buenas prácticas” ya había sido consensuada durante la última reunión de la mesa nacional del conglomerado opositor, pero se reactivó tras el cimbronazo que generó el pedido de Manes al jefe de gobierno, Horacio Rodríguez Larreta, para que no utilice fondos de la Ciudad (“espero que no usen impuestos de los porteños”) en la campaña. Sus dichos provocaron una dura reacción de Cristian Ritondo, jefe de bloque de Pro en Diputados. A su vez, Carrió tildó de “mitómano” al neurólogo y neurocientífico, luego de que Manes dijera en una entrevista con este medio que la líder de la CC le ofreció ser candidato a vicepresidente en 2015."                                                                                    
    ## [18] "Tras los cruces en el arranque de la campaña en la provincia, hubo contactos entre las autoridades de Pro, la UCR y la CC para aquietar las aguas. “Hay mucha preocupación y temor en el Pro porque les gusta tener todo controlado”, comenta un referente del radicalismo."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    ## [19] "Por estas horas, la titular de Pro, Patricia Bullrich, trabaja en el texto del reglamento de “convivencia” y “buenas prácticas” para las primarias de Juntos por el Cambio en todo el país. También hubo diálogos entre los integrantes la cúpula de la alianza para discutir sobre el nombre y los colores que tendrá el espacio en algunos distritos del país."                                                                                                                                                                                                                                                                                                                                                                                                                                           
    ## [20] "“El manual no va a servir para nada. A Facundo no lo van a controlar. No va a tener ningún problema en decir que la gestión de Vidal fue la que más recortó en educación”, desafía un dirigente de peso del radicalismo. “Nos tenemos que concentrar en el objetivo: nuestro adversario es el kirchnerismo”, señalan desde la CC."                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
    ## [21] "Para evitar tensiones, Bullrich prefirió mantenerse al margen de los cruces que provocaron en la fuerza las primeras intervenciones mediáticas de Manes. Por su rol en la coalición y en Pro, la exministra de Seguridad busca ser “garante” de las buenas prácticas en las internas. “Si me pongo a opinar, voy a entrar en el barro, y no quiero eso”, afirmó a LA NACION la jefa del partido fundado por Mauricio Macri. Allegados a Santilli avisan que no le contestarán a Manes para “no subirle el precio” al tema: “Las chicanas te alejan de la gente”."                                                                                                                                                                                                                                           
    ## [22] "Según fuentes del radicalismo, el presidente de la UCR, Alfredo Cornejo, se contactó con Manes y Bullrich tras el affaire. Cerca del médico se muestran satisfechos con los resultados de sus primeras apariciones en los medios. De hecho, remarcan que las declaraciones de Manes sirvieron para “marcarle la cancha” al Pro y a Rodríguez Larreta. “Ahora, no van a poder hacer una campaña millonaria, porque están expuestos”, evalúan en el pelotón del médico. Repiten que el médico no saldrá a contestar las críticas de Carrió ni del macrismo y que intentará “salir por arriba de la grieta” con su discurso “moderno” de la campaña. “A Facundo no lo pueden agarrar con nada porque no es un político tradicional. Está muy fuerte y muy activo”, señala uno de sus interlocutores en la UCR."
    ## [23] "En la cúpula del partido centenario ya circulan las teorías conspirativas por el primer round de la campaña: perciben que Larreta estuvo detrás de la embestida de Carrió contra Manes. Vieron, cuenta un dirigente del espacio, una acción coordinada en redes para replicar los dichos del médico, quien ratificó que la líder de la CC le ofreció secundarlo en la fórmula en 2015. Lilita lo niega. “La reacción de Carrió fue desmedida”, apuntan cerca de uno de los caciques de la UCR."                                                                                                                                                                                                                                                                                                             
    ## [24] "Para su primera incursión electoral en Buenos Aires, Manes armó una mesa política con sus principales aliados para la interna de Pro: Maximiliano Abad, titular de la UCR bonaerense, Emilio Monzó, Joaquín de la Torre y Margarita Stolbizer (GEN). En tanto, la politóloga Ana Iparraguirre quedó a cargo de la coordinación de los equipos técnicos de la campaña. Por estas horas, la tropa del médico para la batalla electoral con el Pro define la hoja de ruta de Manes. Es probable que dé el puntapié inicial de la campaña en Salto, donde vivió durante su infancia y adolescencia, y que visite Chacabuco, Junín, Mar del Plata, entre otros distritos, durante los próximos días."                                                                                                            
    ## [25] "Con la mira en el conurbano bonaerense, donde cree que le sacará ventaja a Manes en la interna, Santilli activó a sus equipos para la contienda. Su jefe de campaña es Néstor Grindetti, intendente de Lanús, quien quedó al frente de la mesa de política y estratégica que integran Diego Valenzuela (Tres de Febrero), Jorge Macri (Vicente López), Julio Garró (La Plata), Maricel Etchecoin (CC), Ritondo (Pro) y Gerardo Milman (Pro), entre otros. En el comité de discurso y estrategia aparecen dos espadas de Larreta: Christian Coelho y Federico Di Benedetto, a cargo de las encuestas."                                                                                                                                                                                                       
    ## [26] "Para coordinar el mensaje de campaña, los colaboradores de Santilli harán reuniones con los 15 primeros precandidatos de su lista. Los ejes discursivos serán la seguridad, la educación, el empleo, la producción y temas institucionales. También mantendrán al tanto de la estrategia a Carrió, Bullrich y Cornejo, entre otros. A su vez, planean segmentar el mensaje para cada sección electoral."                                                                                                                                                                                                                                                                                                                                                                                                    
    ## [27] "Durante las últimas 48 horas, Santilli ya pasó por La Matanza y Hurlingham. Y recorrió esta mañana Lanús, en la tercera sección electoral, junto a Larreta y Grindetti. “Responder chicanas lo único que hace es ayudar al kirchnerismo”, lanzó Santilli tras la actividad. Mensaje a Manes."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
    ## [28] "En el pelotón de Santilli hubo preocupación por los cruces por los dichos de Manes y los tironeos internos. “Nos puede desperfilar”, admiten. Además, consideran que será complicado manejar los “egos” de las figuras de Juntos en una campaña atípica para el espacio. Es que por primera vez lidia con el desafío de competir en los comicios sin que Marcos Peña o Jaime Durán Barba, quien manejaban la comunicación de Pro, bajen los lineamientos y coordinen el mensaje de la coalición."                                                                                                                                                                                                                                                                                                           
    ## [29] "Por ahora, la interna de Juntos por el Cambio en la Capital navega por aguas más calmas –más allá de la polémica por los tuits de Sabrina Ajmechet sobre Malvinas–. Anteayer, se reunió la mesa de campaña de Vidal para trazar los lineamientos discursivos y la estrategia política para las PASO. Se sentaron Fernando Straface, jefe de campaña de Vidal; Federico Salvai, mano derecha de la exgobernadora; Emmanuel Ferrario, a cargo de la coordinación operativa; Maximiliano Ferraro (CC), Emiliano Yacobitti (UCR) y Di Benedetto, un funcionario clave para Larreta."                                                                                                                                                                                                                            
    ## [30] "En las primarias de septiembre, Vidal se medirá con Ricardo López Murphy (Republicanos Unidos) y Adolfo Rubinstein (Adelante Ciudad). El exministro de Economía arrancó la campaña con una frase sobre la cifra de desaparecidos en la última dictadura que generó ruidos internos. Cerca del “bulldog” aseguran que tendrá total libertad narrativa y discursiva para la interna. “Fue una de las condiciones que puso Ricardo para ingresar a Juntos por el Cambio”, cuentan desde su entorno."

    # Detectamos que hay algunas filas que son recurrente y debemos borrar:
       # "Celdas vacías"
    # Con el uso del paquete stringr vamos a remover estos fragmentos de información no útil.
    (la_nacion_ar_limpia <- la_nacion_ar %>%                                  # creamos un nuevo objeto clase tibble.
        
        dplyr::mutate(nota = stringr::str_trim(nota)) %>%                     # con las funciones mutate() y str_trim() quitamos los espacios en blanco sobrantes.
        
        dplyr::filter(nota != ""))                                            # con la función filter() descartamos las celdas vacías.

    ## # A tibble: 95 x 3
    ##    fecha       titulo                           nota                            
    ##    <chr>       <chr>                            <chr>                           
    ##  1 28 de juli~ Denuncian penalmente a Alberto ~ Yamil Santoro, precandidato a l~
    ##  2 28 de juli~ Denuncian penalmente a Alberto ~ La denuncia que quedo radicada ~
    ##  3 28 de juli~ Denuncian penalmente a Alberto ~ Acaba de ingresar una denuncia ~
    ##  4 28 de juli~ Denuncian penalmente a Alberto ~ En la presentación judicial, a ~
    ##  5 28 de juli~ Denuncian penalmente a Alberto ~ Pacchi es una modelo que tiene ~
    ##  6 28 de juli~ Elisa Carrió redobló el ataque ~ Elisa Carrió quedó dolida con F~
    ##  7 28 de juli~ Elisa Carrió redobló el ataque ~ “Estoy harta de las mentiras”, ~
    ##  8 28 de juli~ Elisa Carrió redobló el ataque ~ “Cuando yo miento descaradament~
    ##  9 28 de juli~ Elisa Carrió redobló el ataque ~ La exdiputada nacional advirtió~
    ## 10 28 de juli~ Elisa Carrió redobló el ataque ~ A lo largo de la entrevista, Ca~
    ## # ... with 85 more rows

    # Ahora colapsaremos los párrafos de cada nota en una sola celda, de esta forma volveremos a un tibble de 10 filas (observaciones), una por nota.
    (la_nacion_ar_limpia_norm <- la_nacion_ar_limpia %>%                                # creamos un nuevo objeto clase tibble.
        
      dplyr::group_by(fecha, titulo) %>%                                                # con la función group_by() agrupamos por fecha y título.
        
      dplyr::summarise(nota_limpia = base::paste(nota, collapse = " ||| ")) %>%         # con las funciones summarise() y paste() colapsamos los párrafos.
      
      dplyr::select(fecha, titulo, nota_limpia) %>%                                     # con la función select() seleccionamos las variables. 
      
      dplyr::mutate(fecha = lubridate::dmy(fecha)))                                     # con las funciones mutate() y dmy() le damos formato date al string de fechas.

    ## # A tibble: 10 x 3
    ## # Groups:   fecha [1]
    ##    fecha      titulo                          nota_limpia                       
    ##    <date>     <chr>                           <chr>                             
    ##  1 2021-07-28 "“Nadie puede creer que esta d~ El viceministro de Justicia y Der~
    ##  2 2021-07-28 "Alberto Fernández aprovecha s~ Una reunión matinal con su amigo,~
    ##  3 2021-07-28 "Denuncian penalmente a Albert~ Yamil Santoro, precandidato a leg~
    ##  4 2021-07-28 "Duro cruce en el Senado por l~ El tratamiento del pliego de la c~
    ##  5 2021-07-28 "Elisa Carrió redobló el ataqu~ Elisa Carrió quedó dolida con Fac~
    ##  6 2021-07-28 "Gildo Insfrán, de las medidas~ Cuestionado por la oposición y co~
    ##  7 2021-07-28 "Hay casi 7 millones de dosis ~ La ministra de Salud, Carla Vizzo~
    ##  8 2021-07-28 "Sergio Palazzo pide debatir l~ Sergio Palazzo, el jefe del gremi~
    ##  9 2021-07-28 "Tras la escalada entre Facund~ Los primeros chispazos de la inte~
    ## 10 2021-07-28 "Un gobierno que no dice la ve~ El gobierno del presidente Albert~

    # Imprimimos en consola sus valores completos, las notas completas.
    la_nacion_ar_limpia_norm$nota_limpia[1:10] # los corchetes me permiten seleccionar los valores según su número de fila

    ##  [1] "El viceministro de Justicia y Derechos Humanos, Juan Martín Mena, aseguró hoy que “documentalmente está probado” el contrabando de armas a Bolivia en el que habría incurrido en noviembre de 2019 la gestión de Mauricio Macri tres días después de la caída de Evo Morales. Por este hecho, el Gobierno denunció en la Justicia al expresidente y a los exministros Patricia Bullrich (Seguridad) y Oscar Aguad (Defensa). ||| ”Creo que Macri y Bullrich están complicados para defenderse. Tienen que decir quien fue el que tomó la decisión de contrabandear armas. Documentalmente, el hecho está probado. Sólo falta saber quiénes fueron todos los responsables”, afirmó Mena en diálogo con El Destape Radio. En ese sentido, agregó: “Nadie puede creer que esa decisión fuese tomada por un grupito de gendarmes”. ||| La reacción del funcionario kirchnerista se da luego de la revelación de LA NACION, que informó ayer que durante la gestión de Alberto Fernández se extendió dos veces la autorización del material bélico enviado a Bolivia. Así se desprende de la propia documentación aportada por el actual gobierno en el marco de la denuncia contra Macri, donde consta que hubo prórrogas en enero y mayo de 2020, bajo el argumento de proteger la Embajada argentina en el país vecino. ||| Los documentos exhiben autorizaciones emitidas por la Agencia Nacional de Materiales Controlados (Anmac) ante pedidos de prórroga que hizo la Gendarmería los días 14 de enero y 23 de abril de 2020. Fuentes del Ministerio de Justicia apuntaron que “la Anmac, ante este tipo de pedidos formales, se limita a autorizar la prórroga a pedido de las Fuerzas de Seguridad” y que “fue una parte del intento de encubrimiento de la entrega ilegal de material bélico a la Fuerza Aérea y a la Policía Boliviana”. Los documentos de la Anmac fueron firmados por Ana Rulli y Daniel Mondelo. ||| ”Esto fue una decisión a máxima escala de Gobierno, no hay forma de que dos ministros se pongan a conspirar y fomentar un golpe de estado en la región sin que lo sepa el presidente. Me parece que es una cuestión de sentido común, pero que tendrá que ser probada judicialmente”, argumentó Mena. ||| El funcionario, además, se refirió a la denuncia contra el expresidente y los exministros. ”Es increíble que ni siquiera hayan podido ensayar una respuesta en 20 días y apelen ahora a cualquier artilugio relacionado con la campaña. Evidentemente, no pueden dar ninguna respuesta porque no se quieren despegar de sus aliados políticos”, advirtió. ||| Por otra parte, el viceministro de Justicia recordó que “no está mal” enviar seguridad a la embajada de un país en crisis, pero “lo que es cuestionable es usar esa excusa” para desviar armas a otra fuerza. ”De ninguna manera ese material se había usado en un entrenamiento del grupo Alacrán. Eso es disparatado. La unidad de gendarmes que llegó a Bolivia en esos días estaba compuesta por once personas que estaban custodiando la embajada en plena crisis, con un gobierno de facto que reprimía al pueblo. En esa situación no se podía salir para hacer prácticas de tiro”, fundamentó. ||| Además, Mena consideró que Macri “evidentemente está preocupado por esta causa” y que por eso “salió a pedir ayuda afuera” en referencia al apoyo que recibió ayer a través de un comunicado por parte de expresidentes de la Iniciativa Democrática de España y las Américas (IDEA). ”Hace bien en preocuparse porque es de una gravedad mayúscula. Es la causa más grave que actualmente pesa sobre su gobierno. Sabemos de la existencia de investigaciones sobre hechos de corrupción, pero pareciera que no hay consciencia de la gravedad que tiene este hecho”, sintetizó el funcionario."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
    ##  [2] "Una reunión matinal con su amigo, el canciller uruguayo Francisco Bustillo, en tiempos de áspera convivencia entre la Argentina y sus socios del Mercosur. Bilaterales con sus pares Guillermo Lasso, de Ecuador, e Iván Duque, de Colombia, ambos distanciados de su política internacional y regional. Serán estos los encuentros fuera de agenda de Alberto Fernández en su visita a Perú, adonde llegó en la noche del martes para la asunción del maestro Pedro Castillo como nuevo presidente de ese país. ||| Los encuentros del Presidente con representantes de tres países “conflictivos” contrastan con el objetivo central del viaje: dar un espaldarazo inicial a Castillo, que derrotó a Keiko Fujimori en el ballottage y que es considerado nuevo integrante de la “Patria Grande”, una alianza regional que Fernández pretende comandar y en el que también se incluyen la Bolivia de Luis Arce y México, de Andrés Manuel López Obrador. ||| En relación a Bustillo, y más allá de la amistad personal que los une-Fernández se instaló en la residencia del entonces embajador uruguayo en España, en septiembre de 2019, mientras esquivaba al entonces embajador argentino Ramón Puerta- el encuentro “entre amigos” , como lo definieron cerca del Presidente, sirvió para descomprimir un vínculo tensado por la decisión de Uruguay de comenzar de manera unilateral a negociar acuerdos por fuera del Mercosur. Desde la Cancillería afirmaron a LA NACION que el gobierno de Lacalle Pou “se quedó solo” en esa postura, y señalaron que en el reciente encuentro del canciller Felipe Solá y su par de Brasil, Carlos França, se acordó en “dejar de lado los temas conflictivos y poner el acento en los temas que nos unen”. ||| Con el ecuatoriano Lasso, en tanto, la foto común-distribuida por el Gobierno-también sirve para intentar regenerar el vínculo, luego del explícito apoyo del kirchnerismo al correista Andrés Arauz, que incluso hizo campaña prometiendo que la Argentina le proveería vacunas para luchar contra el coronavirus. ||| “Aun cuando muchos nos paran en veredas diferentes, la verdad es que las diferencias no son tantas a la hora de ver cómo concretamos los objetivos. Tenemos que lograr respetarnos en la diversidad y trabajar juntos por eso que necesita América latina que es la unidad, lograr un espacio donde podamos discutir nuestro destino”, afirmó el mandatario argentino luego del encuentro con Lasso, quien lo invitó a visitar Ecuador el mes que viene. Fernández se declaró “en deuda con el Presidente Lasso” por no haber podido estar en su asunción, y calificó la reunión de “mucho más que productiva”. ||| La reunión con Duque, llevada a cabo después de la asunción oficial de Castillo en el Palacio del Congreso de Lima, también surge luego de las desavenencias públicas en torno a las protestas sociales en Colombia. Fernández habló entonces de “violencia institucional” y recibió una dura réplica del gobierno colombiano, a través de su embajador en Argentina, Alvaro Pava Camelo, quien en una entrevista con LA NACION afirmó que “la intromisión no es bienvenida”. Colombia y Argentina compitieron, días atrás, por la presidencia de la Corporación Andina de Fomento (CAF), finalmente otorgada al colombiano Sergio Díaz Granados, quien logró más adhesiones por sobre el argentino Christian Asinelli. ||| El Presidente extenderá hasta mañana su estada en Lima, y lo acompañan, además de su pareja Fabiola Yañez, una comitiva que integran el canciller Felipe Solá, y la ministra de Mujeres, Género y Diversidad, Elizabeth Gómez Alcorta; los secretarios General de la Presidencia, Julio Vitobello, de Asuntos Estratégicos, Gustavo Béliz, de Comunicación y Prensa, Juan Pablo Biondi, y el diputado nacional Eduardo Valdés."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    ##  [3] "Yamil Santoro, precandidato a legislador porteño en la lista de Ricardo López Murphy, anunció hoy que el presidente Alberto Fernández fue denunciado penalmente junto con la modelo Sofía Pacchi por “violaciones a las normas” dispuestas en el marco de la pandemia del coronavirus luego de la filtración de listas con visitas a la Quinta de Olivos. “Tendrán que explicar en la Justicia qué hacían”, advirtió Santoro. ||| La denuncia que quedo radicada en el Juzgado Criminal y Correccional Federal N°7 a cargo del juez Casanello y fue realizada por Marcos Longoni y Abril Férnandez Soto, dos dirigentes juveniles de Republicanos Unidos y presentada con el patrocinio del abogado Juan Martín Fazio. ||| Acaba de ingresar una denuncia penal contra @alferdez y Sofia Pacchi por las múltiples violaciones a las normas sanitarias. Fue formulada por dos dirigente juveniles de @repunidosCABA, @Marcos_Longoni y @abriifer. Tendrán que explicar en la Justicia que hacían. ||| En la presentación judicial, a la que LA NACION tuvo acceso, los denunciantes piden que se investigue si Fernández y Pacchi, quien habría visitado Olivos en reiteradas oportunidades, incumplieron el artículo 205 del Código Penal en el contexto del Aislamiento Social Preventivo y Obligatorio (ASPO) que comenzó en marzo del año pasado. Quienes incumplían la cuarentena podían ser imputados con este artículo que reprime con “reclusión o prisión de tres a quince años” al que “propagare una enfermedad peligrosa y contagiosa para las personas”. En la misma además se detallan algunas de los supuestos ingresos de Pacchi en la quinta presidencial. ||| Pacchi es una modelo que tiene relación con Fabiola Yáñez, la pareja del Presidente. En los registros de ingreso a Olivos, Pacchi figura en varias oportunidades y en horarios diversos. Fue designada en planta permanente de la Secretaría General de la Presidencia el 31 de agosto de 2020, según consta en la denuncia judial."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    ##  [4] "El tratamiento del pliego de la candidata propuesta por el Gobierno para ocupar una vocalía en la Cámara Comercial, que deberá entender en la causa de la quiebra del Correo, provocó un duro debate entre oficialismo y oposición en la Comisión de Acuerdos del Senado, con acusaciones cruzadas de persecución ideológica a la postulante y de manejo político de expedientes judiciales para perjudicar al expresidente Mauricio Macri. ||| El pliego de la polémica fue el de María Guadalupe Vázquez, postulada por el Poder Ejecutivo para la Sala B de la Cámara de Apelaciones Comercial de la Capital Federal. El tribunal tendrá que resolver en la causa del Correo, luego de que la jueza Marta Cirulli decretara su quiebra a pesar de que el grupo Socma ofreció pagar el total de la deuda que la empresa mantiene con el Estado. ||| La polémica estalló cuando el radical Julio Martínez (La Rioja), tras preguntarle si había trabajado con la fiscal Gabriela Boquín, que llevó la causa del Correo en primera instancia, le consultó a Vázquez si en un concurso el juez podía denegarle al deudor una oferta por el pago total de su deuda. ||| La intervención provocó la reacción inmediata de varios senadores del Frente de Todos, que pidieron la palabra para criticar las preguntas de Martínez y solicitarle a Vázquez que se abstuviera de responderlas. ||| “Le pido al senador Martínez que retire la pregunta, porque soslaya una actitud casi de inteligencia; porque, además, no corresponde preguntarle a un postulante sobre un caso concreto”, reclamó el kirchnerista Oscar Parrilli (Neuquén). ||| En ese sentido, el senador oficialista agregó: “Está claramente preguntándole si es macrista o no es macrista y si apoya o no la solución que el Correo Argentino le propuso a los acreedores”. El neuquino también acusó al senador radical de adoptar “una actitud claramente persecutoria del Poder Judicial” por haberle preguntado a la postulante si también había trabajado con la exprocuradora general de la Nación Alejandra Gils Carbó. ||| “Nunca se ha hecho este tipo de preguntas en la Comisión de Acuerdos: poner a prueba lo que pueda actuar en determinados casos”, sumó su queja el jefe de la bancada kirchnerista, José Mayans (Formosa). ||| El líder oficialista de la Cámara alta le pidió a la candidata que no contestara las consultas, de las que dijo que tenían “intencionalidad de defensas solapadas” al expresidente Macri. ||| Martínez redobló la apuesta e insistió con sus consultas, tras lo cual rechazó los pedidos de los senadores oficialistas. “No tengo que pedir permiso para hacer una pregunta; ellos se refieren a un fallo claramente penetrado por la política al cual yo no hice mención; sólo pregunté por un tema teórico”, se defendió. ||| “El senador está politizando la pregunta en función de la quiebra del Correo Argentino y le está haciendo preguntas concretas que pueden llevar a que la postulante sea recusada por adelantar opinión”, le contestó el oficialista Mario Pais (Chubut). ||| El radical Martínez no se quedó callado, y volvió a contragolpear. “No acepto exigencias de senadores que forman parte de un Gobierno que tiene a dos comisiones bicamerales al servicio de una agenda de venganza e impunidad”, sentenció antes de mencionar el “hostigamiento contra el procurador interino Eduardo Casal”. ||| El debate terminó saldándose a favor de la postura del oficialismo cuando el vicepresidente de Acuerdos, Ernesto Martínez (Juntos por el Cambio-Córdoba), decidió despedir a la postulante sin que respondiera las preguntas. “Habiendo hecho catarsis ambos bloques con sus respectivos senadores con cuestiones políticas anteriores y presentes, la doctora Vázquez queda desocupada”, dio por terminado el debate. ||| El senador cordobés presidió la audiencia ante la llamativa ausencia de la oficialista Anabel Fernández Sagasti (Mendoza), que preside Acuerdos. Según explicaron en el bloque oficialista, la mendocina no pudo asistir por estar ocupada en otras actividades. Sin embargo, las audiencias públicas celebradas ayer y hoy, en las que se trataron 32 pliegos judiciales que podrían ser aprobados en la próxima sesión del Senado, habían sido convocadas con un mes de antelación."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
    ##  [5] "Elisa Carrió quedó dolida con Facundo Manes. Hoy, volvió a cuestionar con dureza al precandidato a diputado Facundo Manes quien aseguró a LA NACION que la líder de la Coalición Cívica (CC)-Ari, le pidió que la secundara en la fórmula hacia la Casa Rosada, en 2015. Además de desmentir sus dichos otra vez, Carrió disparó: “Le causó daño a [Horacio Rodríguez] Larreta sin necesidad”. ||| “Estoy harta de las mentiras”, replicó la exdiputada en diálogo con LN+. “Nunca contesto una opinión, jamás he querellado a nadie por un agravio, en todo caso un delito de opinión sobre otra persona, pero lo que sí creo, sobre todo en el conocimiento científico, religioso y práctico, y en las relaciones familiares, que la primera regla que existe con el otro es no mentir”, señaló Carrió al ser consultada por las recientes declaraciones del precandidato a diputado Facundo Manes. ||| “Cuando yo miento descaradamente sobre los hechos, tengo un problema de salud mental o estoy repitiendo el modelo cristinista de mentir hasta que se crea algo”, acusó la líder de la Coalición Cívica. ||| La exdiputada nacional advirtió en referencia a Manes: “Dicen que son la nueva política, pero llevan en la lista a Jesús Cariglino y a Stolbizer”. ||| A lo largo de la entrevista, Carrió volvió a negar la afirmación del médico, que dijo que la exdiputada fue a su casa a ofrecerle una vicepresidencia en la fórmula hacia la Casa Rosada, en 2015. “Si recuerdan Manes estaba con el radicalismo, con Ernesto Sanz y yo, que soy parte de la Coalición Cívica, estaba con Toty Flores, mi candidato a vice desde 2013. Nunca pude pedirle algo así”, aclaró Carrió. ||| La líder de la Coalición Cívica contó que en aquella oportunidad quien la invitó a la casa de Manes fue Toty Flores, aunque, según sostuvo, ella “no quería ir”. Y en ese sentido, sumó: “Nunca le hubiera pedido a Manes [la vicepresidencia] por razones que no tengo que explicar”. ||| Manes competirá en la interna bonaerense con Diego Santilli, del Pro, el candidato de Larreta. ||| Noticia en desarrollo"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
    ##  [6] "Cuestionado por la oposición y con fallos adversos en la Justicia por la rigidez de las medidas sanitarias para evitar el avance del coronavirus, el gobernador de Formosa, Gildo Insfrán, presentó ayer a los candidatos del Frente de Todos con un acto multitudinario en el Club San Martín de la capital provincial. No hubo distanciamiento social y las imágenes remitieron a una jornada proselitista de prepandemia. ||| El acto se hizo en un gimnasio cerrado y con la gente apiñada, con bombos, banderas y consignas partidarias. En Formosa está permitido el aforo de hasta un 50 por ciento con distanciamiento y protocolos en bares y restaurantes. ||| Esta tarde participamos del lanzamiento de los precandidatos a Diputados nacionales por el Frente de Todos. Los compañeros y compañeras Ramiro, Elena, Adrián y Cristina tendrán el compromiso de representar y defender los intereses del Pueblo formoseño. pic.twitter.com/3vijOtnKYN ||| En su discurso, Insfrán se manifestó en contra de realizar las elecciones en plena pandemia. “Epidemiológicamente hablando, no es adecuado, pero lo vamos a hacer”, dijo el gobernador formoseño, que lleva 26 años en el poder. Y agregó: ““Hoy no venimos a festejar nada, venimos solamente a un reencuentro para hablar de la nueva normalidad que nos exige este virus”. ||| Además, hizo una mención al presidente Alberto Fernández, que lo respaldó. “Logró la unidad del Frente de Todos, vamos a vacunar a todos y se está logran un mejoramiento de los índices económicos”."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
    ##  [7] "La ministra de Salud, Carla Vizzotti, celebró ayer la gran cantidad de vacunas contra el Covid-19 que llegaron al país durante julio; sin embargo, el avance de la campaña de vacunación en la Argentina muestra retrasos, de acuerdo a lo que se evidencia desde el Monitor Público de Vacunación. ||| Teniendo en cuenta las últimas adquisiciones de vacunas y las cifras del Monitor, hay más de 7 millones de dosis que ya han sido distribuidas a las provincias pero aún no fueron aplicadas. Si se toma en cuenta las vacunas recibidas, sumadas a las todavía no distribuidas, esa cifra se eleva a casi 11,2 millones de inoculaciones en stock. ||| Hubo una explicación oficial sobre la composición del stock de 5.616.166 dosis que hasta el martes todavía no habían sido enviadas a las provincias. De las 3,5 millones de vacunas de Moderna, hoy empezaron a distribuirse 901.040 que serán destinadas menores de 18 años con comorbilidades. Además, 800.500 dosis de Astrazeneca llegaron el lunes, mientras que 1,2 millones de Sinopharm “están en proceso de distribución”. ||| Según detalla el Monitor Público de Vacunación, hasta hoy, las dosis que llegaron a la Argentina son 41.852.625, de las cuales 37.123.414 ya fueron derivadas a las 24 jurisdicciones. De ellas, se aplicaron 30.655.272 de dosis. Así se encuentran en stock 11.197.353 dosis restantes. ||| De esta manera, el promedio diario de aplicaciones está por debajo de las 400 mil inyecciones, por lo que, según se detalla en los informes oficiales, 349.214 personas fueron vacunadas diariamente en la última semana. Así, también se detalla que solo un 14% de argentinos tiene las dos dosis administradas. ||| Del stock de 6,5 millones sin aplicar: ||| Vacunas recibidas: 41.852.625 dosis ||| Composición del stock de 6,5 millones dosis restantes ||| Dosis aplicadas:"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    ##  [8] "Sergio Palazzo, el jefe del gremio de los bancarios y candidato a diputado nacional por el Frente de Todos, planteó la necesidad de debatir una reducción de la jornada de trabajo. “La Argentina viene con un derrotero largo de empleo informal que hay que abordarlo. Es un tema a tratar como también es importante dar la discusión en el parlamento sobre la reducción de la jornada de trabajo”, dijo el sindicalista, que contó hoy que su postulación al Congreso surgió después de una charla con Cristina y Máximo Kirchner. ||| Además, Palazzo pidió una reforma impositiva. “La Argentina ha trabajado una reforma impositiva que hay que profundizar para que sea progresiva”, dijo en declaraciones a Futurock. ||| Quiero agradecer a @CFKArgentina y a Máximo Kirchner por la convocatoria a integrar la lista de Diputados Nacionales de la Pcia de Bs As.Mi agradecimiento al Presidente @alferdez y al gobernador @Kicillofok por la confianza que me expresaron para ocupar tan honorable cargo. pic.twitter.com/rLKd5XHV2y ||| No es el primer sindicalista alineado con el kirchnerismo que plantea una modificación similar en lo referido al empleo. Hugo Yasky, que es uno de los 12 diputados nacionales de origen sindical que habita la Cámara baja, buscó sin éxito el año pasado apoyo para cristalizar un proyecto de ley propio que impulsa la reducción de la jornada laboral legal de 48 a 40 horas semanales. Así, el jefe de una de las vertientes de la CTA apostaba a que se formalicen miles de empleos. ||| En la Argentina, por la ley 11.544, la jornada laboral legal es de 48 horas semanales como máximo. Sin embargo, la jornada laboral efectiva es de 38 horas, según un relevamiento elaborado por Chequeado en 2019. En 2017, el Frente de Izquierda y de los Trabajadores propuso sin éxito una reducción más brusca que la que plantea Yasky: pidió por entonces una reducción de 48 a 30 horas."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
    ##  [9] "Los primeros chispazos de la interna entre el Pro y la UCR en la provincia de Buenos Aires encendieron las luces de alarma en Juntos por el Cambio. El cruce de acusaciones entre el médico Facundo Manes, quien se medirá Diego Santilli en las PASO del 12 de septiembre, Elisa Carrió (CC) y espadas del macrismo exhibió la dificultad que enfrenta la principal coalición opositora, en plena etapa de reconfiguración de liderazgos, para unificar un mensaje de campaña y coordinar la estrategia electoral. Y aceleraron la elaboración de un “reglamento de convivencia” para las primarias. ||| Como adelantó LA NACION, La idea de confeccionar “un manual de buenas prácticas” ya había sido consensuada durante la última reunión de la mesa nacional del conglomerado opositor, pero se reactivó tras el cimbronazo que generó el pedido de Manes al jefe de gobierno, Horacio Rodríguez Larreta, para que no utilice fondos de la Ciudad (“espero que no usen impuestos de los porteños”) en la campaña. Sus dichos provocaron una dura reacción de Cristian Ritondo, jefe de bloque de Pro en Diputados. A su vez, Carrió tildó de “mitómano” al neurólogo y neurocientífico, luego de que Manes dijera en una entrevista con este medio que la líder de la CC le ofreció ser candidato a vicepresidente en 2015. ||| Tras los cruces en el arranque de la campaña en la provincia, hubo contactos entre las autoridades de Pro, la UCR y la CC para aquietar las aguas. “Hay mucha preocupación y temor en el Pro porque les gusta tener todo controlado”, comenta un referente del radicalismo. ||| Por estas horas, la titular de Pro, Patricia Bullrich, trabaja en el texto del reglamento de “convivencia” y “buenas prácticas” para las primarias de Juntos por el Cambio en todo el país. También hubo diálogos entre los integrantes la cúpula de la alianza para discutir sobre el nombre y los colores que tendrá el espacio en algunos distritos del país. ||| “El manual no va a servir para nada. A Facundo no lo van a controlar. No va a tener ningún problema en decir que la gestión de Vidal fue la que más recortó en educación”, desafía un dirigente de peso del radicalismo. “Nos tenemos que concentrar en el objetivo: nuestro adversario es el kirchnerismo”, señalan desde la CC. ||| Para evitar tensiones, Bullrich prefirió mantenerse al margen de los cruces que provocaron en la fuerza las primeras intervenciones mediáticas de Manes. Por su rol en la coalición y en Pro, la exministra de Seguridad busca ser “garante” de las buenas prácticas en las internas. “Si me pongo a opinar, voy a entrar en el barro, y no quiero eso”, afirmó a LA NACION la jefa del partido fundado por Mauricio Macri. Allegados a Santilli avisan que no le contestarán a Manes para “no subirle el precio” al tema: “Las chicanas te alejan de la gente”. ||| Según fuentes del radicalismo, el presidente de la UCR, Alfredo Cornejo, se contactó con Manes y Bullrich tras el affaire. Cerca del médico se muestran satisfechos con los resultados de sus primeras apariciones en los medios. De hecho, remarcan que las declaraciones de Manes sirvieron para “marcarle la cancha” al Pro y a Rodríguez Larreta. “Ahora, no van a poder hacer una campaña millonaria, porque están expuestos”, evalúan en el pelotón del médico. Repiten que el médico no saldrá a contestar las críticas de Carrió ni del macrismo y que intentará “salir por arriba de la grieta” con su discurso “moderno” de la campaña. “A Facundo no lo pueden agarrar con nada porque no es un político tradicional. Está muy fuerte y muy activo”, señala uno de sus interlocutores en la UCR. ||| En la cúpula del partido centenario ya circulan las teorías conspirativas por el primer round de la campaña: perciben que Larreta estuvo detrás de la embestida de Carrió contra Manes. Vieron, cuenta un dirigente del espacio, una acción coordinada en redes para replicar los dichos del médico, quien ratificó que la líder de la CC le ofreció secundarlo en la fórmula en 2015. Lilita lo niega. “La reacción de Carrió fue desmedida”, apuntan cerca de uno de los caciques de la UCR. ||| Para su primera incursión electoral en Buenos Aires, Manes armó una mesa política con sus principales aliados para la interna de Pro: Maximiliano Abad, titular de la UCR bonaerense, Emilio Monzó, Joaquín de la Torre y Margarita Stolbizer (GEN). En tanto, la politóloga Ana Iparraguirre quedó a cargo de la coordinación de los equipos técnicos de la campaña. Por estas horas, la tropa del médico para la batalla electoral con el Pro define la hoja de ruta de Manes. Es probable que dé el puntapié inicial de la campaña en Salto, donde vivió durante su infancia y adolescencia, y que visite Chacabuco, Junín, Mar del Plata, entre otros distritos, durante los próximos días. ||| Con la mira en el conurbano bonaerense, donde cree que le sacará ventaja a Manes en la interna, Santilli activó a sus equipos para la contienda. Su jefe de campaña es Néstor Grindetti, intendente de Lanús, quien quedó al frente de la mesa de política y estratégica que integran Diego Valenzuela (Tres de Febrero), Jorge Macri (Vicente López), Julio Garró (La Plata), Maricel Etchecoin (CC), Ritondo (Pro) y Gerardo Milman (Pro), entre otros. En el comité de discurso y estrategia aparecen dos espadas de Larreta: Christian Coelho y Federico Di Benedetto, a cargo de las encuestas. ||| Para coordinar el mensaje de campaña, los colaboradores de Santilli harán reuniones con los 15 primeros precandidatos de su lista. Los ejes discursivos serán la seguridad, la educación, el empleo, la producción y temas institucionales. También mantendrán al tanto de la estrategia a Carrió, Bullrich y Cornejo, entre otros. A su vez, planean segmentar el mensaje para cada sección electoral. ||| Durante las últimas 48 horas, Santilli ya pasó por La Matanza y Hurlingham. Y recorrió esta mañana Lanús, en la tercera sección electoral, junto a Larreta y Grindetti. “Responder chicanas lo único que hace es ayudar al kirchnerismo”, lanzó Santilli tras la actividad. Mensaje a Manes. ||| En el pelotón de Santilli hubo preocupación por los cruces por los dichos de Manes y los tironeos internos. “Nos puede desperfilar”, admiten. Además, consideran que será complicado manejar los “egos” de las figuras de Juntos en una campaña atípica para el espacio. Es que por primera vez lidia con el desafío de competir en los comicios sin que Marcos Peña o Jaime Durán Barba, quien manejaban la comunicación de Pro, bajen los lineamientos y coordinen el mensaje de la coalición. ||| Por ahora, la interna de Juntos por el Cambio en la Capital navega por aguas más calmas –más allá de la polémica por los tuits de Sabrina Ajmechet sobre Malvinas–. Anteayer, se reunió la mesa de campaña de Vidal para trazar los lineamientos discursivos y la estrategia política para las PASO. Se sentaron Fernando Straface, jefe de campaña de Vidal; Federico Salvai, mano derecha de la exgobernadora; Emmanuel Ferrario, a cargo de la coordinación operativa; Maximiliano Ferraro (CC), Emiliano Yacobitti (UCR) y Di Benedetto, un funcionario clave para Larreta. ||| En las primarias de septiembre, Vidal se medirá con Ricardo López Murphy (Republicanos Unidos) y Adolfo Rubinstein (Adelante Ciudad). El exministro de Economía arrancó la campaña con una frase sobre la cifra de desaparecidos en la última dictadura que generó ruidos internos. Cerca del “bulldog” aseguran que tendrá total libertad narrativa y discursiva para la interna. “Fue una de las condiciones que puso Ricardo para ingresar a Juntos por el Cambio”, cuentan desde su entorno. ||| López Murphy no tendrá un jefe de campaña, sino un equipo de colaboradores que lo asistirá con la comunicación y política. Su mensaje se centrará en la creación de empleo, reactivación económica, seguridad ciudadana y educación “moderna y de calidad”. ||| En tanto, el radical Facundo Suárez Lastra, quien busca renovar su mandato en la Cámara baja, estará el frente de la campaña de Rubinstein. La salud y la educación serán sus ejes prioritarios. Si bien buscarán marcar sus diferencias con Larreta y el Pro –no están de acuerdo con la mudanza electoral de Vidal–, planean una campaña propositiva, sin golpes bajos ni ataques al macrismo. Y quieren mostrarse como un espejo de la campaña de Manes en la provincia. “Corremos de atrás y vamos por la positiva. Queremos demostrar que somos un complemento para mejorar la lista”, sintetizan."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
    ## [10] "El gobierno del presidente Alberto Fernández tiene un conflicto con la verdad. Cada tanto, o a cada rato, se descubre que afirmaciones de él o de sus funcionarios no son ciertas. También hubo, en algunos casos, manifiestas manipulaciones de los datos para que estos coincidan con una supuesta realidad, que nunca es la realidad. El resultado fácilmente perceptible es que la palabra presidencial ha perdido valor. Peor: ha perdido credibilidad. Es una noticia extremadamente mala para cualquier presidente (y para cualquier país). ||| Ayer hubo dos noticias que son ejemplos cabales de esa insistencia presidencial en cambiar el eje de los hechos con palabras inexactas. Una fue la nota enviada a la Justicia por la Agencia Nacional de Materiales Controlados (ANMAC) en la que señala que Alberto Fernández prorrogó dos veces la permanencia de las 70.000 municiones enviadas a Bolivia. El envío de ese armamento a Bolivia, decidido inicialmente por el gobierno de Mauricio Macri, motivó una denuncia del gobierno kirchnerista contra el expresidente por haber contribuido supuestamente a un “golpe de Estado” contra el entonces gobierno boliviano de Evo Morales. ||| La otra noticia fue la firma de un contrato con el laboratorio Pfizer para la compra de 20 millones de dosis de su vacuna contra el coronavirus, después de 13 meses de negociaciones frustradas. Fuentes oficiales reconocen que Pfizer pasó a ser una opción razonable cuando todas las otras opciones (Sputnik V, AstraZeneca, Sinopharm y Sinovac) fracasaron. Muy atrás quedaron los tiempos en que Pfizer ponía “condiciones inaceptables”, según la explicación del exministro de Salud Ginés González García sobre la ruptura con el laboratorio norteamericano. ||| La denuncia contra Macri por su complicidad con el golpe contra Evo Morales encierra varias contradicciones. La primera de ellas es que Morales no cayó como víctima de un golpe de Estado. Un sector importante de la sociedad se sublevó cuando era evidente que se estaba cometiendo fraude en una elección que perpetuaría a Morales en el poder. Después de días de violencia y represión (fueron violentos los sublevados y fue violenta la represión) los jefes militares le “aconsejaron” a Morales que renunciara. Es una presión militar inaceptable para cualquier mirada argentina, pero resulta que esa participación de los uniformados está contemplada en la Constitución de Bolivia. Morales renunció y sus opositores lo persiguieron a él, a su gobierno y a su familia. ||| La embajada argentina en Bolivia refugió a dos hijos de Evo Morales en esos días en los que la seguridad era una ausencia. El excanciller argentino Jorge Faurie señaló que su gobierno mantenía permanente conversaciones con el ya gobierno electo de Alberto Fernández para coordinar las acciones en Bolivia. Un hijo de Morales eligió viajar a México; el otro vino a la Argentina. Macri gobernaba la Argentina en sus últimos días en el poder. También exfuncionarios de Evo Morales fueron refugiados en la sede de la representación diplomática argentina. ¿Macri auspiciaba un presunto golpe en Bolivia contra Morales mientras daba refugio en la embajada argentina a familiares y exfuncionarios de Morales? Solo el prejuicio, el rencor o la competencia electoral pueden sostener semejantes incoherencias. ||| La denuncia nació viciada en el origen mismo. El actual canciller boliviano, Rogelio Mayta, mostró una carta del exjefe de la aviación boliviana Jorge Terceros Lara en la que le agradecía al gobierno argentino el envío de 70.000 municiones para reprimir a los seguidores de Evo Morales. La carta está fechada el 13 de noviembre de 2019. Morales renunció dos días antes, el 11 de noviembre. Es decir que en un solo día el gobierno argentino había enviado las municiones que necesitaban los “golpistas” y el nuevo gobierno boliviano le agradecía el gesto. ||| El armamento de la Gendarmería fue enviado a Bolivia, según explicó siempre el gobierno de Macri, para proteger a la embajada argentina, en la que se encontraban refugiados familiares y exfuncionarios de Morales y estaba siendo asediada por seguidores del nuevo gobierno, presidido por la parlamentaria Jeanine Áñez. El general de aviación Terceros Lara calificó luego de “falsificada” su firma en esa carta. El militar renunció a las 9 de la mañana del 13 de noviembre, el mismo día que supuestamente firmó la carta. ||| El entonces embajador argentino en Bolivia, Normando Álvarez García, aseguró que nunca había recibido esa supuesta carta (supuesta o presunta son palabras que deben repetirse en este caso). Álvarez García no es un político de Macri, sino del gobernador radical de Jujuy, Gerardo Morales, de cuyo gobierno es actualmente ministro de Trabajo. El sitio Bolivia Verifica, que es un centro de chequeo de información que depende de la Fundación para el Periodismo, calificó de “falsa” la carta de Terceros Lara. ||| Menos de un mes después del envío de esas municiones, el 10 de diciembre de 2019, Macri abandonaba el poder. La denuncia del canciller Mayta espoleó en la Argentina para que el kirchnerismo se apelotonara en los tribunales denunciando a Macri y a varios funcionarios suyos como cómplices del supuesto golpe de Estado contra Evo Morales. Los ministros de Seguridad y de Justicia, Sabina Frederic y Martín Soria, y hasta la jefa de la AFIP, Mercedes Marcó del Pont, se presentaron como querellantes en la denuncia contra el gobierno macrista. ||| Además, el kirchnerismo le tiene especial aversión al exdirector de la Gendarmería Gerardo Otero desde la muerte de Santiago Maldonado. La autopsia de Maldonado, que estableció que murió ahogado y no tenía heridas de ningún tipo, no menguó el rencor del kirchnerismo contra el exjefe de la Gendarmería. La otra cara de la verdad es que Otero fue un jefe implacable de sus tropas en la lucha contra el narcotráfico. Meterlo ahora en las pobres peleas de la política es una decisión claramente injusta. ||| La carta de la Anmac revela varias cosas. La primera de ellas es que Alberto Fernández prorrogó la permanencia de esas municiones en Bolivia en dos ocasiones y por el plazo de tres meses cada una. Ya era 2020. Macri estaba en su casa desde hacía tiempo. ||| Los armamentos de la Gendarmería argentina estuvieron en Bolivia más tiempo durante el gobierno de Alberto Fernández (alrededor de seis meses) que bajo la administración de Macri (un mes). ||| La otra sorpresa es que Alberto Fernández usó los mismos argumentos que Macri para extender la permanencia de esas municiones en el país vecino: “Brindar seguridad y protección al embajador y al personal de la embajada argentina en Bolivia”. Ni siquiera cambió las palabras que había usado el gobierno de Macri. ||| En Bolivia, seguía gobernando la supuesta golpista Jeanine Áñez. ¿Por qué el envío de municiones para proteger la embajada por parte de Macri fue un delito y no lo son las prórrogas que autorizó el gobierno de Alberto Fernández? El actual presidente de Bolivia, Luis Arce, le puso al asunto la coloratura que tiene: “Es lamentable que un gobierno de derecha haya participado de un golpe de Estado”, dijo. ||| Apareció el elemento evidente que nadie nombraba: la ideología. Los gobiernos de Arce y de Alberto Fernández son muy cercanos y tienen posiciones habitualmente comunes en asuntos de política exterior. ¿Hay mejor ejemplo de lawfare que el caso judicial del envío de armamentos a Bolivia? ¿O el lawfare es solo malo cuando la Justicia persigue a los dirigentes progresistas, pero es necesario y justo cuando lo hace con los de la derecha o de la centroderecha? ||| En junio de 2020, hace 13 meses, el gobierno de Alberto Fernández inició negociaciones con el laboratorio Pfizer para comprar vacunas. El primer acuerdo consistió en que en la Argentina se realizaría el ensayo más grande del mundo en la investigación de la vacuna Pfizer. Participaron 5762 argentinos en el Hospital Militar bajo el control de un equipo médico cuyo jefe es el infectólogo Fernando Polack. En las primeras conversaciones se convino, según se supo después, que Pfizer enviaría al país desde diciembre del año pasado 13,2 millones de dosis. En diciembre pasado hubieran llegado más de 3 millones de dosis. Sin embargo, luego se conoció el compromiso con el gobierno ruso por la vacuna Sputnik V, con los chinos por las Sinopharm y Sinovac, y con el laboratorio anglo-sueco AstraZeneca, el único que entonces tenía un socio local. Entonces aparecieron las “condiciones inaceptables” de Pfizer denunciadas por González García o los “hechos violentos” de ese laboratorio explicados más tarde por el propio Presidente. ||| Pero la opción de esas vacunas se fue desvaneciendo cuando los envíos se retrasaron. Hasta hoy. Hay siete millones de argentinos que esperan, atemorizados, la segunda dosis de la Sputnik V que nunca llega. Los amigos y la ideología se terminaron cuando la realidad golpeó las puertas del despacho presidencial: la Argentina tiene ahora solo al 13 por ciento de su sociedad vacunada con las dos dosis. La inmunización total de las personas es indispensable para enfrentar la variante Delta, que está azotando a países que tienen a más del 50 por ciento de su sociedad (algunos hasta el 70 por ciento) vacunada con las dos dosis. España les cerró las puertas a los argentinos, no porque no los quiera, sino por razones más prácticas que emocionales. España, que tiene a la mitad de su sociedad vacunada con las dos dosis, está sufriendo los estragos de la variante Delta; de hecho, tiene más casos de contagiados por 100.000 habitantes en los últimos 14 días que la Argentina. Pero el gobierno de Pedro Sánchez sabe que aquí todavía no explotó la variante Delta y que solo un 13 por ciento de la sociedad argentina está vacunada con las dos dosis. Solo se adelanta ante probables recaídas de la situación local. ||| El Gobierno debería ser más sincero. No hubo un acuerdo con Pfizer después de largas negociaciones. Lo único nuevo es la desesperación del presidente argentino ante un futuro incierto, impredecible y voluble. No es necesario esconder la verdad con palabras que no son ciertas."

Hemos logrado lo que queríamos, extraer información semi-estructurada de
internet y transformar esa información en datos dentro de un marco de
datos de tipo tabular (tabla). ¡Bien hecho!

### Ejercicio 3

Ahora nos toca avanzar en otro de los enfoque para desarrollar web
scraping. Cuando las páginas no explicitan su url y necesitamos
interactuar con el navegador sí o sí, se vuelve necesario el auxilio del
paquete `RSelenium`.

![](https://estudiosmaritimossociales.org/Data_TalleR/la_nacion_selenium.png)

Este paquete, junto con `rvest`, nos permite scrapear páginas dinámicas.
Hay que tener en cuenta que este enfoque falla más y es más lento.

    # Pueden copiar y pegar o descargarlo desde RStudio con esta línea de comando:
    # utils::download.file("https://estudiosmaritimossociales.org/ejercicio03.R", "ejercicio03.R")
    # Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------
    require(tidyverse)
    require(rvest)
    # install.packages("RSelenium") (si no lo tienen instalado)
    require(RSelenium) 
    # El objetivo de RSelenium es facilitar la conexión a un servidor remoto desde dentro de R. 
    # RSelenium proporciona enlaces R para el API de Selenium Webdriver. 
    # Selenio es un proyecto centrado en la automatización de los navegadores web. 
    # Descargamos los binarios, iniciamos el controlador y obtenemos el objeto cliente.
    servidor <- RSelenium::rsDriver(browser = "firefox", port = 9999L) # iniciar un servidor y un navegador de Selenium

    ## [1] "Connecting to remote server"
    ## $acceptInsecureCerts
    ## [1] FALSE
    ## 
    ## $browserName
    ## [1] "firefox"
    ## 
    ## $browserVersion
    ## [1] "90.0.2"
    ## 
    ## $`moz:accessibilityChecks`
    ## [1] FALSE
    ## 
    ## $`moz:buildID`
    ## [1] "20210721174149"
    ## 
    ## $`moz:geckodriverVersion`
    ## [1] "0.29.1"
    ## 
    ## $`moz:headless`
    ## [1] FALSE
    ## 
    ## $`moz:processID`
    ## [1] 17788
    ## 
    ## $`moz:profile`
    ## [1] "C:\\Users\\agusn\\AppData\\Local\\Temp\\rust_mozprofileGasDKK"
    ## 
    ## $`moz:shutdownTimeout`
    ## [1] 60000
    ## 
    ## $`moz:useNonSpecCompliantPointerOrigin`
    ## [1] FALSE
    ## 
    ## $`moz:webdriverClick`
    ## [1] TRUE
    ## 
    ## $pageLoadStrategy
    ## [1] "normal"
    ## 
    ## $platformName
    ## [1] "windows"
    ## 
    ## $platformVersion
    ## [1] "10.0"
    ## 
    ## $proxy
    ## named list()
    ## 
    ## $setWindowRect
    ## [1] TRUE
    ## 
    ## $strictFileInteractability
    ## [1] FALSE
    ## 
    ## $timeouts
    ## $timeouts$implicit
    ## [1] 0
    ## 
    ## $timeouts$pageLoad
    ## [1] 300000
    ## 
    ## $timeouts$script
    ## [1] 30000
    ## 
    ## 
    ## $unhandledPromptBehavior
    ## [1] "dismiss and notify"
    ## 
    ## $webdriver.remote.sessionid
    ## [1] "ff513d62-8425-463b-9170-28382f6270d2"
    ## 
    ## $id
    ## [1] "ff513d62-8425-463b-9170-28382f6270d2"

    cliente <- servidor$client                                         # objeto 'cliente' (objeto que contiene un vínculo dinámico con el servidor)
    cliente$navigate("https://www.lanacion.com.ar/politica")           # cargamos la página a navegar
    # Ahora debemos encontrar el botón de carga y hacemos clic sobre él.
    VerMas <- cliente$findElement(using = "css selector", ".col-12.--loader") # Encontramos el botón
    for (i in 1:6){                 # abrimos función for() para reiterar n veces la acción (clic)
      
      base::print(i)                # imprimimos cada acción
      
      VerMas$clickElement()         # hacemos clic
      
      base::Sys.sleep(7)            # estimamos tiempo de espera entre clic y clic
      
    }                               # cerramos la función for()

    ## [1] 1
    ## [1] 2
    ## [1] 3
    ## [1] 4
    ## [1] 5
    ## [1] 6

    html_data <- cliente$getPageSource()[[1]]                          # obtenemos datos HTML y los analizamos
    ln_sec_pol <- html_data %>%                                        # obtenemos los links a las notas de la sección Política
      
      rvest::read_html() %>%                                           # leemos el objeto html_data con la función read_html()
      
      rvest::html_elements("h2.com-title.--xs a.com-link") %>%         # ubicamos los tags de los links a las notas
      
      rvest::html_attr("href") %>%                                     # extraemos los links de las notas
      
      rvest::url_absolute("https://www.lanacion.com.ar/politica") %>%  # llamo a la función url::absolute() para completar las URLs relativas
      
      tibble::as_tibble() %>%                                          # llamo a la función as_tibble() para transformar el objeto en una tibble.
      
      dplyr::rename(link = value)                                      # llamo a la función rename() para renombrar la variable creada.
    # Creamos la función scraping_notas() para scrapear los links obtenidos ---------------------
    scraping_notas <- function(pag_web, tag_fecha, tag_titulo, tag_nota) { # abro función para raspado web: scraping_notas().
      
      tibble::tibble(                               # llamo a la función tibble.
      
      fecha = rvest::html_elements(                 # declaro la variable fecha y llamo a la función html_elements().
        
        rvest::read_html(pag_web), tag_fecha) %>%   # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) de la fecha. 
        
        rvest::html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' de la fecha.
      
      titulo = rvest::html_elements(                # declaro la variable `titulo` y llamo a la función html_elements().
        
        rvest::read_html(pag_web), tag_titulo) %>%  # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) del título.  
        
        rvest::html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' del título.
      
      nota = rvest::html_elements(                  # declaro la variable nota y llamo a la función html_elements(). 
        
        rvest::read_html(pag_web), tag_nota) %>%    # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) de la nota.  
        
        rvest::html_text()                          # llamo a la función html_text() para especificar el formato 'chr' de la nota.
      
      )                                             # cierro la función tibble().
      
    }                                               # cierro la función para raspado web.
    # Usamos la función pmap_dfr() para emparejar los links y la función de web scraping y 
    # creamos el objeto la_nacion_politica con 20 notas completas
    (la_nacion_politica <- purrr::pmap_dfr(list(ln_sec_pol$link[1:20],".com-date.--twoxs",".com-title.--threexl",".col-12 p"), scraping_notas))

    ## # A tibble: 236 x 3
    ##    fecha       titulo                           nota                            
    ##    <chr>       <chr>                            <chr>                           
    ##  1 28 de juli~ Denuncian penalmente a Alberto ~ "Yamil Santoro, precandidato a ~
    ##  2 28 de juli~ Denuncian penalmente a Alberto ~ "La denuncia que quedo radicada~
    ##  3 28 de juli~ Denuncian penalmente a Alberto ~ "Acaba de ingresar una denuncia~
    ##  4 28 de juli~ Denuncian penalmente a Alberto ~ "En la presentación judicial, a~
    ##  5 28 de juli~ Denuncian penalmente a Alberto ~ "Pacchi es una modelo que tiene~
    ##  6 28 de juli~ Denuncian penalmente a Alberto ~ ""                              
    ##  7 28 de juli~ Elisa Carrió redobló el ataque ~ "Elisa Carrió quedó dolida con ~
    ##  8 28 de juli~ Elisa Carrió redobló el ataque ~ "“Estoy harta de las mentiras”,~
    ##  9 28 de juli~ Elisa Carrió redobló el ataque ~ "“Cuando yo miento descaradamen~
    ## 10 28 de juli~ Elisa Carrió redobló el ataque ~ "La exdiputada nacional advirti~
    ## # ... with 226 more rows

    # Guardamos el objeto 'la_nacion_politica' como objeto .rds
    base::saveRDS(la_nacion_politica, "la_nacion_politica.rds")

### Ejercicio 4

No todo es información suelta y poco estructurada. El lenguaje HTML
tiene un objeto que presenta su contenido en formato tabular, nos
referimos a las tablas HTML que tienen las etiquetas
<table>
</table>

. Es verdad que muchas de estas tablas tiene la opción de descarga en
formato `csv` u otro similar, pero no siempre es así. Inspeccionemos un
poco.

En Wikipedia, un sitio hiper consultado, las tablas no tren por defecto
la opción de descarga. A ver…

![](https://estudiosmaritimossociales.org/Data_TalleR/wiki.png)

Ahí están los datos sobre población mundial. Los queremos pero no los
podemos bajar en ningún formato. Podemos copiar y pegar o ‘rasparlos’ de
forma automática…

    # Pueden copiar y pegar o descargarlo desde RStudio con esta línea de comando:
    # utils::download.file("https://estudiosmaritimossociales.org/ejercicio04.R", "ejercicio04.R")
    # Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------
    require(dplyr)
    require(rvest)
    require(tibble)
    # Creamos la función para raspar El País cuyo nombre será 'scraping_links()' ---------------------
    url_wiki <- "https://es.wikipedia.org/wiki/Población_mundial"  # creamos el objeto url_wiki con la url de la pág. web que contiene las tablas
    (pob__mun__t_tablas <- rvest::read_html(url_wiki) %>%          # creamos un objeto y llamamos a la función read_html() para leer la pág. web.
        
      rvest::html_table())                                         # llamamos a la función html_table() para quedarnos con todas las tablas existentes.

    ## [[1]]
    ## # A tibble: 6 x 6
    ##   Continente `Densidad(hab./~ `Superficie(km²~ `Población(2020~ `País más pobla~
    ##   <chr>      <chr>            <chr>            <chr>            <chr>           
    ## 1 Asia       106,8            44.010.000       4.701.010.000    China (1.440.00~
    ## 2 África     43,4             30.370.000       1.320.000.000    Nigeria (209.20~
    ## 3 América    25,3             43.316.000       1.098.064.000    Estados Unidos ~
    ## 4 Europa     78,6             10.180.000       801.000.000      Rusia (112.000.~
    ## 5 Oceanía    4,46             9.008.500        40.201.000       Australia (27.2~
    ## 6 Antártida  0,0003(varía)    13.720.000       4.490(no perman~ N.D.[nota 1]<U+200B>    
    ## # ... with 1 more variable: Ciudad más poblada(2020) <chr>
    ## 
    ## [[2]]
    ## # A tibble: 29 x 9
    ##    Año     Total   África   Asia    Europa   América  Oceanía `Crecimientoentre~
    ##    <chr>   <chr>   <chr>    <chr>   <chr>    <chr>    <chr>   <chr>             
    ##  1 10000 ~ 1 000 ~ ""       ""      ""       ""       ""      ""                
    ##  2 8000 a~ 8 000 ~ ""       ""      ""       ""       ""      ""                
    ##  3 1000 a~ 50 000~ ""       ""      ""       ""       ""      ""                
    ##  4 500 a.~ 100 00~ ""       ""      ""       ""       ""      ""                
    ##  5 1 d.C.  200 00~ ""       ""      ""       ""       ""      ""                
    ##  6 1000    310 00~ ""       ""      ""       ""       ""      ""                
    ##  7 1750    791 00~ "106 00~ "502 0~ "163 00~ "18 000~ "2 000~ ""                
    ##  8 1800    978 00~ "107 00~ "635 0~ "203 00~ "31 000~ "2 000~ "23,64%"          
    ##  9 1850    1 262 ~ "111 00~ "809 0~ "276 00~ "64 000~ "2 000~ "29,04%"          
    ## 10 1900    1 650 ~ "133 00~ "947 0~ "408 00~ "156 00~ "6 000~ "30,74%"          
    ## # ... with 19 more rows, and 1 more variable: Crecimientoanual medio (%) <chr>
    ## 
    ## [[3]]
    ## # A tibble: 1 x 2
    ##   X1                 X2                                                         
    ##   <chr>              <chr>                                                      
    ## 1 Control de autori~ "Proyectos Wikimedia\n Datos: Q11188\n Multimedia: World p~

    (pob_mun_tablas_1y2 <- rvest::read_html(url_wiki) %>%          # creamos un objeto y llamamos a la función read_html() para leer la pág. web.
        
      rvest::html_table() %>% .[1:2])                              # llamamos a la función html_table() e indicamos con qué tablas queremos quedarnos.

    ## [[1]]
    ## # A tibble: 6 x 6
    ##   Continente `Densidad(hab./~ `Superficie(km²~ `Población(2020~ `País más pobla~
    ##   <chr>      <chr>            <chr>            <chr>            <chr>           
    ## 1 Asia       106,8            44.010.000       4.701.010.000    China (1.440.00~
    ## 2 África     43,4             30.370.000       1.320.000.000    Nigeria (209.20~
    ## 3 América    25,3             43.316.000       1.098.064.000    Estados Unidos ~
    ## 4 Europa     78,6             10.180.000       801.000.000      Rusia (112.000.~
    ## 5 Oceanía    4,46             9.008.500        40.201.000       Australia (27.2~
    ## 6 Antártida  0,0003(varía)    13.720.000       4.490(no perman~ N.D.[nota 1]<U+200B>    
    ## # ... with 1 more variable: Ciudad más poblada(2020) <chr>
    ## 
    ## [[2]]
    ## # A tibble: 29 x 9
    ##    Año     Total   África   Asia    Europa   América  Oceanía `Crecimientoentre~
    ##    <chr>   <chr>   <chr>    <chr>   <chr>    <chr>    <chr>   <chr>             
    ##  1 10000 ~ 1 000 ~ ""       ""      ""       ""       ""      ""                
    ##  2 8000 a~ 8 000 ~ ""       ""      ""       ""       ""      ""                
    ##  3 1000 a~ 50 000~ ""       ""      ""       ""       ""      ""                
    ##  4 500 a.~ 100 00~ ""       ""      ""       ""       ""      ""                
    ##  5 1 d.C.  200 00~ ""       ""      ""       ""       ""      ""                
    ##  6 1000    310 00~ ""       ""      ""       ""       ""      ""                
    ##  7 1750    791 00~ "106 00~ "502 0~ "163 00~ "18 000~ "2 000~ ""                
    ##  8 1800    978 00~ "107 00~ "635 0~ "203 00~ "31 000~ "2 000~ "23,64%"          
    ##  9 1850    1 262 ~ "111 00~ "809 0~ "276 00~ "64 000~ "2 000~ "29,04%"          
    ## 10 1900    1 650 ~ "133 00~ "947 0~ "408 00~ "156 00~ "6 000~ "30,74%"          
    ## # ... with 19 more rows, and 1 more variable: Crecimientoanual medio (%) <chr>

    (pob__mun__tabla__1 <- rvest::read_html(url_wiki) %>%          # creamos un objeto y llamamos a la función read_html() para leer la pág. web.
        
      rvest::html_table() %>% .[[1]])                              # llamamos a la función html_table() e indicamos con qué tabla queremos quedarnos.

    ## # A tibble: 6 x 6
    ##   Continente `Densidad(hab./~ `Superficie(km²~ `Población(2020~ `País más pobla~
    ##   <chr>      <chr>            <chr>            <chr>            <chr>           
    ## 1 Asia       106,8            44.010.000       4.701.010.000    China (1.440.00~
    ## 2 África     43,4             30.370.000       1.320.000.000    Nigeria (209.20~
    ## 3 América    25,3             43.316.000       1.098.064.000    Estados Unidos ~
    ## 4 Europa     78,6             10.180.000       801.000.000      Rusia (112.000.~
    ## 5 Oceanía    4,46             9.008.500        40.201.000       Australia (27.2~
    ## 6 Antártida  0,0003(varía)    13.720.000       4.490(no perman~ N.D.[nota 1]<U+200B>    
    ## # ... with 1 more variable: Ciudad más poblada(2020) <chr>

    (pob__mun__tabla__2 <- rvest::read_html(url_wiki) %>%          # creamos un objeto y llamamos a la función read_html() para leer la pág. web.
        
      rvest::html_table() %>% .[[2]])                              # llamamos a la función html_table() e indicamos con qué tabla queremos quedarnos.

    ## # A tibble: 29 x 9
    ##    Año     Total   África   Asia    Europa   América  Oceanía `Crecimientoentre~
    ##    <chr>   <chr>   <chr>    <chr>   <chr>    <chr>    <chr>   <chr>             
    ##  1 10000 ~ 1 000 ~ ""       ""      ""       ""       ""      ""                
    ##  2 8000 a~ 8 000 ~ ""       ""      ""       ""       ""      ""                
    ##  3 1000 a~ 50 000~ ""       ""      ""       ""       ""      ""                
    ##  4 500 a.~ 100 00~ ""       ""      ""       ""       ""      ""                
    ##  5 1 d.C.  200 00~ ""       ""      ""       ""       ""      ""                
    ##  6 1000    310 00~ ""       ""      ""       ""       ""      ""                
    ##  7 1750    791 00~ "106 00~ "502 0~ "163 00~ "18 000~ "2 000~ ""                
    ##  8 1800    978 00~ "107 00~ "635 0~ "203 00~ "31 000~ "2 000~ "23,64%"          
    ##  9 1850    1 262 ~ "111 00~ "809 0~ "276 00~ "64 000~ "2 000~ "29,04%"          
    ## 10 1900    1 650 ~ "133 00~ "947 0~ "408 00~ "156 00~ "6 000~ "30,74%"          
    ## # ... with 19 more rows, and 1 more variable: Crecimientoanual medio (%) <chr>

    saveRDS(pob_mun_tablas_1y2, 'pob_mun_tablas_1y2.rds')          # guardamos como archivo .rds la lista con los dos tibbles.

Pudimos bajar las dos tablas con datos referidos a la población mundial.
Con este ejercicio concluimos el capítulo sobre web scraping.

#### En este link les dejo una app para Web Scraping de notas sobre conflictos en el portal de noticias marplatense 0223.com. Lo hicimos con el paquete \`shiny’ de RStudio.

##### [Raspador web en tiempo real con R](https://gesmar-mdp.shinyapps.io/WebScrapingAppR/)

## Otros paquetes para hacer Web Scraping en R

-   [ralger (paquete de reciente
    creación, 2019)](https://github.com/feddelegrand7/ralger)
-   [RCrawler](https://github.com/salimk/Rcrawler)
-   [ScrapeR (no está
    actualizado)](https://github.com/mannau/tm.plugin.webmining)
-   [tm.plugin.webmining (no está
    actualizado)](https://cran.r-project.org/web/packages/scrapeR/scrapeR.pdf)

## Bibliografía de referencia

-   [Olgun Aydin (2018) *R web Scraping Quick Start
    Guide*](https://books.google.es/books?hl=es&lr=&id=Iel1DwAAQBAJ&oi=fnd&pg=PP1&dq=#v=onepage&q&f=false)
-   [Alex Bradley & Richard J. E. James (2019) *Web Scraping Using
    R*](https://journals.sagepub.com/doi/pdf/10.1177/2515245919859535)
-   [Mine Dogucu & Mine Çetinkaya-Rundel (2020) *Web Scraping in the
    Statistics and Data Science Curriculum: Challenges and
    Opportunities*](https://www.tandfonline.com/doi/pdf/10.1080/10691898.2020.1787116?needAccess=true)
-   [Subhan Khaliq (2020) *Web Scraping in
    R*.](https://medium.com/analytics-vidhya/web-scraping-in-r-cbb771cd0061)
-   [Simon Munzert, Christian Rubba, Peter Meißner & Dominic
    Nyhuis (2015) *Automated Data Collection with R: A Practical Guide
    to Web Scraping and Text
    Mining*](https://estudiosmaritimossociales.org/R_web_scraping.pdf)
-   [Steve Pittard (2020) *Web Scraping with
    R*.](https://steviep42.github.io/webscraping/book/)
