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

En las últimas dos décadas el crecimiento de la información online
creció de forma acelerada, al punto de tornar imprescindible el uso del
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
Existen muchas oportunidades para obtener los datos que nos interesan.

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
económicos. Etcétera. Etcétera. Etcétera.

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
        
        rvest::html_nodes(".ue-c-cover-content__headline-group") %>%  # llamo a la función html_nodes() y especifico las etiquetas de los títulos 
        
        rvest::html_text() %>%            # llamo a la función html_text() para especificar el formato 'chr' del título.
        
        tibble::as_tibble() %>%           # llamo a la función as_tibble() para transforma el vector en tabla 
        
        dplyr::rename(titulo = value)     # llamo a la función rename() para renombrar la variable 'value'
      
    }                                     # cierro la función para raspado web
    # Usamos la función para scrapear el diario El Mundo ----------------------------------------------
    (El_Mundo <- scraping_EM("https://www.elmundo.es/espana.html"))

    ## # A tibble: 67 x 1
    ##    titulo                                                                       
    ##    <chr>                                                                        
    ##  1 "Política. Casado propone reducir incentivos a los menores inmigrantes de 16~
    ##  2 "Sondeo. España frente a Europa: preocupación económica, tibios en inmigraci~
    ##  3 "Ceuta. Vivas defiente la abstención del PP en la reprobación de Abascal: \"~
    ##  4 "Casa Real. Felipe VI reivindica el papel de la Corona como \"continuidad de~
    ##  5 "A contrapelo. Un líder para Europa"                                         
    ##  6 "Cataluña. Una piscina de 5.000 euros para Rafael Ribó, el defensor del pueb~
    ##  7 "Valencia. 100.000 euros de condena a una universidad pública por la \"defec~
    ##  8 "Análisis. Conde-Pumpido abona su aspiración a presidir el TC alineándose co~
    ##  9 "'Procés'. El fracaso de Giró con los avales del Tribunal de Cuentas abre la~
    ## 10 "Columna desviada. Espíritu olímpico"                                        
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
        
        rvest::html_nodes(tag_link) %>%               # llamo a la función html_nodes() y especifico las etiquetas de los títulos 
        
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
    ##  1 https://www.elmundo.es/economia/macroeconomia/2021/07/26/60feabb6fc6c8363198~
    ##  2 https://www.elmundo.es/economia/actualidad-economica/2021/07/26/60fb0ed0e4d4~
    ##  3 https://www.elmundo.es/economia/actualidad-economica/2021/07/26/60faa94f21ef~
    ##  4 https://www.elmundo.es/economia/empresas/2021/07/23/60faa04bfc6c83a1138b457a~
    ##  5 https://www.elmundo.es/economia/actualidad-economica/2021/07/23/60f877d2fddd~
    ##  6 https://native.elmundo.es/2021/07/26/index.html                              
    ##  7 https://www.elmundo.es/economia/vivienda/2021/07/23/60fa6fcde4d4d8290b8b45c4~
    ##  8 https://www.elmundo.es/economia/2021/07/23/60fafcbe21efa0ce458b460b.html     
    ##  9 https://www.elmundo.es/economia/macroeconomia/2021/07/22/60f9a995fdddff1b058~
    ## 10 https://www.elmundo.es/economia/actualidad-economica/2021/07/23/60f86cbee4d4~
    ## # ... with 56 more rows

    # Usamos la función para scrapear el diario El País -----------------------------------------------
    (links_EP <- scraping_links(pag_web = "https://elpais.com/espana/", tag_link = "h2 a")) 

    ## # A tibble: 27 x 1
    ##    link                                                                         
    ##    <chr>                                                                        
    ##  1 https://elpais.com/espana/2021-07-26/el-constitucional-planea-reactivar-la-s~
    ##  2 https://elpais.com/espana/2021-07-26/la-primera-ponente-de-la-sentencia-sobr~
    ##  3 https://elpais.com/espana/catalunya/2021-07-26/la-posverdad-de-amnistiar-a-3~
    ##  4 https://elpais.com/espana/2021-07-26/vox-da-por-rotas-sus-relaciones-con-el-~
    ##  5 https://elpais.com/espana/catalunya/2021-07-26/el-tribunal-superior-de-catal~
    ##  6 https://elpais.com/espana/2021-07-26/el-nuevo-ministro-de-exteriores-acompan~
    ##  7 https://elpais.com/espana/2021-07-26/hay-que-retirar-de-la-red-mensajes-de-o~
    ##  8 https://elpais.com/espana/2021-07-26/jueces-para-la-democracia-pide-al-comis~
    ##  9 https://elpais.com/espana/2021-07-26/la-moleskine-marca-la-agenda-en-punica.~
    ## 10 https://elpais.com/espana/catalunya/2021-07-26/la-generalitat-busca-nuevos-t~
    ## # ... with 17 more rows

Cumplido el primer paso (la obtención de los link a las notas
completas), nos toca construir una función para ‘rascar’ el contenido
completo de cada nota. ¡Manos a la obra!

    # Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------
    require(dplyr)
    require(rvest)
    require(tibble)
    # Creamos la función para raspar El País cuyo nombre será 'scraping_links()' ---------------------
    scraping_notas <- function(pag_web, tag_fecha, tag_titulo, tag_nota) { # abro función para raspado web: scraping_notas().
      
      tibble::tibble(                               # llamo a la función tibble.
      
      fecha = rvest::html_nodes(                    # declaro la variable fecha y llamo a la función html_nodes().
        
        rvest::read_html(pag_web), tag_fecha) %>%   # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) de la fecha. 
        
        rvest::html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' de la fecha.
      
      titulo = rvest::html_nodes(                   # declaro la variable titulo y llamo a la función html_nodes().
        
        rvest::read_html(pag_web), tag_titulo) %>%  # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) del titulo.  
        
        rvest::html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' del título.
      
      nota = rvest::html_nodes(                     # declaro la variable nota y llamo a la función html_nodes(). 
        
        rvest::read_html(pag_web), tag_nota) %>%    # llamo a la función html_nodes() y especifico la(s) etiqueta(s) de la nota. 
        
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
        
        rvest::html_nodes(tag_link) %>%               # llamo a la función html_nodes() y especifico las etiquetas de los títulos 
        
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
    ##  1 https://elpais.com/espana/2021-07-26/el-constitucional-planea-reactivar-la-s~
    ##  2 https://elpais.com/espana/2021-07-26/la-primera-ponente-de-la-sentencia-sobr~
    ##  3 https://elpais.com/espana/catalunya/2021-07-26/la-posverdad-de-amnistiar-a-3~
    ##  4 https://elpais.com/espana/2021-07-26/vox-da-por-rotas-sus-relaciones-con-el-~
    ##  5 https://elpais.com/espana/catalunya/2021-07-26/el-tribunal-superior-de-catal~
    ##  6 https://elpais.com/espana/2021-07-26/el-nuevo-ministro-de-exteriores-acompan~
    ##  7 https://elpais.com/espana/2021-07-26/hay-que-retirar-de-la-red-mensajes-de-o~
    ##  8 https://elpais.com/espana/2021-07-26/jueces-para-la-democracia-pide-al-comis~
    ##  9 https://elpais.com/espana/2021-07-26/la-moleskine-marca-la-agenda-en-punica.~
    ## 10 https://elpais.com/espana/catalunya/2021-07-26/la-generalitat-busca-nuevos-t~
    ## # ... with 17 more rows

    # Creamos la función para raspar El País cuyo nombre será 'scraping_links()' ---------------------
    scraping_notas <- function(pag_web, tag_fecha, tag_titulo, tag_nota) { # abro función para raspado web: scraping_notas().
      
      tibble::tibble(                               # llamo a la función tibble.
      
      fecha = rvest::html_nodes(                    # declaro la variable fecha y llamo a la función html_nodes().
        
        rvest::read_html(pag_web), tag_fecha) %>%   # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) de la fecha. 
        
        rvest::html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' de la fecha.
      
      titulo = rvest::html_nodes(                   # declaro la variable titulo y llamo a la función html_nodes().
        
        rvest::read_html(pag_web), tag_titulo) %>%  # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) del titulo.  
        
        rvest::html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' del título.
      
      nota = rvest::html_nodes(                     # declaro la variable nota y llamo a la función html_nodes(). 
        
        rvest::read_html(pag_web), tag_nota) %>%    # llamo a la función html_nodes() y especifico la(s) etiqueta(s) de la nota. 
        
        rvest::html_text()                          # llamo a la función html_text() para especificar el formato 'chr' del título.
      
      )                                             # cierro la función tibble().
      
    }                                               # cierro la función para raspado web.
    # Seleccionamos los links que refieren a la sección que nos interesa y nos quedamos solo con 10 notas --------
    (links_EP_limpio <- links_EP %>% filter(str_detect(link, "https://elpais.com/espana/")) %>% filter(!str_detect(link,"en-clave-de-bienestar")) %>% .[1:10,])

    ## # A tibble: 10 x 1
    ##    link                                                                         
    ##    <chr>                                                                        
    ##  1 https://elpais.com/espana/2021-07-26/el-constitucional-planea-reactivar-la-s~
    ##  2 https://elpais.com/espana/2021-07-26/la-primera-ponente-de-la-sentencia-sobr~
    ##  3 https://elpais.com/espana/catalunya/2021-07-26/la-posverdad-de-amnistiar-a-3~
    ##  4 https://elpais.com/espana/2021-07-26/vox-da-por-rotas-sus-relaciones-con-el-~
    ##  5 https://elpais.com/espana/catalunya/2021-07-26/el-tribunal-superior-de-catal~
    ##  6 https://elpais.com/espana/2021-07-26/el-nuevo-ministro-de-exteriores-acompan~
    ##  7 https://elpais.com/espana/2021-07-26/hay-que-retirar-de-la-red-mensajes-de-o~
    ##  8 https://elpais.com/espana/2021-07-26/jueces-para-la-democracia-pide-al-comis~
    ##  9 https://elpais.com/espana/2021-07-26/la-moleskine-marca-la-agenda-en-punica.~
    ## 10 https://elpais.com/espana/catalunya/2021-07-26/la-generalitat-busca-nuevos-t~

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
    ##  1 26 jul 2021~ El Constitucional planea reacti~ "Los miembros del PP que recur~
    ##  2 26 jul 2021~ La primera ponente de la senten~ "Elisa Pérez Vera, durante el ~
    ##  3 26 jul 2021~ La posverdad de amnistiar a 3.0~ "Barricada en Barcelona durant~
    ##  4 26 jul 2021~ Vox da por rotas sus relaciones~ "El presidente de Vox, Santiag~
    ##  5 26 jul 2021~ El Tribunal Superior de Cataluñ~ "El Tribunal Superior de Justi~
    ##  6 26 jul 2021~ El nuevo ministro de Exteriores~ "El nuevo presidente de Perú, ~
    ##  7 26 jul 2021~ “Hay que retirar de la red mens~ "La fiscal Elvira Tejada, coor~
    ##  8 26 jul 2021~ Jueces para la Democracia pide ~ "La asociación Jueces y Juezas~
    ##  9 26 jul 2021~ Las agendas marcan Púnica        "Francisco Granados y Esperanz~
    ## 10 26 jul 2021~ La Generalitat busca nuevos tra~ "El 'president' Pere Aragonès,~

    # Usamos la función para scrapear los links a las notas de La Nación -------------------------------
    (links_LN <- scraping_links(pag_web = "https://www.lanacion.com.ar/politica", tag_link = "h2 a"))

    ## # A tibble: 30 x 1
    ##    link                                                                         
    ##    <chr>                                                                        
    ##  1 https://www.lanacion.com.ar/politica/ordenan-el-procesamiento-embargo-y-pris~
    ##  2 https://www.lanacion.com.ar/politica/maria-eugenia-vidal-retruco-a-cristina-~
    ##  3 https://www.lanacion.com.ar/politica/alberto-fernandez-encabeza-un-acto-en-m~
    ##  4 https://www.lanacion.com.ar/politica/larreta-debio-repartir-lugares-entre-su~
    ##  5 https://www.lanacion.com.ar/politica/sergio-berni-dio-detalles-sobre-chano-s~
    ##  6 https://www.lanacion.com.ar/politica/la-argentina-evito-firmar-una-declaraci~
    ##  7 https://www.lanacion.com.ar/politica/facundo-manes-si-no-tenemos-un-acuerdo-~
    ##  8 https://www.lanacion.com.ar/politica/de-donde-salieron-y-cuanto-costaron-las~
    ##  9 https://www.lanacion.com.ar/politica/el-presidente-logro-preservar-a-cafiero~
    ## 10 https://www.lanacion.com.ar/politica/los-lazos-familiares-jugaron-fuerte-al-~
    ## # ... with 20 more rows

    # Usamos la función para scrapear las notas de La Nación. Replicamos todo en una sola línea de código.
    (la_nacion_ar <- purrr::pmap_dfr(list(links_LN$link[1:10],"section.fecha","h1.titulo","#cuerpo p"), scraping_notas))

    ## # A tibble: 0 x 3
    ## # ... with 3 variables: fecha <chr>, titulo <chr>, nota <chr>

    # Guardamos el objeto 'la_nacion_ar' como objeto .rds
    base::saveRDS(la_nacion_ar, "la_nacion_ar.rds")

Bueno, parece que finalmente completamos los pasos para hacer un web
scraping completo. Pero esto no termina aquí. Seguro notaron, por un
lado, que las notas se trasformaron de 10 a más de 200, y por otro lado,
que la columna ‘nota’ del tibble la\_nacion\_ar está ‘sucia’, contiene
datos no relevantes y que pueden ser contraproducente en el momento del
análisis. Tenemos que normalizar y limpiar esa columna (variable).
¡Hagámoslo!

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
    la_nacion_ar$nota[1:10] # los corchetes me permiten seleccionar los valores según su número de fila

    ##  [1] NA NA NA NA NA NA NA NA NA NA

    # Detectamos que hay algunas filas que son recurrente y debemos borrar:
       # "Celdas vacías"
       # "Espacios en blanco"
       # "\r"
       # "\n"
       # "Conforme a los criterios de"
    # Con el uso del paquete stringr vamos a remover estos fragmentos de información no útil.
    (la_nacion_ar_limpia <- la_nacion_ar %>%                                  # creamos un nuevo objeto clase tibble.
        
        dplyr::mutate(nota = stringr::str_trim(nota)) %>%                     # con las funciones mutate() y str_trim() quitamos los espacios en blanco sobrantes.
        
        dplyr::filter(nota != "",                                             # con la función filter() descartamos las celdas vacías.
               nota != " ",                                                   # o que contiene solo un espacio en blanco.
               
               nota != "Conforme a los criterios de") %>%                     # también descartamos valore recurrente que no forman parte de la nota.
        
        dplyr::mutate(nota_limpia = stringr::str_remove_all(nota, "\\\n"),    # con las funciones mutate() y str_remove_all() creamos la nueva variable nota_limpia, 
               
               nota_limpia = stringr::str_remove_all(nota_limpia, "\\\r")))   # removemos las \n = nueva línea (new line) y los \r = retorno de carro (return).

    ## # A tibble: 0 x 4
    ## # ... with 4 variables: fecha <chr>, titulo <chr>, nota <chr>,
    ## #   nota_limpia <chr>

    # Ahora colapsaremos los párrafos de cada nota en una sola celda, de esta forma volveremos a un tibble de 10 filas (observaciones), una por nota.
    (la_nacion_ar_limpia_norm <- la_nacion_ar_limpia %>%                                # creamos un nuevo objeto clase tibble.
        
      dplyr::group_by(fecha, titulo) %>%                                                # con la función group_by() agrupamos por fecha y título.
        
      dplyr::summarise(nota_limpia = base::paste(nota_limpia, collapse = " ||| ")) %>%  # con las funciones summarise() y paste() colapsamos los párrafos.
      
      dplyr::select(fecha, titulo, nota_limpia) %>%                                     # con la función select() seleccionamos las variables. 
      
      dplyr::mutate(fecha = stringr::str_remove_all(fecha, "•.*$"),                     # con las funciones mutate() y str_remove_all() normalizamos el string de fechas.
               
                    fecha = lubridate::dmy(fecha)))                                     # con las funciones mutate() y dmy() le damos formato date al string de fechas.

    ## # A tibble: 0 x 3
    ## # Groups:   fecha [0]
    ## # ... with 3 variables: fecha <date>, titulo <chr>, nota_limpia <chr>

    # Imprimimos en consola sus valores completos, las notas completas.
    la_nacion_ar_limpia_norm$nota_limpia[1:10] # los corchetes me permiten seleccionar los valores según su número de fila

    ##  [1] NA NA NA NA NA NA NA NA NA NA

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
    servidor <- RSelenium::rsDriver(browser = "firefox", port = 5555L) # iniciar un servidor y un navegador de Selenium

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
    ## [1] 8060
    ## 
    ## $`moz:profile`
    ## [1] "C:\\Users\\agusn\\AppData\\Local\\Temp\\rust_mozprofilezsar6I"
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
    ## [1] "b6990d22-ac4c-4424-a3f4-af3d64bbad26"
    ## 
    ## $id
    ## [1] "b6990d22-ac4c-4424-a3f4-af3d64bbad26"

    cliente <- servidor$client                                         # objeto 'cliente' (objeto que contiene un vínculo dinámico con el servidor)
    cliente$navigate("https://www.lanacion.com.ar/politica")           # cargamos la página a navegar
    # Ahora debemos encontrar el botón de carga y hacemos clic sobre él.
    VerMas <- cliente$findElement(using = "css selector", ".col-12.--loader") # Encontramos el botón
    for (i in 1:3){                # abrimos función for() para reiterar n veces la acción (clic)
      
      base::print(i)                # imprimimos cada acción
      
      VerMas$clickElement()         # hacemos clic
      
      base::Sys.sleep(7)            # estimamos tiempo de espera entre clic y clic
      
    }                               # cerramos la función for()

    ## [1] 1
    ## [1] 2
    ## [1] 3

    html_data <- cliente$getPageSource()[[1]]                          # obtenemos datos HTML y los analizamos
    ln_sec_pol <- html_data %>%                                        # obtenemos los links a las notas de la sección Política
      
      rvest::read_html() %>%                                           # leemos el objeto html_data con la función read_html()
      
      rvest::html_nodes("h2.com-title.--xs a.com-link") %>%                            # ubicamos los tags de los links a las notas
      
      rvest::html_attr("href") %>%                                     # extraemos los links de las notas
      
      rvest::url_absolute("https://www.lanacion.com.ar/politica") %>%  # llamo a la función url::absolute() para completar las URLs relativas
      
      tibble::as_tibble() %>%                                          # llamo a la función as_tibble() para transformar el objeto en una tibble.
      
      dplyr::rename(link = value)                                      # llamo a la función rename() para renombrar la variable creada.
    # Creamos la función scraping_notas() para scrapear los links obtenidos ---------------------
    scraping_notas <- function(pag_web, tag_fecha, tag_titulo, tag_nota) { # abro función para raspado web: scraping_notas().
      
      tibble::tibble(                               # llamo a la función tibble.
      
      fecha = rvest::html_nodes(                    # declaro la variable fecha y llamo a la función html_nodes().
        
        rvest::read_html(pag_web), tag_fecha) %>%   # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) de la fecha. 
        
        rvest::html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' de la fecha.
      
      titulo = rvest::html_nodes(                   # declaro la variable `titulo` y llamo a la función html_nodes().
        
        rvest::read_html(pag_web), tag_titulo) %>%  # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) del título.  
        
        rvest::html_text(),                         # llamo a la función html_text() para especificar el formato 'chr' del título.
      
      nota = rvest::html_nodes(                     # declaro la variable nota y llamo a la función html_nodes(). 
        
        rvest::read_html(pag_web), tag_nota) %>%    # llamo a la función read_html(pag_web) y especifico la(s) etiqueta(s) de la nota.  
        
        rvest::html_text()                          # llamo a la función html_text() para especificar el formato 'chr' de la nota.
      
      )                                             # cierro la función tibble().
      
    }                                               # cierro la función para raspado web.
    # Usamos la función pmap_dfr() para emparejar los links y la función de web scraping y 
    # creamos el objeto la_nacion_politica con las 100 notas completas
    (la_nacion_politica <- purrr::pmap_dfr(list(ln_sec_pol$link[1:100],"section.fecha","h1.titulo","#cuerpo p"), scraping_notas))

    ## # A tibble: 0 x 3
    ## # ... with 3 variables: fecha <chr>, titulo <chr>, nota <chr>

    # Guardamos el objeto 'la_nacion_politica' como objeto .rds
    base::saveRDS(la_nacion_politica, "la_nacion_politica.rds")

### Ejercicio 4

No todo es información suelta y poco estructurada. El lenguaje HTML
tiene un objeto que presenta su contenido en formato tabular, nos
referimos a las tablas HTML que tienen las etiquetas
<table>
</table>

. Es verdad que muchas de estas tablas tiene la opción de descarga en
formato `csv` y otro similar, pero no siempre es así. Inspeccionemos un
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

## Bibliografía de referencia

-   [Olgun Aydin (2018) *R web Scraping Quick Start
    Guide*](https://books.google.es/books?hl=es&lr=&id=Iel1DwAAQBAJ&oi=fnd&pg=PP1&dq=#v=onepage&q&f=false)
-   [Alex Bradley & Richard J. E. James (2019) *Web Scraping Using
    R*](https://journals.sagepub.com/doi/pdf/10.1177/2515245919859535)
-   [Mine Dogucu & Mine Çetinkaya-Rundel (2020) *Web Scraping in the
    Statistics and Data Science Curriculum: Challenges and
    Opportunities*](https://www.tandfonline.com/doi/pdf/10.1080/10691898.2020.1787116?needAccess=true)
-   [Simon Munzert, Christian Rubba, Peter Meißner & Dominic
    Nyhuis (2015) *Automated Data Collection with R: A Practical Guide
    to Web Scraping and Text
    Mining*](https://estudiosmaritimossociales.org/R_web_scraping.pdf)
-   [Steve Pittard (2020) *Web Scraping with
    R*.](https://steviep42.github.io/webscraping/book/)
