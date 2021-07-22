# Intro a `rvest`

## Funciones de `rvest`

El paquete `rvest` nos ayuda a extraer y recolectar datos de páginas
web. Está diseñado para trabajar con las funciones del [paquete
`magrittr`](https://magrittr.tidyverse.org/) (`%>%`) y facilitar las
tareas comunes de raspado web. `rvest` está inspirado en paquetes como
*beautiful soup* y *RoboBrowser* de Python.

Si vamos a ‘raspar’ varias páginas web, es recomendable utilizar, junto
a `rvest`, el paquete `polite`. El [paquete
`polite`](https://github.com/dmi3kno/polite) asegura que se respeten los
términos del documento `robots.txt` y que nuestras solicitudes no
sobrecarguen el sitio web que estamos ‘raspando’. El archivo
`robots.txt` indica a los rastreadores de los buscadores qué páginas o
archivos del sitio se pueden solicitar y cuáles no. Como ya dijimos, se
utiliza para evitar que las solicitudes que recibe el sitio lo
sobrecarguen.

Tanto `rvest` como `magrittr` son parte de `tidyverse`, un ecosistema de
paquetes diseñados con APIs comunes y una filosofía compartida. Para más
información véase [tidyverse.org](https://www.tidyverse.org/).

    # La forma más fácil de conseguir rvest es instalar tidyverse:

    install.packages("tidyverse")


    # Un modo alternativo es instalar sólo rvest:

    install.packages("rvest")


    # También se puede instalar la versión de desarrollo de GitHub. 
    # Esta es la más actualizada. 

    # Primero instalamos devtools
    install.packages("devtools")

    # Para luego instalar tidyverse con la función install_github() 
    devtools::install_github("tidyverse/rvest")

### Tópico `read_html`

#### Funciones para leer documentos HTML o XML

`read_html()` `read_xml()`

El [HTML (HyperText Markup
Language)](https://es.wikipedia.org/wiki/HTML) es el lenguaje básico de
la [www. (World Wide Web)](https://es.wikipedia.org/wiki/World_Wide_Web)
o red informática mundial, un sistema de distribución de documentos de
hipertexto accesibles a través de Internet. [Acá dejamos un demo para
practicar el etiquetado HTML](https://liveweave.com/). La función
`read_html()` nos permite relacionarnos con este lenguaje.

La función `read_html()` es originaria del [paquete
`xml2`](https://cran.r-project.org/web/packages/xml2/xml2.pdf) que
trabaja con archivos XML y usa una interfaz simple y consistente. El
paquete`xml2` fue diseñado en base al paquete `libxml2` del lenguaje
`C`. La función `read_html()` convierte un documento XML/HTML (o nodo o
conjunto de nodos) en una lista R equivalente.

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
x
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Una cadena, una conexión o un vector sin formato. Una cadena puede ser
una ruta, una URL o un XML literal. Las URLs se convertirán en las
conexiones ya sea utilizando la función `base::url()` o, si está
instalado, la función `curl::curl()`. Rutas locales que terminan en
`.gz`, `.bz2`, `.xz`, `.zip` se descomprimen automáticamente. Si es una
conexión, la conexión completa se lee en un vector sin formato antes de
analizarse.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
encoding
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Especifique una codificación predeterminada para el documento. A menos
que se especifique lo contrario, se supone que los documentos XML están
en `UTF-8` o `UTF-16`. Si el documento no es UTF-8/16 y carece de una
directiva de codificación explícita, esto le permite proporcionar un
valor predeterminado.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
…
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Argumentos adicionales.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
as\_html
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Opcionalmente, analice un archivo xml como si fuera html.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
options
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Configure las opciones de análisis para el analizador libxml2.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
base\_url
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Cuando se carga desde una conexión, vector sin formato o html / xml
literal, esto le permite especificar una URL base para el documento. Las
URLs base se utilizan para convertir las URLs relativas en URLs
absolutas.
`URL absoluta: http://www.ejemplo.com/ruta1/ruta2/pagina2.html`
`URL relativa: /ruta1/ruta2/pagina2.html`
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
n
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Si `file` es una conexión, el número de bytes a leer por iteración. El
valor predeterminado es 64 kb.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
verbose
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Al leer desde una conexión lenta, esto imprime algunos resultados en
cada iteración para que sepa que está funcionando.
</p>
</td>
</tr>
</tbody>
</table>

##### Valor

Un documento XML. HTML se normaliza a XML válido; puede que esta no sea
exactamente la misma transformación realizada por el navegador, pero es
una aproximación razonable.

##### Configuración del encabezado `user agent`

Cuando se realizan tareas de web scraping, es una buena práctica -y a
menudo se requiere- establecer el encabezado de solicitud del
`user agent` en un valor específico. A veces, este valor se asigna para
emular un navegador con el fin de que el contenido se represente de una
determinada manera (por ejemplo,
`Mozilla/5.0 (Windows NT 5.1; rv:52.0) Gecko/20100101 Firefox/52.0` para
emular navegadores de Windows más recientes). Muy a menudo, este valor
debe ajustarse para proporcionar otro tipo de información.

Se puede configurar el agente de usuario HTTP para solicitudes basadas
en URLs mediante `httr::set_config()` y `httr::user_agent()`:

`httr::set_config(httr::user_agent("me@example.com; +https://example.com/info.html"))`

`httr::set_config()` cambia la configuración globalmente,
`httr::with_config()` se puede utilizar para cambiar la configuración
temporalmente.

##### Ejemplos

<p>
Aquí veremos algunos ejemplos de aplicación de la función `read_html()`.
Aclaración necesaria: la ventana de fondo celeste contiene el código, y
la ventana de fondo rojo contiene el resultado de la ejecución de las
líneas de código.
</p>
<p>
Todos los ejemplos son reproducibles. Pueden copiar el código (en
fragmentos o bloque) contenido en las ventanas de fondo celeste, pegarlo
en Rstudio y correrlo. En todos los casos el resultado debería ser
idéntico al contenido en la ventana de fondo rojo.
</p>

    # Cargamos el paquete rvest

    library(rvest)


    # Leemos distintos documentos HTML:

    ## desde un HTML literal

    read_html("<html><title>Titulo del Documento HTML en la cabecera<title><body><h1>Esto es el título de etiqueta h1</h1><p>Esto es un párrafo <p> en un documento html</p><body></html>")

    ## {html_document}
    ## <html>
    ## [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8 ...
    ## [2] <body>\n<h1>Esto es el título de etiqueta h1</h1>\n<p>Esto es un párrafo  ...

    ## Desde un directorio local

    xml2::read_xml(xml2::xml2_example("cd_catalog.xml"))

    ## {xml_document}
    ## <CATALOG>
    ##  [1] <CD>\n  <TITLE>Empire Burlesque</TITLE>\n  <ARTIST>Bob Dylan</ARTIST>\n  ...
    ##  [2] <CD>\n  <TITLE>Hide your heart</TITLE>\n  <ARTIST>Bonnie Tylor</ARTIST>\ ...
    ##  [3] <CD>\n  <TITLE>Greatest Hits</TITLE>\n  <ARTIST>Dolly Parton</ARTIST>\n  ...
    ##  [4] <CD>\n  <TITLE>Still got the blues</TITLE>\n  <ARTIST>Gary More</ARTIST> ...
    ##  [5] <CD>\n  <TITLE>Eros</TITLE>\n  <ARTIST>Eros Ramazzotti</ARTIST>\n  <COUN ...
    ##  [6] <CD>\n  <TITLE>One night only</TITLE>\n  <ARTIST>Bee Gees</ARTIST>\n  <C ...
    ##  [7] <CD>\n  <TITLE>Sylvias Mother</TITLE>\n  <ARTIST>Dr.Hook</ARTIST>\n  <CO ...
    ##  [8] <CD>\n  <TITLE>Maggie May</TITLE>\n  <ARTIST>Rod Stewart</ARTIST>\n  <CO ...
    ##  [9] <CD>\n  <TITLE>Romanza</TITLE>\n  <ARTIST>Andrea Bocelli</ARTIST>\n  <CO ...
    ## [10] <CD>\n  <TITLE>When a man loves a woman</TITLE>\n  <ARTIST>Percy Sledge< ...
    ## [11] <CD>\n  <TITLE>Black angel</TITLE>\n  <ARTIST>Savage Rose</ARTIST>\n  <C ...
    ## [12] <CD>\n  <TITLE>1999 Grammy Nominees</TITLE>\n  <ARTIST>Many</ARTIST>\n   ...
    ## [13] <CD>\n  <TITLE>For the good times</TITLE>\n  <ARTIST>Kenny Rogers</ARTIS ...
    ## [14] <CD>\n  <TITLE>Big Willie style</TITLE>\n  <ARTIST>Will Smith</ARTIST>\n ...
    ## [15] <CD>\n  <TITLE>Tupelo Honey</TITLE>\n  <ARTIST>Van Morrison</ARTIST>\n   ...
    ## [16] <CD>\n  <TITLE>Soulsville</TITLE>\n  <ARTIST>Jorn Hoel</ARTIST>\n  <COUN ...
    ## [17] <CD>\n  <TITLE>The very best of</TITLE>\n  <ARTIST>Cat Stevens</ARTIST>\ ...
    ## [18] <CD>\n  <TITLE>Stop</TITLE>\n  <ARTIST>Sam Brown</ARTIST>\n  <COUNTRY>UK ...
    ## [19] <CD>\n  <TITLE>Bridge of Spies</TITLE>\n  <ARTIST>T`Pau</ARTIST>\n  <COU ...
    ## [20] <CD>\n  <TITLE>Private Dancer</TITLE>\n  <ARTIST>Tina Turner</ARTIST>\n  ...
    ## ...

    ## Desde una url web

    read_html("https://es.wikipedia.org/wiki/Localizador_de_recursos_uniforme")

    ## {html_document}
    ## <html class="client-nojs" lang="es" dir="ltr">
    ## [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8 ...
    ## [2] <body class="mediawiki ltr sitedir-ltr mw-hide-empty-elt ns-0 ns-subject  ...

Como hemos visto, la función `read_html()` lee documentos HTML que están
on-line y que están off-line, literales y no-literales

### Tópico `html_nodes`

#### Funciones para seleccionar nodos de un documento HTML

`html_nodes()` `html_node()` `html_element()` `html_elements()`

Son funciones para extraer con facilidad fragmentos de documentos HTML
mediante los selectores `XPath` y `CSS`. Los selectores CSS son
particularmente útiles junto con <http://selectorgadget.com/>: facilita
encontrar exactamente qué selector debería usar. Si no ha usado
selectores CSS antes, siga este tutorial: <http://flukeout.github.io/>

Asimismo, cada navegador (Firefox, Chrome, Opera, Safari, etc.) cuenta
con selectores nativos. Abajo les dejo una imagen del `Inspect Element`
de Chrome con las formas de acceder a la ventana del Inspector de
Elementos.

![](C:/Users/agusn/Google%20Drive/R/PROYECTOS/Tutoriales/Instalr_R/atajos_inspect_element.png)

Además de los atajos de teclado y la tecla `F12`, también se puede
acceder si primero hacemos clic en el botón derecho del mouse sobre la
página web a inspeccionar y luego hacemos clic izquierdo en la opción de
inspeccionar, como se ve en la imagen de abajo.

<center>
![](C:/Users/agusn/Google%20Drive/R/PROYECTOS/Tutoriales/Instalr_R/InspeccionarChrome.png)
</center>

Por acá dejamos dos recursos para interiorizarse más en la *inspección
de elementos*: en
[chrome](https://developers.google.com/web/tools/chrome-devtools/inspect-styles?hl=es)
y en
[mozilla](ttps://developer.mozilla.org/es/docs/Tools/Page_Inspecto). Y
por acá dejamos una breve introducción a los [elementos
html.](https://rvest.tidyverse.org/articles/harvesting-the-web.html)

##### Soporte de selector CSS

Los selectores CSS se traducen a selectores XPath mediante el [paquete
`selectr`](https://sjp.co.nz/projects/selectr/), que es una adaptación a
R del paquete *cssselect* de
[Python](https://pythonhosted.org/cssselect/). Esto puede ser importante
en algunos casos. La extensión *SelectorGadget* citada más arriba
también realiza esta función.

Importante | En los últimos días se actualizaron y renombraron algunas
funciones del paquete `rvest`. Es el caso de `html_node()` y
`html_nodes()`. Estas dos funciones están siendo suplantadas por las
funciones `html_element()` y `html_elements()`. Igualmente, por ahora,
las cuatro funciones están vigentes.

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
x
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Un documento, un conjunto de nodos o un solo nodo.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
css, xpath
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Nodos para seleccionar. Proporcione uno de `css` o `xpath` dependiendo
de si desea utilizar un selector CSS o XPath 1.0.
</p>
</td>
</tr>
</tbody>
</table>

##### Ejemplos

En estos ejemplos concatenamos las dos funciones vistas hasta aquí:
`read_html()` y `html_nodes()`. También haremos uso de la función `%>%`
del paquete `magrittr`.

    # Cargamos el paquete rvest

    library(rvest)


    # Definimos una URL

    (url <- "https://elpais.com/")

    ## [1] "https://elpais.com/"

    # Leemos el documento HTML de la página principal de la web del periódico El País

    (elpais <- read_html(url))

    ## {html_document}
    ## <html lang="es">
    ## [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8 ...
    ## [2] <body class="t__h t__h__el_pais">\n<script type="text/javascript" src="ht ...

    # Leemos todos los elementos etiquetados con 'a'

    (html_nodes(elpais, "a"))

    ## {xml_nodeset (325)}
    ##  [1] <a href="https://elpais.com/">El País</a>
    ##  [2] <a href="https://www.mozilla.org/es-ES/firefox/new/">Mozilla Firefox</a>
    ##  [3] <a href="https://www.microsoft.com/es-es/edge">Microsoft Edge</a>
    ##  [4] <a href="https://www.google.com/intl/es_es/chrome/">Google Chrome</a>
    ##  [5] <a href="https://support.apple.com/downloads/safari">Safari</a>
    ##  [6] <a id="edition-link-el-pais" href="https://elpais.com/s/setEspana.html"  ...
    ##  [7] <a id="edition-link-el-pais-america" href="https://elpais.com/s/setAmeri ...
    ##  [8] <a id="edition-link-el-pais-mexico" href="https://elpais.com/s/setMexico ...
    ##  [9] <a id="edition-link-el-pais-brasil" href="https://elpais.com/s/setBrasil ...
    ## [10] <a id="edition-link-el-pais-cataluna" href="https://elpais.com/s/setCat. ...
    ## [11] <a id="edition-link-el-pais-in-english" href="https://elpais.com/s/setEn ...
    ## [12] <a class="button button_primary | flex subscribe | relative padding_left ...
    ## [13] <a href="https://elpais.com/subscriptions/#/sign-in#?prod=REG&amp;o=CABE ...
    ## [14] <a href="https://elpais.com/landing_oferta/#/campaign#?prod=SUSDIG&amp;o ...
    ## [15] <a href="https://elpais.com/subscriptions/#/profile">Mis datos</a>
    ## [16] <a href="https://elpais.com/subscriptions/#/manage">Mi suscripción</a>
    ## [17] <a href="https://plus.elpais.com/perfil/newsletters/">Newsletters</a>
    ## [18] <a href="https://elpais.com/suscripciones/elpaismas.html">Experiencias p ...
    ## [19] <a href="https://plus.elpais.com/perfil/actividad/">Mi actividad</a>
    ## [20] <a href="https://plus.elpais.com/perfil/baja/">Derechos y baja</a>
    ## ...

    # Leemos todos los elementos etiquetados con 'h2' y 'a'

    (html_nodes(elpais, "h2 a "))

    ## {xml_nodeset (92)}
    ##  [1] <a href="/internacional/2021-07-22/biden-ultima-sanciones-contra-cuba-po ...
    ##  [2] <a href="/opinion/2021-07-22/encarcelar-patria-y-vida.html">Encarcelar P ...
    ##  [3] <a href="/ciencia/2021-07-22/la-forma-de-los-ladrillos-basicos-de-la-vid ...
    ##  [4] <a href="/deportes/2021-07-22/argentina-apuesta-por-el-agua-y-el-fuego.h ...
    ##  [5] <a href="/deportes/2021-07-22/cesado-el-director-de-la-ceremonia-de-aper ...
    ##  [6] <a href="/deportes/juegos-olimpicos/2021-07-22/espana-encalla-en-el-debu ...
    ##  [7] <a href="/deportes/juegos-olimpicos/2021-07-22/el-oro-que-le-falta-a-dan ...
    ##  [8] <a href="/sociedad/2021-07-22/china-rechaza-otra-visita-de-la-oms-a-wuha ...
    ##  [9] <a href="/sociedad/2021-07-22/el-incendio-dixie-gana-10000-hectareas-en- ...
    ## [10] <a href="/sociedad/2021-07-21/grandes-farmaceuticas-anuncian-un-acuerdo- ...
    ## [11] <a href="/mexico/economia/2021-07-22/el-precio-del-gas-domestico-y-de-lo ...
    ## [12] <a href="/internacional/2021-07-22/carlos-ruiz-massieu-la-asuncion-de-cr ...
    ## [13] <a href="/tecnologia/2021-07-22/un-nuevo-fallo-de-un-proveedor-en-la-nub ...
    ## [14] <a href="/ciencia/2021-07-22/asi-es-marte-por-dentro.html">Así es Marte  ...
    ## [15] <a href="/sociedad/2021-07-22/terror-e-impunidad-contra-los-garifunas-de ...
    ## [16] <a href="/cultura/2021-07-22/el-surrealista-fracaso-de-luis-bunuel-y-man ...
    ## [17] <a href="https://smoda.elpais.com/celebrities/andie-macdowell-canas-cann ...
    ## [18] <a href="/cultura/2021-07-22/una-elefanta-para-rembrandt.html">Una elefa ...
    ## [19] <a href="/gente/2021-07-22/mena-suvari-desvela-su-historia-de-abusos-sex ...
    ## [20] <a href="/gente/2021-07-22/el-principe-jorge-comienza-a-descubrir-que-le ...
    ## ...

    # Leemos todos los elementos etiquetados con 'figure', 'a' e 'img'

    (html_nodes(elpais, "figure a img"))

    ## {xml_nodeset (2)}
    ## [1] <img src="https://imagenes.elpais.com/resizer/hoBaArwUkRIYnPvnw4O_A2nVfn8 ...
    ## [2] <img src="https://imagenes.elpais.com/resizer/xapN-wpd0SgrPDwihY_35Atz61Y ...

    # Ahora repetimos, pero esta vez hacemos uso de magrittr '%>%' 
    # para encadenar líneas de código.
    # Leemos todos los elementos etiquetados con 'h2' y 'a'

    elpais %>% html_nodes("h2 a")

    ## {xml_nodeset (92)}
    ##  [1] <a href="/internacional/2021-07-22/biden-ultima-sanciones-contra-cuba-po ...
    ##  [2] <a href="/opinion/2021-07-22/encarcelar-patria-y-vida.html">Encarcelar P ...
    ##  [3] <a href="/ciencia/2021-07-22/la-forma-de-los-ladrillos-basicos-de-la-vid ...
    ##  [4] <a href="/deportes/2021-07-22/argentina-apuesta-por-el-agua-y-el-fuego.h ...
    ##  [5] <a href="/deportes/2021-07-22/cesado-el-director-de-la-ceremonia-de-aper ...
    ##  [6] <a href="/deportes/juegos-olimpicos/2021-07-22/espana-encalla-en-el-debu ...
    ##  [7] <a href="/deportes/juegos-olimpicos/2021-07-22/el-oro-que-le-falta-a-dan ...
    ##  [8] <a href="/sociedad/2021-07-22/china-rechaza-otra-visita-de-la-oms-a-wuha ...
    ##  [9] <a href="/sociedad/2021-07-22/el-incendio-dixie-gana-10000-hectareas-en- ...
    ## [10] <a href="/sociedad/2021-07-21/grandes-farmaceuticas-anuncian-un-acuerdo- ...
    ## [11] <a href="/mexico/economia/2021-07-22/el-precio-del-gas-domestico-y-de-lo ...
    ## [12] <a href="/internacional/2021-07-22/carlos-ruiz-massieu-la-asuncion-de-cr ...
    ## [13] <a href="/tecnologia/2021-07-22/un-nuevo-fallo-de-un-proveedor-en-la-nub ...
    ## [14] <a href="/ciencia/2021-07-22/asi-es-marte-por-dentro.html">Así es Marte  ...
    ## [15] <a href="/sociedad/2021-07-22/terror-e-impunidad-contra-los-garifunas-de ...
    ## [16] <a href="/cultura/2021-07-22/el-surrealista-fracaso-de-luis-bunuel-y-man ...
    ## [17] <a href="https://smoda.elpais.com/celebrities/andie-macdowell-canas-cann ...
    ## [18] <a href="/cultura/2021-07-22/una-elefanta-para-rembrandt.html">Una elefa ...
    ## [19] <a href="/gente/2021-07-22/mena-suvari-desvela-su-historia-de-abusos-sex ...
    ## [20] <a href="/gente/2021-07-22/el-principe-jorge-comienza-a-descubrir-que-le ...
    ## ...

    # Leemos todos los elementos etiquetados con 'figure', 'a' e 'img'

    elpais %>% html_nodes("figure a img")

    ## {xml_nodeset (2)}
    ## [1] <img src="https://imagenes.elpais.com/resizer/hoBaArwUkRIYnPvnw4O_A2nVfn8 ...
    ## [2] <img src="https://imagenes.elpais.com/resizer/xapN-wpd0SgrPDwihY_35Atz61Y ...

    # Cuando la función html_nodes() se aplica a una lista de nodos, devuelve todos los nodos coincidentes 

    html_nodes(elpais, "a") %>% html_nodes("img")

    ## {xml_nodeset (2)}
    ## [1] <img src="https://imagenes.elpais.com/resizer/hoBaArwUkRIYnPvnw4O_A2nVfn8 ...
    ## [2] <img src="https://imagenes.elpais.com/resizer/xapN-wpd0SgrPDwihY_35Atz61Y ...

    # Por su parte la función html_node() sin la 's', devuelve el primer nodo coincidente. # Si no hay nodos coincidentes, devuelve un nodo "faltante".

    html_node(elpais, "a")

    ## {html_node}
    ## <a href="https://elpais.com/">

    ## Para seleccionar un elemento o elementos en posiciones específicas usamos '[[.]]' o '[.]'

    html_nodes(elpais, css = "a")[20:29]

    ## {xml_nodeset (10)}
    ##  [1] <a href="https://plus.elpais.com/perfil/baja/">Derechos y baja</a>
    ##  [2] <a class="button | flex button button_logout text_transform_none no_hove ...
    ##  [3] <a href="https://elpais.com" class="hidden_mobile"><div id="logo" class= ...
    ##  [4] <a href="https://elpais.com" class="visible_mobile"><div id="logo" class ...
    ##  [5] <a id="section_name" class="section-name | inline_block uppercase overfl ...
    ##  [6] <a class="button button_primary | flex subscribe | relative padding_left ...
    ##  [7] <a href="https://elpais.com/subscriptions/#/sign-in#?prod=REG&amp;o=CABE ...
    ##  [8] <a href="https://elpais.com/landing_oferta/#/campaign#?prod=SUSDIG&amp;o ...
    ##  [9] <a href="https://elpais.com/subscriptions/#/profile">Mis datos</a>
    ## [10] <a href="https://elpais.com/subscriptions/#/manage">Mi suscripción</a>

    # Ahora repetimos el código pero cambiamos el parámetro 'css' por el parámetro 'xpath'

    html_nodes(elpais, xpath = "//a")[20:29]

    ## {xml_nodeset (10)}
    ##  [1] <a href="https://plus.elpais.com/perfil/baja/">Derechos y baja</a>
    ##  [2] <a class="button | flex button button_logout text_transform_none no_hove ...
    ##  [3] <a href="https://elpais.com" class="hidden_mobile"><div id="logo" class= ...
    ##  [4] <a href="https://elpais.com" class="visible_mobile"><div id="logo" class ...
    ##  [5] <a id="section_name" class="section-name | inline_block uppercase overfl ...
    ##  [6] <a class="button button_primary | flex subscribe | relative padding_left ...
    ##  [7] <a href="https://elpais.com/subscriptions/#/sign-in#?prod=REG&amp;o=CABE ...
    ##  [8] <a href="https://elpais.com/landing_oferta/#/campaign#?prod=SUSDIG&amp;o ...
    ##  [9] <a href="https://elpais.com/subscriptions/#/profile">Mis datos</a>
    ## [10] <a href="https://elpais.com/subscriptions/#/manage">Mi suscripción</a>

### Tópico `html_text`

#### Función para extraer atributos, texto y nombres de etiqueta de html.

`html_text()` `html_text2()`

Hay dos formas de recuperar texto de un elemento html: `html_text()` y
`html_text2()`. La función `html_text()` es una fina envoltura alrededor
de la función `xml2::xml_text()` que devuelve solo el texto subyacente
sin procesar. Por su parte, `html_text2()` simula cómo se ve el texto en
un navegador y utiliza un enfoque inspirado en la función `innerText()`
de JavaScript. En términos generales, convierte la etiqueta `<br />` en
`\n`, agrega líneas en blanco alrededor de las etiquetas `<p>` y
formatea ligeramente los datos tabulares.

Vale aclarar que `html_text2()` suele devolver lo que se desea en la
forma en que se desea, pero es mucho más lento que `html_text()`. Por
esta razón es recomendable usar `html_text()` para raspados de mayor
volumen.

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
x
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Un documento, nodo o conjunto de nodos.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
trim
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
Si `TRUE` recortará los espacios iniciales y finales
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
preserve\_nbsp
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
¿Deben preservarse los espacios sin rupturas? De forma predeterminada,
`html_text2()` convierte en espacios ordinarios para facilitar los
cálculos posteriores. Cuando `preserve_nbspsea` `TRUE`, `&nbsp;`
aparecerá en cadenas como `\ua0`. Esto a menudo causa confusión porque
se imprime de la misma manera que " ".
</p>
</td>
</tr>
</tbody>
</table>

##### Valor

Un vector de caracteres de la misma longitud que x

##### Ejemplos

En estos ejemplos concatenamos las tres funciones vistas hasta aquí:
`read_html()`, `html_nodes()` y `html_text()`. Haremos uso de la función
`%>%` del paquete `magrittr` y también de algunas otras funciones de los
paquetes base de R y de `rvest` (versión desarrollo).

    # Cargamos el paquete rvest

    library(rvest)


    # Para entender la diferencia entre html_texto() y html_texto2()
    # Tomemos el siguiente html:

    (html <- minimal_html(
      "<p>Esto &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; es &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; un &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; párrafo.
        Esta &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; es otra oración.Esto debería comenzar en una nueva línea."
    ))

    ## {html_document}
    ## <html>
    ## [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8 ...
    ## [2] <body><p>Esto        es        un        párrafo.\n    Esta        es otr ...

    # La función html_text() devuelve el texto subyacente en bruto.
    # Por una parte, incluye los espacios en blanco que serían ignorados por un navegador.
    # Por otra parte, ignora las etiquetas  de salto de línea. 
    # Por defecto, html_texto() lee tanto los espacios en blanco (&nbsp;) correctos
    # como los espacios en blanco repetidos. Veamos:

    writeLines(texto1 <- html %>% html_nodes("p") %>% html_text())

    ## Esto        es        un        párrafo.
    ##     Esta        es otra oración.Esto debería comenzar en una nueva línea.

    # La función html_texto2() simula lo que un navegador mostraría. 
    # Los espacios en blanco no significativos se colapsan, 
    # y las etiquetas  se convierte en un salto de línea. 
    # Por defecto, html_texto2() también convierte los espacios 
    # que no se usan en espacios regulares. Veamos:

    writeLines(texto2 <- html %>% html_element("p") %>% html_text2())

    ## Esto es un párrafo. Esta es otra oración.Esto debería comenzar en una nueva línea.

    # Los textos 1 y 2 tienen el mismo origen, parecen lo mismo, pero no son lo mismo. Veamos:

    texto1 == texto2

    ## [1] FALSE

    # Esto se puede confirmar si miramos su representación binaria subyacente.
    # Veamos el texto1:

    charToRaw(texto1)

    ##   [1] 45 73 74 6f 20 c2 a0 c2 a0 c2 a0 c2 a0 c2 a0 c2 a0 20 65 73 20 c2 a0 c2 a0
    ##  [26] c2 a0 c2 a0 c2 a0 c2 a0 20 75 6e 20 c2 a0 c2 a0 c2 a0 c2 a0 c2 a0 c2 a0 20
    ##  [51] 70 c3 a1 72 72 61 66 6f 2e 0a 20 20 20 20 45 73 74 61 20 c2 a0 c2 a0 c2 a0
    ##  [76] c2 a0 c2 a0 c2 a0 20 65 73 20 6f 74 72 61 20 6f 72 61 63 69 c3 b3 6e 2e 45
    ## [101] 73 74 6f 20 64 65 62 65 72 c3 ad 61 20 63 6f 6d 65 6e 7a 61 72 20 65 6e 20
    ## [126] 75 6e 61 20 6e 75 65 76 61 20 6c c3 ad 6e 65 61 2e

    # Veamos el texto2

    charToRaw(texto2)

    ##  [1] 45 73 74 6f 20 65 73 20 75 6e 20 70 c3 a1 72 72 61 66 6f 2e 20 45 73 74 61
    ## [26] 20 65 73 20 6f 74 72 61 20 6f 72 61 63 69 c3 b3 6e 2e 45 73 74 6f 20 64 65
    ## [51] 62 65 72 c3 ad 61 20 63 6f 6d 65 6e 7a 61 72 20 65 6e 20 75 6e 61 20 6e 75
    ## [76] 65 76 61 20 6c c3 ad 6e 65 61 2e

### Tópico `html_table`

#### Función para analizar una tabla html y convertirla en una base de datos.

`html_table()`

Esta función imita lo que hace un navegador, pero repite los valores de
las celdas colapsadas en cada celda que cubre.

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
x
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Un documento (desde `read_html()`), conjunto de nodos (desde
`html_elements()`), nodo (desde `html_element()`) o sesión (desde
`session()`).
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
header
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
¿Usar la primera fila como encabezado? Si ‘NA’, utilizará la primera
fila si consta de etiquetas ‘&lt;th&gt;’. Si ‘TRUE’, los nombres de las
columnas se dejan exactamente como están en el documento de origen, lo
que puede requerir un procesamiento posterior para generar un marco de
datos válido.
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
trim
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
¿Eliminar los espacios en blanco iniciales y finales dentro de cada
celda?
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
fill
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
En desuso: las celdas que faltan en las tablas ahora siempre se
completan automáticamente con `NA`.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
dec
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Carácter utilizado como marcador de posición decimal.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
na.strings
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Vector de caracteres de valores al que se convertirá en `NA`.
</p>
</td>
</tr>
</tbody>
</table>

##### Valor

Cuando se aplica a un solo elemento, `html_table()` devuelve un solo
tibble. Cuando se aplica a varios elementos o un documento,
`html_table()` devuelve una lista de tibbles.

##### Ejemplos

En estos ejemplos concatenamos las tres de las cuatro funciones vistas
hasta aquí: `read_html()`, `html_nodes()` y `html_table()`. Haremos uso
de la función `%>%` del paquete `magrittr` y también de algunas otras
funciones de los paquetes base de R y de `rvest` (versión desarrollo).

    # Cargamos el paquete rvest

    library(rvest)


    # Creamos una tabla con la función minimal_html()

    (tabla_1 <- minimal_html("<table>
      <tr><th>Col A</th><th>Col B</th></tr>
      <tr><td>1</td><td>x</td></tr>
      <tr><td>4</td><td>y</td></tr>
      <tr><td>10</td><td>z</td></tr>
    </table>"))

    ## {html_document}
    ## <html>
    ## [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8 ...
    ## [2] <body><table>\n<tr>\n<th>Col A</th>\n<th>Col B</th>\n</tr>\n<tr>\n<td>1</ ...

    # Leemos la tabla con las funciones para tablas del paquete rvest

    tabla_1 %>% html_nodes("table") %>% html_table() %>% .[[1]]

    ## # A tibble: 3 x 2
    ##   `Col A` `Col B`
    ##     <int> <chr>  
    ## 1       1 x      
    ## 2       4 y      
    ## 3      10 z

    # Ahora crearemos una segunda tabla con celdas colapsadas, 
    # los valores de estas celdas se duplicarán

    (tabla_2 <- minimal_html("<table>
      <tr><th>A</th><th>B</th><th>C</th></tr>
      <tr><td>1</td><td>2</td><td>3</td></tr>
      <tr><td colspan='2'>4</td><td>5</td></tr>
      <tr><td>6</td><td colspan='2'>7</td></tr>
    </table>"))

    ## {html_document}
    ## <html>
    ## [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8 ...
    ## [2] <body><table>\n<tr>\n<th>A</th>\n<th>B</th>\n<th>C</th>\n</tr>\n<tr>\n<td ...

    # Leemos la segunda tabla con las funciones para tablas del paquete rvest

    tabla_2 %>% html_element("table") %>% html_table()

    ## # A tibble: 3 x 3
    ##       A     B     C
    ##   <int> <int> <int>
    ## 1     1     2     3
    ## 2     4     4     5
    ## 3     6     7     7

    # Ahora crearemos una tercera tabla con celdas colapsadas y con valores faltantes, 
    # las celdas con valores faltantes se llenarán de NAs

    (tabla_3 <- minimal_html("<table>
      <tr><th>A</th><th>B</th><th>C</th></tr>
      <tr><td colspan='2'>1</td><td>2</td></tr>
      <tr><td colspan='2'>3</td></tr>
      <tr><td>4</td></tr>
    </table>"))

    ## {html_document}
    ## <html>
    ## [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8 ...
    ## [2] <body><table>\n<tr>\n<th>A</th>\n<th>B</th>\n<th>C</th>\n</tr>\n<tr>\n<td ...

    # Leemos la tercera tabla con las funciones para tablas del paquete rvest

    tabla_3 %>% html_element("table") %>% html_table()

    ## # A tibble: 3 x 3
    ##       A     B     C
    ##   <int> <int> <int>
    ## 1     1     1     2
    ## 2     3     3    NA
    ## 3     4    NA    NA

## Otras funciones `rvest`

### Tópico `encoding`

#### Investigar y reparar la codificación de caracteres defectuosa.

Las funciones de este tópico nos ayudan a identificar y reparar la
codificación en las páginas web que declaran codificaciones incorrectas.
Se puede utilizar `html_encoding_guess` para averiguar cuál es la
codificación real (y luego suministrarla al argumento de codificación de
html), o utilizar `repair_encoding()` para arreglar los vectores de
caracteres después del raspado. Esta última función ha quedado obsoleta.
En su lugar, debemos leer el archivo HTML con el `encoding =` correcto.

Estas funciones son herramientas del paquete de `stringi`, así que
tendremos que asegurarnos de tenerlo instalado.

    # Instalar el paquete stringi:
    install.packages("stringi")

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
x
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Un vector de caracteres.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
from
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
La codificación en la que está la cadena. Si es NULL, se usará la
codificación “html\_encoding\_guess”.
</p>
</td>
</tr>
</tbody>
</table>

##### Ejemplos

`html_encoding_guess()`

    # Cargamos el paquete rvest

    library(rvest)


    # Leemos un archivo html con mala codificación que viene incluido en el paquete

    (read_html(system.file("html-ex", "bad-encoding.html", package = "rvest")) %>% html_nodes("p") %>% html_text() %>% html_encoding_guess())

    ##     encoding language confidence
    ## 1 ISO-8859-2       ro       0.35
    ## 2 ISO-8859-1       es       0.27
    ## 3   UTF-16BE                0.10
    ## 4   UTF-16LE                0.10
    ## 5    GB18030       zh       0.10
    ## 6       Big5       zh       0.10

    # Dos codificaciones válidas, sólo una de ellas es correcta
    # "ISO-8859-1"

    read_html(system.file("html-ex", "bad-encoding.html", package = "rvest"), encoding = "ISO-8859-1") %>% html_nodes("p") %>% html_text()

    ## [1] "Émigré cause célèbre déjà vu."

    #"ISO-8859-2"

    read_html(system.file("html-ex", "bad-encoding.html", package = "rvest"), encoding = "ISO-8859-2") %>% html_nodes("p") %>% html_text()

    ## [1] "Émigré cause célcbre déjr vu."

`repair_encoding()`

    # Cargamos el paquete rvest

    library(rvest)

    # Reparamos una oración erróneamente codificada
    # "EmigrÃ¡ y BogotÃ¡ tienen tilde en la Ã¡"

    read_html("https://estudiosmaritimossociales.org/encoding__error.html", encoding = "UTF-8") %>% html_nodes("p") %>% html_text()

    ## [1] "Emigrá y Bogotá tienen tilde en la á"

### Tópico `google_form`

#### Hacer un enlace al formulario de Google dado el ID.

La descripción en la documentación sobre esta función repite la frase
del encabezado: ‘Hacer un enlace al formulario de Google dado el ID’.

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
x
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Identificador único para formulario.
</p>
</td>
</tr>
</tbody>
</table>

##### Ejemplos

### Tópico `html_form`

#### Analizar formas y establecer valores.

Usamos `html_form()` para extraer un formulario, establecer valores con
`html_form_set()` y enviarlos con `html_form_submit()`.

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
x
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Un documento en ‘read\_html()’, conjunto de nodos en ‘html\_elements()’,
un nodo en ‘html\_element()’ o una sesión en ‘session()’.
</p>
</td>
</tr>
<tr>
<td width="95">
</td>
<td width="51">
<strong> </strong>
</td>
<td width="650">
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
base\_url
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
URL base del documento HTML subyacente. El valor por defecto es ‘NULL’ y
utiliza la url del documento HTML subyacente x.
</p>
</td>
</tr>
<tr>
<td width="95">
</td>
<td width="51">
<strong> </strong>
</td>
<td width="650">
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
form
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Un formulario.
</p>
</td>
</tr>
<tr>
<td width="95">
</td>
<td width="51">
<strong> </strong>
</td>
<td width="650">
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
…
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
&lt;puntos-dinámicos&gt; pares de nombre-valor dando campos para
modificar. Proporcionar un vector de caracteres para establecer
múltiples casillas de verificación en un conjunto o seleccionar
múltiples valores de una multiselección.
</p>
</td>
</tr>
<tr>
<td width="95">
</td>
<td width="51">
<strong> </strong>
</td>
<td width="650">
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
submit
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
¿Qué botón debe utilizarse para enviar el formulario? 1 - NULL, el
predeterminado, utiliza el primer botón. 2 - Una cadena selecciona un
botón por su nombre. 3- Un número selecciona un botón por su posición
relativa.
</p>
</td>
</tr>
</tbody>
</table>

##### Ejemplos

`html_form()`

    # Cargamos el paquete rvest

    library(rvest)

    # Accedemos al formulario de búsqueda de google sin navegar

    read_html("http://www.google.com") %>% html_form() %>% .[[1]] %>% html_form_set(q = "Maradona", hl = "es")

    ## Warning: Setting value of hidden field 'hl'.

    ## <form> 'f' (GET http://www.google.com/search)
    ##   <field> (hidden) ie: ISO-8859-1
    ##   <field> (hidden) hl: es
    ##   <field> (hidden) source: hp
    ##   <field> (hidden) biw: 
    ##   <field> (hidden) bih: 
    ##   <field> (text) q: Maradona
    ##   <field> (submit) btnG: Buscar con Google
    ##   <field> (submit) btnI: Me siento con sue...
    ##   <field> (hidden) iflsig: AINFCbYAAAAAYPnDv...
    ##   <field> (hidden) gbv: 1

### Tópico `html_session`

#### Simular una sesión en el navegador web.

`html_session()` `is.session()` `session_jump_to()`
`session_follow_link()` `session_back()` `session_forward()`
`session_history()` `session_submit()`

Este conjunto de funciones le permite simular a un usuario interactuando
con un sitio web, utilizando formularios y navegando de una página a
otra.

-   Crea una sesión con html\_session(url)

-   Navegue a una URL específica con jump\_to() o siga un enlace en la
    página con follow\_link().

-   Envíe un html\_form con session\_submit().

-   Vea el historial con session\_history() y navegue hacia atrás y
    hacia adelante con back() y forward().

-   Extraiga el contenido de la página con html\_element() y
    html\_elements(), o obtenga el documento HTML completo con
    read\_html().

-   Inspeccionar la respuesta HTTP con httr::cookies(), httr::headers()
    y httr::status\_code().

##### Métodos

Un objeto de sesión responde a una combinación de métodos httr y html:
utiliza funciones del paquete
[httr](https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html)
como `cookies()`, `headers()` y `status_code()` para acceder a las
propiedades de la solicitud; y `html_nodes()` para acceder al html.

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
url
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Una URL, relativa o absoluta, en la cual navegar.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
…
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Cualquier configuración adicional de httr para usar durante la sesión.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
x
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Una sesión.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
i
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Un número entero para seleccionar el i-ésimo enlace o una cadena para
que coincida con el primer enlace que contiene ese texto (distingue
entre mayúsculas y minúsculas).
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
css
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Elementos a seleccionar. Proporcione uno de css o xpath dependiendo de
si desea utilizar un selector CSS o una expresión XPath 1.0.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
xpath
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Elementos a seleccionar. Proporcione uno de css o xpath dependiendo de
si desea utilizar un selector CSS o una expresión XPath 1.0.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
form
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Un html\_form para enviar.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
submit
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>=</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
¿Qué botón debería utilizarse? 1 - NULL, el predeterminado, usa el
primero. 2 - Una cadena selecciona un botón por su nombre. 3 - Un número
selecciona un botón en función de su posición relativa.
</p>
</td>
</tr>
</tbody>
</table>

##### Ejemplos

    # Cargamos el paquete rvest

    library(rvest)

    # Creamos el objeto s (una sesión en la web "http://hadley.nz")

    (s <- session("http://hadley.nz"))

    ## <session> http://hadley.nz
    ##   Status: 200
    ##   Type:   text/html
    ##   Size:   9090

    # Navegamos y recuperamos el historial de nuestra navegación

    s %>%
      session_jump_to("hadley-wickham.jpg") %>%
      session_jump_to("/") %>%
      session_history()

    ##   http://hadley.nz
    ##   http://hadley.nz/hadley-wickham.jpg
    ## - http://hadley.nz/

    # Saltamos la imagen y recuperamos el historial

    s %>%
      jump_to("hadley-wickham.jpg") %>%
      session_back() %>%
      session_history()

    ## Warning: `jump_to()` was deprecated in rvest 1.0.0.
    ## Please use `session_jump_to()` instead.

    ## - http://hadley.nz
    ##   http://hadley.nz/hadley-wickham.jpg

    # Recuperamos el texto del elemento "p".

    s %>% session_follow_link(css = "p a") %>% html_elements("p")

    ## Navigating to http://rstudio.com

    ## {xml_nodeset (63)}
    ##  [1] <p class="d-inline"><a style="color: #ffffff;font-size: .9em;" href="/bl ...
    ##  [2] <p class="d-inline"><a href="/black-lives-matter"> <button class="pt-1 p ...
    ##  [3] <p class="d-inline pl-0 pr-3 text-center"><a class="text-white" href="/b ...
    ##  [4] <p>The premier IDE for R</p>
    ##  [5] <p>RStudio anywhere using a web browser</p>
    ##  [6] <p>Put Shiny applications online</p>
    ##  [7] <p>Shiny, R Markdown, Tidyverse and more</p>
    ##  [8] <p>Do, share, teach and learn data science</p>
    ##  [9] <p>An easy way to access R packages</p>
    ## [10] <p>Let us host your Shiny applications</p>
    ## [11] <p>A single home for R &amp; Python Data Science Teams</p>
    ## [12] <p>Scale, develop, and collaborate across R &amp; Python</p>
    ## [13] <p>Easily share your insights</p>
    ## [14] <p>Control and distribute packages</p>
    ## [15] <p>RStudio</p>
    ## [16] <p>RStudio Server</p>
    ## [17] <p>Shiny Server</p>
    ## [18] <p>R Packages</p>
    ## [19] <p>RStudio Cloud</p>
    ## [20] <p>RStudio Public Package Manager</p>
    ## ...

    # Recuperamos el texto del elemento "p" a partir de la 4ª posición.

    s %>% session_follow_link(css = "p a") %>% html_elements("p") %>% .[4:20]

    ## Navigating to http://rstudio.com

    ## {xml_nodeset (17)}
    ##  [1] <p>The premier IDE for R</p>
    ##  [2] <p>RStudio anywhere using a web browser</p>
    ##  [3] <p>Put Shiny applications online</p>
    ##  [4] <p>Shiny, R Markdown, Tidyverse and more</p>
    ##  [5] <p>Do, share, teach and learn data science</p>
    ##  [6] <p>An easy way to access R packages</p>
    ##  [7] <p>Let us host your Shiny applications</p>
    ##  [8] <p>A single home for R &amp; Python Data Science Teams</p>
    ##  [9] <p>Scale, develop, and collaborate across R &amp; Python</p>
    ## [10] <p>Easily share your insights</p>
    ## [11] <p>Control and distribute packages</p>
    ## [12] <p>RStudio</p>
    ## [13] <p>RStudio Server</p>
    ## [14] <p>Shiny Server</p>
    ## [15] <p>R Packages</p>
    ## [16] <p>RStudio Cloud</p>
    ## [17] <p>RStudio Public Package Manager</p>

    # Recuperamos el texto del elemento "p" a partir de la 4ª posición y le quitamos las etiquetas html.

    s %>% session_follow_link(css = "p a") %>% html_elements("p") %>% .[4:20] %>% html_text2()

    ## Navigating to http://rstudio.com

    ##  [1] "The premier IDE for R"                            
    ##  [2] "RStudio anywhere using a web browser"             
    ##  [3] "Put Shiny applications online"                    
    ##  [4] "Shiny, R Markdown, Tidyverse and more"            
    ##  [5] "Do, share, teach and learn data science"          
    ##  [6] "An easy way to access R packages"                 
    ##  [7] "Let us host your Shiny applications"              
    ##  [8] "A single home for R & Python Data Science Teams"  
    ##  [9] "Scale, develop, and collaborate across R & Python"
    ## [10] "Easily share your insights"                       
    ## [11] "Control and distribute packages"                  
    ## [12] "RStudio"                                          
    ## [13] "RStudio Server"                                   
    ## [14] "Shiny Server"                                     
    ## [15] "R Packages"                                       
    ## [16] "RStudio Cloud"                                    
    ## [17] "RStudio Public Package Manager"

## Documentación sobre `rvest`

-   [Package `rvest`. Manual en
    pdf.](https://cran.r-project.org/web/packages/rvest/rvest.pdf)

-   [Package `rvest`. Manual más detallado en
    HTML.](https://rvest.tidyverse.org/)

-   [Package `rvest`. Nuevas funciones en
    desarrollo.](https://rvest.tidyverse.org/news/index.html)
