<br>

# Intro a `rvest`

<br>

## Funciones de `rvest`

<br>

El paquete `rvest` nos ayuda a extraer y recolectar datos de páginas
web. Está diseñado para trabajar con las funciones del [paquete
`magrittr`](https://magrittr.tidyverse.org/) (`%>%`) y facilitar las
tareas comunes de raspado web. `rvest` está inspirado en paquetes como
*beautiful soup* y *RoboBrowser* de **Python**.

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

<br>

### Tópico `read_html`

<br>

#### Funciones para leer documentos HTML o XML

`read_html()` `read_xml()`

<br>

El [HTML (HyperText Markup
Language)](https://es.wikipedia.org/wiki/HTML) es el lenguaje básico de
la [www. (World Wide Web)](https://es.wikipedia.org/wiki/World_Wide_Web)
o **red informática mundial**, un sistema de distribución de documentos
de hipertexto accesibles a través de Internet. [Acá dejamos un **demo**
para practicar el etiquetado HTML](https://liveweave.com/). La función
`read_html()` nos permite relacionarnos con este lenguaje.

La función `read_html()` es originaria del [paquete
`xml2`](https://cran.r-project.org/web/packages/xml2/xml2.pdf) que
trabaja con archivos XML y usa una interfaz simple y consistente. El
paquete`xml2` fue diseñado en base al paquete `libxml2` del lenguaje
`C`. La función `read_html()` convierte un documento XML/HTML (o nodo o
conjunto de nodos) en una lista R equivalente.

<br>

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
**x**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**encoding**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**…**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**as\_html**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**options**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**base\_url**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**n**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**verbose**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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

<br>

##### Valor

Un documento XML. HTML se normaliza a XML válido; puede que esta no sea
exactamente la misma transformación realizada por el navegador, pero es
una aproximación razonable.

<br />

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

<br/>

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

<br>

<p>
Como hemos visto, la función `read_html()` lee documentos HTML que están
on-line y que están off-line, literales y no-literales
</p>

<br>

### Tópico `html_nodes`

<br>

#### Funciones para seleccionar nodos de un documento HTML

`html_nodes()` `html_node()` `html_element()` `html_elements()`

<br>

Son funciones para extraer con facilidad fragmentos de documentos HTML
mediante los selectores `XPath` y `CSS`. Los selectores CSS son
particularmente útiles junto con <http://selectorgadget.com/>: facilita
encontrar exactamente qué selector debería usar. Si no ha usado
selectores CSS antes, siga este tutorial: <http://flukeout.github.io/>

<iframe id width="100%" height="800" src="http://flukeout.github.io/">
</iframe>

Asimismo, cada navegador (Firefox, Chrome, Opera, Safari, etc.) cuenta
con selectores nativos. Abajo les dejo una imagen del `Inspect Element`
de Chrome con las formas de acceder a la ventana del **Inspector de
Elementos**.

<img src="C:/Users/agusn/Google Drive/R/PROYECTOS/Tutoriales/Instalr_R/atajos_inspect_element.png" width="100%" style="display: block; margin: auto;" />
<br />
<p>
Además de los atajos de teclado y la tecla `F12`, también se puede
acceder si primero hacemos clic en el botón derecho del mouse sobre la
página web a inspeccionar y luego hacemos clic izquierdo en la opción de
inspeccionar, como se ve en la imagen de abajo.
</p>
<br />
<center>
<img src="C:/Users/agusn/Google Drive/R/PROYECTOS/Tutoriales/Instalr_R/InspeccionarChrome.png" width="100%" style="display: block; margin: auto;" />
</center>

<br />

Por acá dejamos dos recursos para interiorizarse más en la *inspección
de elementos*: en
[**chrome**](https://developers.google.com/web/tools/chrome-devtools/inspect-styles?hl=es)
y en
[**mozilla**](ttps://developer.mozilla.org/es/docs/Tools/Page_Inspecto).
Y por acá dejamos una breve introducción a los [**elementos
html.**](https://rvest.tidyverse.org/articles/harvesting-the-web.html)

<br>

##### Soporte de selector CSS

Los selectores CSS se traducen a selectores XPath mediante el [**paquete
`selectr`**](https://sjp.co.nz/projects/selectr/), que es una adaptación
a R del paquete *cssselect* de
[**Python**](https://pythonhosted.org/cssselect/). Esto puede ser
importante en algunos casos. La extensión *SelectorGadget* citada más
arriba también realiza esta función.

<p>
**Importante** | En los últimos días se actualizaron y renombraron
algunas funciones del paquete `rvest`. Es el caso de `html_node()` y
`html_nodes()`. Estas dos funciones están siendo suplantadas por las
funciones `html_element()` y `html_elements()`. Igualmente, por ahora,
las cuatro funciones están vigentes.
</p>

<br>

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
**x**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**css, xpath**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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

<br>

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

    ## {xml_nodeset (88)}
    ##  [1] <a href="/internacional/2021-07-21/el-chavismo-y-los-empresarios-venezol ...
    ##  [2] <a href="/sociedad/2021-07-21/grandes-farmaceuticas-anuncian-un-acuerdo- ...
    ##  [3] <a href="/internacional/2021-07-21/hashtags-y-directos-las-armas-de-los- ...
    ##  [4] <a href="/deportes/juegos-olimpicos/2021-07-21/venezuela-en-tokio-la-del ...
    ##  [5] <a href="/deportes/juegos-olimpicos/2021-07-21/en-brasil-juega-formiga-y ...
    ##  [6] <a href="/deportes/juegos-olimpicos/2021-07-21/la-gran-burbuja-olimpica. ...
    ##  [7] <a href="/deportes/juegos-olimpicos/2021-07-21/estados-unidos-blinda-a-b ...
    ##  [8] <a href="/internacional/2021-07-21/el-senado-de-chile-aprueba-el-matrimo ...
    ##  [9] <a href="/sociedad/2021-07-21/harvey-weinstein-se-declara-no-culpable-de ...
    ## [10] <a href="/internacional/2021-07-21/ee-uu-y-alemania-ponen-fin-a-la-dispu ...
    ## [11] <a href="/internacional/2021-07-21/bruselas-da-un-portazo-a-la-propuesta ...
    ## [12] <a href="/mexico/2021-07-21/la-desaparicion-de-10-miembros-de-la-comunid ...
    ## [13] <a href="/mexico/2021-07-21/la-marana-de-espionaje-con-pegasus-apunta-al ...
    ## [14] <a href="/ciencia/2021-07-21/el-cientifico-que-alimento-los-bulos-de-la- ...
    ## [15] <a href="/internacional/2021-07-20/peru-se-da-un-respiro-tras-la-proclam ...
    ## [16] <a href="/icon/actualidad/2021-07-21/pasearse-por-el-espacio-o-mejorar-l ...
    ## [17] <a href="/television/2021-07-21/jason-sudeikis-es-dificil-saber-por-que- ...
    ## [18] <a href="/icon/actualidad/2021-07-21/aj-tracey-le-he-comprado-una-casa-a ...
    ## [19] <a href="/gente/2021-07-21/la-hija-extramatrimonial-del-rey-alberto-acud ...
    ## [20] <a href="/internacional/2021-07-21/termina-la-luna-de-miel-de-joe-biden. ...
    ## ...

    # Leemos todos los elementos etiquetados con 'figure', 'a' e 'img'

    (html_nodes(elpais, "figure a img"))

    ## {xml_nodeset (1)}
    ## [1] <img src="https://imagenes.elpais.com/resizer/pVG5N0SqGxL3lN1bRCn1a2_NH7Y ...

    # Ahora repetimos, pero esta vez hacemos uso de magrittr '%>%' 
    # para encadenar líneas de código.
    # Leemos todos los elementos etiquetados con 'h2' y 'a'

    elpais %>% html_nodes("h2 a")

    ## {xml_nodeset (88)}
    ##  [1] <a href="/internacional/2021-07-21/el-chavismo-y-los-empresarios-venezol ...
    ##  [2] <a href="/sociedad/2021-07-21/grandes-farmaceuticas-anuncian-un-acuerdo- ...
    ##  [3] <a href="/internacional/2021-07-21/hashtags-y-directos-las-armas-de-los- ...
    ##  [4] <a href="/deportes/juegos-olimpicos/2021-07-21/venezuela-en-tokio-la-del ...
    ##  [5] <a href="/deportes/juegos-olimpicos/2021-07-21/en-brasil-juega-formiga-y ...
    ##  [6] <a href="/deportes/juegos-olimpicos/2021-07-21/la-gran-burbuja-olimpica. ...
    ##  [7] <a href="/deportes/juegos-olimpicos/2021-07-21/estados-unidos-blinda-a-b ...
    ##  [8] <a href="/internacional/2021-07-21/el-senado-de-chile-aprueba-el-matrimo ...
    ##  [9] <a href="/sociedad/2021-07-21/harvey-weinstein-se-declara-no-culpable-de ...
    ## [10] <a href="/internacional/2021-07-21/ee-uu-y-alemania-ponen-fin-a-la-dispu ...
    ## [11] <a href="/internacional/2021-07-21/bruselas-da-un-portazo-a-la-propuesta ...
    ## [12] <a href="/mexico/2021-07-21/la-desaparicion-de-10-miembros-de-la-comunid ...
    ## [13] <a href="/mexico/2021-07-21/la-marana-de-espionaje-con-pegasus-apunta-al ...
    ## [14] <a href="/ciencia/2021-07-21/el-cientifico-que-alimento-los-bulos-de-la- ...
    ## [15] <a href="/internacional/2021-07-20/peru-se-da-un-respiro-tras-la-proclam ...
    ## [16] <a href="/icon/actualidad/2021-07-21/pasearse-por-el-espacio-o-mejorar-l ...
    ## [17] <a href="/television/2021-07-21/jason-sudeikis-es-dificil-saber-por-que- ...
    ## [18] <a href="/icon/actualidad/2021-07-21/aj-tracey-le-he-comprado-una-casa-a ...
    ## [19] <a href="/gente/2021-07-21/la-hija-extramatrimonial-del-rey-alberto-acud ...
    ## [20] <a href="/internacional/2021-07-21/termina-la-luna-de-miel-de-joe-biden. ...
    ## ...

    # Leemos todos los elementos etiquetados con 'figure', 'a' e 'img'

    elpais %>% html_nodes("figure a img")

    ## {xml_nodeset (1)}
    ## [1] <img src="https://imagenes.elpais.com/resizer/pVG5N0SqGxL3lN1bRCn1a2_NH7Y ...

    # Cuando la función html_nodes() se aplica a una lista de nodos, devuelve todos los nodos coincidentes 

    html_nodes(elpais, "a") %>% html_nodes("img")

    ## {xml_nodeset (1)}
    ## [1] <img src="https://imagenes.elpais.com/resizer/pVG5N0SqGxL3lN1bRCn1a2_NH7Y ...

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

<br>

### Tópico `html_text`

<br>

#### Función para extraer atributos, texto y nombres de etiqueta de html.

`html_text()` `html_text2()`

<br>

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

<br>

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
**x**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**trim**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
Si `TRUE` recortará los espacios iniciales y finales
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
**preserve\_nbsp**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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

<br>

##### Valor

Un vector de caracteres de la misma longitud que x

<br>

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
        Esta &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; es otra oración.<br>Esto debería comenzar en una nueva línea."
    ))

    ## {html_document}
    ## <html>
    ## [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8 ...
    ## [2] <body><p>Esto        es        un        párrafo.\n    Esta        es otr ...

    # La función html_text() devuelve el texto subyacente en bruto.
    # Por una parte, incluye los espacios en blanco que serían ignorados por un navegador.
    # Por otra parte, ignora las etiquetas <br> de salto de línea. 
    # Por defecto, html_texto() lee tanto los espacios en blanco (&nbsp;) correctos
    # como los espacios en blanco repetidos. Veamos:

    writeLines(texto1 <- html %>% html_nodes("p") %>% html_text())

    ## Esto        es        un        párrafo.
    ##     Esta        es otra oración.Esto debería comenzar en una nueva línea.

    # La función html_texto2() simula lo que un navegador mostraría. 
    # Los espacios en blanco no significativos se colapsan, 
    # y las etiquetas <br> se convierte en un salto de línea. 
    # Por defecto, html_texto2() también convierte los espacios 
    # que no se usan en espacios regulares. Veamos:

    writeLines(texto2 <- html %>% html_element("p") %>% html_text2())

    ## Esto es un párrafo. Esta es otra oración.
    ## Esto debería comenzar en una nueva línea.

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
    ## [26] 20 65 73 20 6f 74 72 61 20 6f 72 61 63 69 c3 b3 6e 2e 0a 45 73 74 6f 20 64
    ## [51] 65 62 65 72 c3 ad 61 20 63 6f 6d 65 6e 7a 61 72 20 65 6e 20 75 6e 61 20 6e
    ## [76] 75 65 76 61 20 6c c3 ad 6e 65 61 2e

<br>

### Tópico `html_table`

<br>

#### Función para analizar una tabla html y convertirla en una base de datos.

`html_table()`

<br>

Esta función imita lo que hace un navegador, pero repite los valores de
las celdas colapsadas en cada celda que cubre.

<br>

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
**x**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**header**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
</p>
</td>
<td width="650">
<p style="text-align: justify;">
¿Usar la primera fila como encabezado? Si `NA`, utilizará la primera
fila si consta de etiquetas `<th>`. Si `TRUE`, los nombres de las
columnas se dejan exactamente como están en el documento de origen, lo
que puede requerir un procesamiento posterior para generar un marco de
datos válido.
</p>
</td>
</tr>
<tr>
<td width="95">
<p style="text-align: right;">
**trim**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**fill**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**dec**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**na.strings**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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

<br>

##### Valor

Cuando se aplica a un solo elemento, `html_table()` devuelve un solo
tibble. Cuando se aplica a varios elementos o un documento,
`html_table()` devuelve una lista de tibbles.

<br>

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

<br>

## Otras funciones `rvest`

<br>

### Tópico `encoding`

<br>

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

<br>

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
**x**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**from**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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

<br>

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

<br>

`repair_encoding()`

    # Cargamos el paquete rvest

    library(rvest)

    # Reparamos una oración erróneamente codificada
    # "EmigrÃ¡ y BogotÃ¡ tienen tilde en la Ã¡"

    read_html("https://estudiosmaritimossociales.org/encoding__error.html", encoding = "UTF-8") %>% html_nodes("p") %>% html_text()

    ## [1] "Emigrá y Bogotá tienen tilde en la á"

<br>

### Tópico `google_form`

<br>

#### Hacer un enlace al formulario de Google dado el ID.

La descripción en la documentación sobre esta función repite la frase
del encabezado: ‘Hacer un enlace al formulario de Google dado el ID’.

<br>

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
**x**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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

<br>

##### Ejemplos

### Tópico `html_form`

<br>

#### Analizar formas y establecer valores.

<br>

Usamos `html_form()` para extraer un formulario, establecer valores con
`html_form_set()` y enviarlos con `html_form_submit()`.

<br>

##### **Argumentos**

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
**x**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**base\_url**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**form**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**…**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**submit**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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

<br>

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
    ##   <field> (hidden) iflsig: AINFCbYAAAAAYPi9d...
    ##   <field> (hidden) gbv: 1

<br>

### Tópico `html_session`

<br>

#### Simular una sesión en el navegador web.

`html_session()` `is.session()` `session_jump_to()`
`session_follow_link()` `session_back()` `session_forward()`
`session_history()` `session_submit()`

<br>

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

<br>

##### Métodos

Un objeto de sesión responde a una combinación de métodos httr y html:
utiliza funciones del paquete
[**httr**](https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html)
como `cookies()`, `headers()` y `status_code()` para acceder a las
propiedades de la solicitud; y `html_nodes()` para acceder al html.

<br>

##### Argumentos

<table>
<tbody>
<tr>
<td width="95">
<p style="text-align: right;">
**url**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**…**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**x**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**i**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**css**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**xpath**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**form**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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
**submit**
</p>
</td>
<td width="51">
<p style="text-align: center;">
<strong>**=**</strong>
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

<br>

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

<br>

## Documentación sobre `rvest`

<br>

-   [Package `rvest`. Manual en
    pdf.](https://cran.r-project.org/web/packages/rvest/rvest.pdf)

-   [Package `rvest`. Manual más detallado en
    HTML.](https://rvest.tidyverse.org/)

-   [Package `rvest`. Nuevas funciones en
    desarrollo.](https://rvest.tidyverse.org/news/index.html)

<br>

<img src="data:image/jpeg;base64,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iigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACijPNRmYEgg8YyPcUASUZ+tYviHxrpfhG0a41TUrPT7cEAzXNwkKDOe7EVyNx+1d8ObLKt428OzbRlmhv0m2DPcoSB+dBrGjUl8KZ6Rmk3V5/pv7THw/1d1W38beGGllICodThSTJOANjMDkntiu0sNRjvo45YZ1mjkztZGDKce/8AhQKpSnD4ky7RTRKCxHpTqDMKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKYWIoAfRUdFAElFR0UASUVHSb+fvGplJLcCWioRKpNcr8Qfjf4P+FEKyeJvFnhvw4kn3G1TU4LUP9N7DP4VUYyk+WCcn2SbbB2W52FGa838C/tVfDX4j6mtj4f+IXgrXLxhlbex1u2nmYd8IrliPwrvvtGf4trdMZ70qqnSajVjKL7NNP8AEFZ7MtUVAGLfxZ+btT6UZJgSUVHRVASUVHRQBJRUdSA5FABRRRQAUUUUAFFFFABRTe33qcTgUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFBOKKrzzRxyLuzk8CmtQHPIoYNg9MD/P8AWvmn40ftTap4z8Sap4L+Fu261C2lFpqXiRnhay0qcrn7Jb+YQs9642qFP7uMyBpGwu2tj9r3xDrHinxHovgHwvrVrpF/qdvPquoFrg273dtD8qWfnqC9v9okY5lUbhHBKFwxBr5x8F/D/wAUfHqcfDnwtZ2fgv8A4Q/zmu9ahsVjuPCEjs80NhH5bCO5mMv70TA74kbeziaRWpxVz3Mty9Sh9YrNJefTs/PZ6IgZPAXhHxv4B8VLfaj4w8VayzS32karC+s+K1dY5MFVYOYsXSGMxxrFHtlYqQFzW34/8Z/Fr4Z/C7WdRuPAfjCbw/rF/p89wmqeILOO5tbua+hjc25ik8yOOWRxtQcRcyDB/dV7d+xXeeHdOg17w5J4X0fwn8RtAby/FFtbIZHvsu4jvVmk3Sz284QsDI5dMFCAysKqf8FFvi54T8K/s9ahp+oeJvD9lff2rpcn2a4v4Y7gImpWzyNsZgdqqGZjjGATVPY9CjX58ZHBwpXTaV3fRPayi1p8330OJ8e/ETxd4U+E+j+HfFHw78e6Tp+m3MT6pqNhaW3iBbu0DFpYh5AeRc5TkRZGzrXDfDfxBN4Hisde+EfiTSPD2n6lNdNPpsUhvPCx2GU29vLGq77e7aGF1Y2uCHQAwuSd33P4Y8YaT440ldQ0fVNO1Szlz5c9ncJNG+Oo3KSD74NeZfHb9lCw8fx3+teGZm8LeN2ljvbfUrcLJb3FzEVMb3VuQY5ui5Yr5gVVKsGVcEkcVPMaU5+yrU+S/wDievmpNtf1oan7NP7SEfxlbUdH1XSNQ8KeMtBSI6rol78zRrJlkuIZvuzwSfNtdeRghgrAqPWhKDX5/wBx4z1ieLVbi41LWPDvx30nVZJrq2EW7T9PykTnz5SuDpM0UEQQsQSRn/XRuR9ffs5/Gyz+PnwxsPEFrDNY3MnmW2oafM377Tb6GRorq1kHXdFKjLk4yMEcEVMjjzDBOk+eOz+75d15noZbBpajQYZvSpKk8tBRRRQMKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACoz1qSoz1oAKKKKACiiigAqvcyRq5LMy4Qnj0HWrFef/tQfFj/hQ/7Pnjbxl5ccg8MaFd6kqP0d4oi6D6Erg/UVdKlOrUjShvJ2+/QL2V0fmJ/wX4/4LmeJP2U/HE3wW+Ec1rp3i9rNLnXPEJJkk0dZMFYYEPSZkIO4g7c9K/CPxz4y1f4meLrzXPEmqaj4g1u8dnmvtTn+03EmRzz1q58T/itr3xz+Ies+MvE2pXGreIPE90+oX13OcySvJkkE+gBCgDGAord/Zl/Z08S/tbfHfw38N/CNvDPr3iq7FrA8x229upXc8k3faqIxJ47V/ZPCvDWXcO5ZHljaVm5y9LXvu+XX77HiTrTqT5T0T9k79k/R/iRZQap448J/GDQ/C8hxbeMPDGjG9tdOfBId4/LLNH/eaLJ5GM1+v37JVz+0X/wTY8JaD4wu/iZY/tDfstXEcc2oakVc6z4bsGyou080+Y8MLMGdDnagZjwK6D4T/wDBvb40/Zq+Fkcvwv8A2mfiX4b+IVrAslvOszNojuAMxSWbMY2jPPVc8DivtL9grxb4k+JH7MVnB8QPDum6P410eefSPEtnaQItnd3sWY55olxtMcudwwMEE9jivxTjbjShmKbw7VWldxlFpq21mk1dPezUmm1qrHfRw0ou7PX/AAl4103x14c07VtGuob/AEvU4kuba4hYNHOjdCCPTv6fnW3XC/Bj4K6T8ENPutI8NxLp3huR/Ps9KiDC20wn76QhshI2PzeWAFQ5Cjnjuq/H5qKm+R3j07/Po/kkdoUUUUhBRRRQAU9Pu0ynp92gBaKKKACjNIzbRzWF4/8AHOm+AfC1zq2pTm3trUKThC8jlmCqqooLMzMyqFAJJIAGeKBpNuyNp5lArm/FHxg8L+C71rfVPEGi6fcKAWiuLxI3UH1BOR2/OvF5/iPq3ie51nUtc1KO3sdN1OCFtAhvPs82n2LNGkk9w6MHZlMpLfMI1UFW+YNXJ6Z4g8rwtNp/w98Oaxfa7YaxcMdT03RIYre8gilZ4Y2uJEigYSKI1YKxKkFsZwSHVHCu/vH0Npv7QngfWbiOK38W+HZpJWKIiahEdzenXr0/Ouwt7tZbdWX51boVIYHPQ/jXzXpPxTiks9avfGvgrxZceH9Qm+06e2qaXHqkMKjIZT9nMrRx7iCA6KQMr0ABp+A/FV4fhFod9ouvQaVrWpSm30ho2Y6JLKlt5siTwHIgg86OeLfGqOPkx8zHIVLCvofUpfFLnNcf8K/iOvj7TpvOsrvS9TspPKvLK4XDxMwyro3R43Ugqw7HnBBA6wfIuO3Wg45Kzsxq3KMcbm/z/jTvtCg87h9R06/4V89/Fv4EeOPEvxJ1TUNH1eztYdWu7QpdvMTPp1jHaSI8MO6MiJ2uGWUMhGcMMjmuL8afD344Q+Pv7H0/X51sdWv5ZNPvoZpWTTbZBcEeeSpHmNvgChuGMJx3NJux20sHCav7RL1PrhrlEXJbA65ppnXep3DDH/69fNvxN+CXxY8V/DfR9Ct9esbrzLu5l1oXVy5E0T3kbwxblQO6pb+YhBxuJXqBmjxP8Cvifr+i+D2/t6yOtaBoF3DcXzzuHXV7hoUa4XC4KrCboLwdpZePRh9UhZNVFvb/AIJ9KfaoyfvZx6c+v+FBuVFfO/h74NfFS0tdJXUPFk1zsMp1GKLUXb5jBH5aqzpkjzPNH/A1zkDA5fX/AIf/ABg8Lapo9xeahrGsR3d6tnPJo9+zXcNuYIwWPmLsj/eJuYjGSG6/LgBYODf8WJ9YfaFH+enX/ChbhWGfm/KvlDTvgl8eNUa8j17xHpd5Z3TJ8jXLFFYSWZLFPKyV2Lefu87d2w/xVr/D34HfGDRviN4f1DUvENp/Za3q3WtQ215Jm4PkeW27cmZOYYyASMCRh04JYJYOCi2qif6n05niimxnKU6g4QozRTZTiNqADzQfX8KPOXdjv0I9K8s/ai8Z3Xg3wVYzWuryaDHc6kttNfrLBCUHkyvHGJLhWhj82eOKHdIMDzD3wD5Vo37VnjTV9F17xBp9n4fuPCHhXSbS9mk1KRm1KTz9MjvNx8sLHhHdFYqmG3N02GtoUJTV4mUq0YuzPqjzlA9PrxQJMno3TPSvkzxX+3hrcPiW1/sNvBt5pKz6gQWuJJJ9Xit9Tis1S0KMFaR1ctuG8DH3a9R/Zd+NuofF7Tte/tObw/qDaTcQCPUNCLNZXAlhSTZ8zMfMi3bHw2ORnHNVUwtSC5pWFGvGTsj2LzR7/hS7q+P/AIg/th+JvBnj/wAafYJdF1f+z7qx0qxs4Nqx6O013qMTSXLySqjSP9miypkjUebFlScE+1a38QtS1L9mCbxHqU6+DNWk0I38zLcwTR6dN5e7AkO6FlLcBiWDZ4JqZ4ecbPuEaylc9VEoOPRuhoWXd2P418q6N+094vtrHwvp+gto/i6bWPClvqUd5cT5n1PUnt7+4EW6EeVs26e8eVHWT/YNO8Hftu658RvEngmXR/C8cugeOr+7+xzzTJDJ9ihNtE0x8xlHnB5ZX2IsrNHAMKoYsNFg6j1jb7yZYqCV2fVHmjPegyYPf6ivkNf2r/HXinwbY3lvqHhHw9qFj42s9I1xWg+1WtlazALGv2lJ2jl3HCtMrIc5TYjc1c8ffteah8MIfiRJ/bfhvVrzT/FWnaRYhGadNJtrqOAeZJAreYWQuxKhlDOCoKnij6nU5uUX1qDV0fWHnL/n36UCVSP0r461D/goTr3h/wAb6lpc2l6PqTWOhTXsq2wMf2a+ihsmlRm852eENeH5yirtiG0sMsOs1j9pDWfB/jGze48QeDvEzTeC9W1e107QJ9g1K+tZotojVnYsrxlgNpLK0Mxyw+VCWDqx3sOGKhJXifTPmr6+p/KnV8h/DX9q/wAaXXiI2P2rwp4k0nT9WtFvtUtZZZIrqC6mskRbbHyAxNdEMGxjyjivra2kLR7mCj6GsalGUNzSNWMnZE2eKKRPu0tZmgUUUA5FABRRu+bFBbBoAKM4pm7kDbyRmmXP+r4HNAEm/wCv5U7Oa+Hvgx/wXa+Cfxu/4KF6p+zbpLeIl8Zafd3em297LaKunX95ZrI1xAjbi4ZRE5ztwdp54OPt+HiMdfxoAdmk3c1S1HUk06K4mkbCQRiVsDJCjJPHXoK/Obwz/wAHUv7Jfi74gaf4Zs9Y8cNq2oalHpUSt4ckWPz5JPLXL7sAFj9fagD9J6KM0m7P/wCqgBaKM0FsUAFFJuoDAmgBaKM0ZoAKKAciigAoozRQAUUZo3Ad6ACijNGaACiiigAooooAKKKCcCgAoqKW4WNNxyB+VJ5vHRvyqZSSVwJs0bqonVbUXnkfaIfP6+XvG/HrjrVh5Vxn5gO5Ixip5n1/r8AJqKjWUBBmpAcitACiigtgZoAM0E4ri7T426BqGr6jZ2cl9eSaTeQ2F69tYXE8MM0qxsqGREKZCyxlufkDAtgc1Tn/AGjvBkOv/wBmvrsP2xdY/wCEe/1biAals3rZmYgRiZl6IWBJIHUgEA9AzSbvY+3vXntt+0f4Ku/G2r+HY9YSTXND1G20zULEWs3n2k1yoeAum3IjdTlZCNhx97pm3/wvXwul74ktTqUn2jwrdQWOpx/ZZt0FxOIzFCo25ldxNDhUyT5qY+8MgHcA5pu8Vxfi346eHfBGif2jq099p9o2pW2kK0+mXKs9zcukcCBSm473kRQQMbiFznis3xV+0x4P8Cyab/al9qFn/bFxa2Njv0q9ZZ7i4LC3iBWIjfIQflznlePmXIB6QDmiqOga3Drui2t5brcrDdRrLGJ7d4JAD/eSQBlPswB9qvUAFFFFAAWxTRID/e/Kud+LfxR0P4K/DTXPF3ibUIdJ8P8Ah2zkv9QvJj8lvDGpZmP4CvzD8A/8HQnhf44ftDReDPh78HfGfizT5J2ht7sajbWV1dgMFZooJCFHXIWWSPPQc8V6uX5Hj8dTqVsJTco01eT0SX3tGNSvCD5ZPU/WDNFc78OPiBZ/Ejwvb6tYiZIbrKtDPGYp7aRSVkhkU/dkRgysMnBUjnFdFXlNWdmbBRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABVHUZfJt2kZlUKu4segq9XG/HzWpPDfwU8X6jAhkuNP0S9uYUH8TpbyOv6inHc0ow56kY92fB/iP4j2/xCtPE3xKXUd3jHxXfQp4c0iO7SWK6tEvBp+n2t1CVY+U/m/ai2VY+dLgLsNfa37P3wI0/wDZ8+Fdj4d0+SW6kiaS4vL6QfvtQupCTLM3Xqx4GflXao4FfHeiaxdeD9C/Z10N5NJ1HQI9U0q4Njo9hO2qTyRaRdTRSTkkLIrSW5YYDHIyOnH1Z4q/aWbRvDuoXkHgnx9JNa20s0YbRXBZlUkcAf7I6+tOLs7n0GZYetVVPD0rWbdtbbNpb9ld+rfovm/9tfxfdeP/ABF4n8aeFr6TwrbfCNJNCutbtJWW+8YXE21rrQYFGV/55hJSrsLl1WMLsdmyPib+zfDp/wCyT/wkmk+HfhX4dTUbvSLmNrHS5Nbvist9assj6lJIjyddzsUIKKcnvVP9nfxtZ69e/s+6JdeHfFmqabpvhu+8fzxrpPmrqupzNEFuMfxiNr64kDAkBnRuCq5zv2gfGHiD9mn4ZyeCdN8FeNdY+Guva7YS6GF0phqHhtzqENw1iseA1xb7UlMflh3XO0jYMh82h7uDpYihWo4eCSlBp3cltez/ACb12vokekfFz4Pt+zr48t/Ek2m2vgfT7qZIm8aeA2bT4bWckbV1XSpDJFNbEnHm7n2cswQfPX0b8DfiNq3if+29J8SjSYvE3hm9+xXJsCy21zDIizW1xGjMzIskb8oXfa0cgBYLk8NeftNWnxv8AyRWXwt8eeK/DfijTmiWWOGySz1C3lQgjEtwpClSc5UYOQeRivlz9jz45/Ezw38X/CsFj8Odc1u91HwZe+Hpln1+yg+2Lo2qvbwXTnzG/wBWlw0RfkuzHG5fmFnifU62Lw8lW5YyhprOKulr1a6KV0utrdj6J/bp8N6f4V1/wX4wutIstRtb7VIPDmprcq7wETOJLGWWNGQTCO8jjiCOwQ/avm5C4Z+zf/wk3w1/ai1Kx1yzhtbT4nadLr0iwxFI4tQtGt4XeNC7FEmt5oso+CHt5D1Y44/9vDxv8ZPEf7M3iJtS+HfhrQdNsTBeyXf/AAlPm3URhuIpVaKMW5UsNpHLAAkMDlQD0PwkgR/2gfDeoRx6bIl9q+oW0ctnqBuFtbdbCcwRbXAbO1dzseryEkcis35lU6bWBdKdno9U1JJLVJNNrf1PrSF9zNUlQwDBapqlny/QKKKKACiiigAoooJxQAjOEHPFQvqMcTqrEqWyRkdhySfTHv61FrGrW2iaXcXl5NHb2lrE080shwsSKMsxPTAHNfn3+29/wUq8P+Fdf/szV/Fn9i6Lf4j0vRrSeWzv9V+4Ulu2wrRWcqltrb0GGy5xU30craJNv0Su9kxSuldf5H3Lrvxz8HeGNQa01LxNolhdqwQwXF5HHKpJwAUYhh26juKu+FPil4c8dCQ6Lrml6v5e3f8AY7pJzGWBIDBSSpIU8HHQ1+T/AO0d8YfEHwb/AGevE3ibw7N4a0e1gsGkstONub4XMU10sqB596FyN7APGmMAKCQoNeJ/Cb/gtJe+JvEVmfiR4bsdLNvp6Wena/4R86zn05lO5ZXjVzkOMBgh53LuUhAp+YyTjTKc2U5YGo5Ri3Fy5ZxSa6e/GLfqtD7vA+G+fY3DTxOEpKfL0i1JtWvol1P3m+2R4zk/kab9tjJ43N9Bmvmn9kD9tDTvi3FZ2MnibRfFml6sXi0PxHYyJGdWdF3SQzQ/IyTLtkwwjRXEedqklRqf8FIv2stS/Yo/ZevPHWj6TZ63fQ31rZJbXLlIysz7WYkc8V9fh8PPEVY0aGrk0l21Pz7H11goTniU48l+ZPRpro13PoJtQiQfMxH1FS7/AOWa/KL9i/8A4LefEz9p79rfwX4K1Pw94P03RvEF21vdS2kc5nQCBnOwl8D5kFfqwWAXOG+70xXZmuUYrLqio4pWk1c83Jc9w2a0pVsI7pO2o4XSt60Ldxu21TuPPT2618o/8FZf2zvFX7Df7P8ApPirwnZaTfX95rcWnyRairmERtFK3AUqc/IO9fPv/BOT/gtR46/a8/ab0X4feJfCfhzT4NUt7iU3tjNLvVoomk+6+RglcfiK6MLw9jq+BeYU0nTje79DlxfFWBw2PWXVm1Ulqu3b9D9MDcqq5PygevFAuVJ/i59q8x/aV/aEX9n7wXZ31toeoeKPEGuXyaVomhWLKtxqt00TyeWGchUVY45JGdiAqoc84B8t0T9qP41eF9f0W4+I3wUtdD8I6ncw2dxqWi+JE1ibRnlcRo1xbrGrFA7KGaMuF5JwBmvJjRm1zd9j3ZVktt9D6e+3R7iN33eue1OW7VgfvcHHIx/OvDf29f2lV/Zf/Z51PVrH7TceKtY/4k/huwtlDXGoajOCkKxqeG28yEZAIj5xUXwi+Jkw/Yl8L+JvhbbXnxPabSLWbTI73U47e41RWaNZDJO42K65kY5OMoRk8Uewm4Ka2vYr2kfaci7Hu7XKr6/lQ12iKWY7QM5z7V8W+C/+Chvxm8c/F7xb4F039ntZfEngWO0fVoG8ZWarbi5jEkPzlcNuU5+UnHfFdFrX7bvxV/4XBe+CfDvwROva9o2h6bq+sRnxVaWsdhLded+43uB5m3yvvJkHNdH1Ctzcvu9/iWxj9cppJvvY+sPtcefvdF3H2FH2hQf8a+bIv2rvid4O+FvjrxV8QPg63hOz8HaJPrNqsfie1v8A+03iUuYMxg7CFUncRjjjNcl4R/4KBfFrVfhZpPj66/Z71abwXqVhHqv2zSvElre3cdm6CRZhbcO37shtoBfHG3PFZrB1rNvl000ad/RdfkV9ahex9gmdQMk4HrSfaVzXzP8AHj/godpPgf8AZ98D/ELwDpS/EG0+IOt2OgaMkV6LNZ5LtyiBmf7jbwVwwyCORXP+K/8AgoP8QPgHbabq/wAWPgnf+EfBt1fQafc65p/iS01aPTZJ5BFE0sUZ8wq0jKoKhuWFOODrNXS/Gz+4PrVM+uvOXH+NHnArnn0rxb9s79rSH9lH4bafqFtot74r8UeINRi0rQvD1kwS81i5c5ZIw2ANsYdiSQAF69K6P9lL9ofS/wBqb4BeG/HWkxtbw65AWntZDmSxuUZo57d/9qOZHQ+6msvYzUPaNabGirRc3DqekUUA5orM0CiiigAoooJwKAGlwKa9wsY53fgCf5V5h+1N+154D/Y/8E2PiDx7qs2l6bqF4LK3eO0muDJKVZwuI1YjhScnjivIvgH/AMFevg/+0t8a9L8B+FrrW77WdWEhtTNpjQQtsjaVstJtP3EY9P4TXZSy3F1aLxFOm3Bfatp955mIzrA0MRHC1aqVR/ZvqfVyyq/Q0GZVHPFRINpPTiuD/aT/AGg9B/Ze+Eer+OPExvf7F0NY2uRaxedLh3CDC5GfmYd65KcZTlyQV29kjuqV6dKDq1XyxXVnoDXCquecfSlEykjn73T3r5B+G3/BbP4A/EXxPpeh2viDVrTUtYu4rG1hudHuV8yaVxHGm5UKjczAZJwMjOK+sZ3ZbZ2VW+6WG3GRj0rrxWX4rCyUMTTlBva6av8AeceBzXCYyEqmEqRml2d/vLvnLtB7Gmi4U9+vT3+nrXgHhL/goD4d8U+CI/FU3hbx1pvg91kf+3Z9KElmI0dlaUrC8kyx/Kx3PGowOcV33/DQ/hu68f8AhPw3aXUl3c+ONNudV0u5tsSWs1vAIS7mTP8A03ixjru9jWE6FSK2N6eOoS05j0E3Cqe9ILyNlDdvp/n0rxL/AIbRs7vxTr+m6f4I8faxb+GdRk0nUNQsbCGaCGWMKXwvnec+N6/cjbO4Yra8GftaeEfiN4l8F2Ph+7uNVh8d6de6jpd5FAywSR2rIku4tgqys4UqRkE49af1WvF+8un5K7/AiOYYeW01v+bsvxPU2vY0PLe1Ib1AM/P0z9015/4k+NOm+Hvixb+C2gv7rXLzRbjXYoYYg3mwxSJGwUkgbi0i4BwPcV5zp37eC6t441Lwzb/C34qtr2j2tveXVm2m2atbwzFxE5/0k5DGOQcZxt5xxlwwtSSul0v8tr/eKpmFKDs+9vmk219yZ9Dfb4vM27vm64xSi9jZ9uTnGeleMfEf9tPwj8Jvib4d8LaxHqlvqmvR2zSMluHi0cXMvkwfbHDYh3ygxjrlh6c1v/GP9ofSPhBqmk6W1nquu+ItdSZ9M0bS7cz3d4kW3zJOoRI13Ll5GVcsOaSw9SyutwlmFFRk0/haT9W0ektdqoz834CmnUIgV+b75wvHU15L4P8A2ntN8SnWrXV9B8TeFtZ0HT21a40vV7JBcSWo3DzYmiZ4pRlcEI5ZSVDAFhmTV/2ofDtl8IfDfiyFLu4bxpawTaBpscf+nanJNF5qwon94LksSdqBSWIUZoeHmrK2rK+vUlrfRXv302PVkv45Putu6jj1pxuo1k27vmPIHrXzf+y/8edaTX18M/E+61LSvHeutNd6dp+oaVFZ2pgjXc8VnLGzibavJ3v5gAJKgc11v7P/AO2J4R/aPvtUt9FfULDVNLd1lsNTtTazPEsrw/aIwSRJCZEZd6k4I5xkZ0qYWcZNLVLqRRzKjKMXJ2bWz76X/M9jjuVlHHfP6VJXJfCf4hWXxU8I2uu6WJl0+6kmSMSjDZileI8ZPBKE/TFdbXPJWdjtpyUoqSd7pMKKKKkoKKKKACoz1qSoz1oAKKKKACiiigAryP8Abs+GVx8aP2Ovid4UtQ7XWueGr62gVPvSOYHKqPcsFH4165UM6BmwQrDbyCOtaUcQ6FaFZfZafrZ3sFrqx/E3FYT6YjWtxDJDcWRNvOjqR5TplWB9MFSK9u/4J2ftht+wZ+2J4P8Aie2lrrVlocrW9/Zq22We0mBWTYx4DAMCM+mM19Tf8HAH/BLPxV+zD+1j4s+JXhXwlqE/wq8XOuqf2jawmS30q9l4uIZQuSiu6vKCV2/vDzX51/aIY4htkjeJiQjFhiQAlePy/MV/bWW4/A5/lUZ6ThUjacU9Yt20dpJrb/hz5+cXTnd7pn9YnwI/4LK/s2/tBeDrXVNH+K3hWyMkatJZ6ndCxuLZioYq6y7cEZweoz3rsNG/bw+AWiG4Fr8VPh7C11MZ5iNYh+eRupJ3Y/kB71/IPe2VnIzG4it2ZR83mBWZRycfw9eM5JrrvgH+zf4g/ae+Meg+APBOhf2x4o8QXC29vBFAG8lf4pZMnCooBZmYgAA98Cvy7GeCuWU1UrPFzp00nL3oxaSXdp/dfzOyOYSa5ban9jPwy+MvhX4z+H21Xwnr+m+ItLWU25urGcTw7wASu4cEgHnFdPXhf/BPb9i/Rf2Bf2UfB/wz0WKH/iRWg+3XMa7RfXj4eefH+04JHt6V7pX88YqNCGInTwsnKEXZNqza7npxvypsKKKKxGFFFFABT0+7TKen3aAFoJwKKRzhaAIp22w5HynivmL43/GEeK7jUVj1W48P6fofm/8ACPXUdkZl1G5TdA8gOzna5MUYjO75mc5ABHuPx18azeBfhVrF7ZqX1BohaWKY5kuZmWKJcdeZHXp6GvHfhppcN34p8N+FUudB1jRdLJ1O1FpK8jWhtAY/McOF2s000MpAJyyv2PJ0OvC+7eb6FPVfBt/qvj7wp4h+J1jYw6ZrkS2IsbI7YLS7kfMKXvLeesi4UlWEayKFw6ssg+iH1LT9NsfNkmht7eMYLPiNIhkjBPAABGMHHpzXL/G/VLHT/hze2d5i4uNZH2G0tUJEl3cuD5aIRna2cEMRhdmTgDj49179rf4b+Hb0aV8TNZ8K+MfH1ndTW95JrmsJBoVs6kgNbwgSZBUqDshdlZGDFSuSSlGG50U8NXxa5qUW+Xt27r0+V3ZXPsj4N69Yat8O7D7LeQ3AVWG6KUOMl27jPfIx7Vzfj79mPSfEPitfE2jrDpviCOdLuXKlrLVJFUKouYxjc2CQJEw4HUkfKfGfC1h4f8H/AA8sfE2u+H9J8J6VLatdReNPCOrLH9jidziSddsZeI9QWWdOSSgAJr2P9lv9pPQ/jn4VENjrdrr11Zg7NRgjZINXtw21bqHIAZW+UMUyockZPGXzRexFbC1qV5wd43tfp6X799n5I80tPiZfaF4yeWFdSfx41zcRappJULaXEe/fHal3Zskp89uyDALSK3lB3x9K+EvFtj4z8M2OqafOLiyvoEnhkH8SsAR/PBHY8V43+0La6p4f+LWg3miSWOl3fiq1l0WTV5bNJ5rSSJZJkWMsy7WdTPgtuX9zgqcLW7+zRqtrbw+INAtbyG8g029F7ZtAcotvc5kO3/Y+0pdAdgFA9qRFaMZ01NfM4b4vfHvXD+13Z+CdH1ux0rRdL0CPVdckdoFcS3N0YLYDzEIbCRTsyqTnEedueWR/th600+lWsmi2Fvq11ql/Y3di0jSrbrZWb3LzROvEsbJ5GzbyTPk7SrJXqHir4q+EfDHxQsfC9+YT4g1e0a9RHhTL28Tqhdnf72wlWIUkgDcQACatWPxH8DXE0NvBqmgmdQ0cUMUiPIoaNZ2CqPnAaIq54I2kc+syLjKPLGUqLdvXX7jzHxT+2JfeDtN0FW07RZNU1HRrzU7mFbhmjT7LbI7RxOD+8JmngiT1DMRnFZtn+3BqN/NOtv4YYX0F7ZWTW1xLtklNzfSW7BGGQBDDC0jtgru2jPXHsOn+NfA99p1nNBqXh6a3a0lnsmWWEoLeE4lZD/cX5Q5HCkjOKj/4WZ4Fx9uGsaGUjs01H7R5iHFrMsjibceArASnPcK/Gc1SLUqN/wCA/wASX4CfEK++KPgX+0tS09dO1CO5ltbi3VxJHFJG7I2xxkPGSNysDyHAIFdsYGP+HaqPhY2LaSn9mrClnHuSMQoFjGGIOOBxkdh+da2KdzzJJczcVbyIREwH8VLsb8hxUtFHMLlQm3iloopDCjGaKKNwKOp6Lb6xZtb3VvDcQOfmjljDI3bkEelQp4atUtpIxZ2yxTIsckaxKqyqBjDDHIxkYPGOMVqUUXeyBxT3RyEvwf0Gbxnaa82k2f8AaGn2jWlswjG2FWk8xtqY2qxYKdw5yK3tI0W30O3MVnaWtnGxyUhjCLnpngDPFaOKKG29xKKWqRj3PgrTboXCSWNnIl0weZWhX96wO4FuMkhucnkE/Ss9tc8O6rql14a+1aLdahaRK9xpQliaaKNhkFoc5UN2JAFdN/Fn3xX5O/Da7a0/4Og/jM3mSRofC+kpwxCE/wBm2hG7JwQo3Njud1ehl+Bli3Nc3wRcvuaX6nNiasaUU7bux7j8KP8Agtd8MvFv7Tui/Dq7+Hvj3wTZ+JLu403w/wCJdX0dbPT9RurfeWQcl4kwWKMwAIkXIG44+yfFl94b8HaLHf61Joum6dppEgur/wAuCC0+Yc72wqZbGOmSO9fmP8Y/jb8M/wDgo7/wUL+H3h3wfrXhm18D/BvVru+udYkvLezg13XZiiGG2jZla48pA53qMGaaPBKqSPJf+Clni7xF/wAFcf8AgrXZ/spaNq13Z/Dr4f2zXmuRWB8hb+9WJHkaV/4kiMixhcHb++27iwI9T+yVVnTSvT9xynfWyXVWSsrdH955yzBw5ly32tbz+bP1++H/AIu8A/EPSZ4PC+peFdes42HnR6bcQXSKR91mCFhnjgmnfEz9n7w38VNMSDUtPWOSK8iv0nsyLeZZ4/utvUAnHA5z0r4L/Zd/4N+9L/YM/ae8I/En4UeNNcs47C5a31zRZXIttUs5AFbe28szI2XGSF7Yr9LguPzzXl46nRoVF9Urc6tvZqz7ano0KkqiftI2Ob8M/DDSPB+mWtnp+mWccNrZx2Ks6hpGijRYkVnI3NhFxySSBg+1u18CaXaTxzR6Tpq3EaFBItuisobJYA4JAbJyPc1t0Vwc0urOiNOK0SMm28I2Niu23sbOCPcrlI4EVSykFTwOowMHt1GK0bZSsXzDHtUtApSuwUUtUgUYFFFFBRG10qNg56gdM8nP+H4V8L/tR/8ABxl+yh+yP8YNU8C+KvH19deJvD9wbTU4NI0i6v4dPmHDRySomzep4ZVJKkEEA8Vx/wDwc0f8FEtX/YF/4J5XMfhO9k03xr8SNQHh7S72Fys2mxFDJcTp/teWpQehmFfPf/BGn/g3D+AvxB/YP8CfEj4zeG7z4geNviRpkXiWSS/1C4ig06G5QyQRxpE67iI3EhZycu3oAKAPuD4Vf8F3f2VPjV4q8C6H4f8Ai1pd1r3xGeOHQtPaxu47ieV5mgWKRTF+4cyIw2ylSRhhlSCfpr4j/FPQvhZ4UuNa1/UYdL0qzBMtxLn5cZ6DqTx0AzX4KeOP+DfXxp+xz/wXH+FXij4LeAde1D4G6br2jeIp9Qe9jkj8PbJ/9Jtnlkk3uqNEJQSrECVRk7c1+iv7eXx48d678U9S8H+FdR+ww/2fE2mLbqvm6jdpKpnt974UOsbo+zG7anHJAPh8RZwstwntrXlJ2StfX0uvzXqfQcM5FPNscsOmowWsm3ZJetpW9eWXe1kz3jW/+Ck3wx8P6dbTXeoanCt1YnVBE2mzCVbQSeWZSm3cACCcY3bctjFeja5+0T4P8PfBnVPiFda5ap4N0fTZtVvNUUM8UFrDGZHlIUFjhVJCqCx4wDmvgXwx+0je6f478Ox3HiaHXPEWotaaNr2g390k1jpLoI4pdkbFVkd22sCshK72G1skDW+GHiDwz8a49a8A3+q3GszfFCF9C8Y6A19c3EFnp0kU9tMtrdMqLDIPNSTauQdgCE8gfI5Txs69eMa3Lyt26RafRK85czbsnFK6XvXsmfYZ1wJ7HCzq4WnO8FdvmU1a7V7KEHGOjtJ3Tdlb3k1F+xb8dv8Agnj8dP8Agog3jD4N6l4Z1T49eMlvJEubfStRhlnfyGkupEMsSxRyeVHIS2RkbsZzX6M6jrtn4f0q4vL66gs7Wzha4uJp5AkcESqWZ3YnCqACSxOMA1/NT/wS1+AXhv8AZb/4Oy7v4e+D7SbT/C/hPVvEdjptvJK07wwro90QC7HJxu6nPpX1N/wd6/t6+KvBGg/D39nPwLqGoWep/EcHVddWyl8ua+tvNEFrabhg7ZJVkZh0YRqp4Jr9K0drH5fdaWPrb41/8HL/AOxx8KfidqXg3VviRcapJYyG1vLrTNGur6wDn5WUTRpiQAE5KFh796/IT/gsd8FP2c/hz+2x+yj4g/Zns/DUXhHxpdwX13faLfy3kNzOmqW4y4lkcxOhYgxELtPBAr9Jf2Dv+DVr9n/4bfspaJpvxi8Hw+OviVqEH2jWtS/tG5t47SV/m+zwLHIFVYshckHcys3RgB+UP/BVf/glbpf/AASi/wCCqPwc8K+FdZ1bWPAfjHWNP1zRIr+XdNpzf2kIpbdmAAZlCxESYyQy7gTmgD+rd7lcbdwDMdoBPfrj8ufpXxJ+1L/wcO/sm/slfES68J+JviX/AGlr1hIYby30HTrjVI7Jx95JJolMQdepUOWHpXm//B0l+2Rrn7H/APwS91C28L61e6D4k+Imt23hq2vLNtlzFbssk9zsbqMxQmMkEHEnBr4E/wCCSn7H3/BOX4a/sxaP4g+PnxQ+FPjj4m+KLZdS1Oy1PxE0UHh4SKCLJIlkAaRAxDvJzubAxjNAH7ZfsZf8FFvgz+3/AOEJNa+E3jvS/FVvZqpvLVd1vfWO77vnW0gWVMjkErg+teh/Gj45+EP2evhrqnjDxx4i0nwv4Y0OEz32o6lcCCGBe3LdWJ4Cj5mbgAk4r+Yf/goVdfBf/glh+2R4D+OP7Efxo0PVtPm1Bn1XwxpGufbv7OMbbmhcF90lnOm9SrghCOGHyEfaH/B3v4k8UfGD9jH9nfxZ4btdWn+Fuq3MusarPaRloLd57S3azabGAP3b3HlkjAIfOPlyAfaXwz/4Ocv2Nfib8QW8Pw/E+XSXkZlhvdY0a7srG52gn5ZpIwq5x8u/bu6DJr6k/Y//AG7vhR+3j4B1LxP8J/F1r4w0PR75tNvLu3tbiBYLlY45DERNGhLBJUPAIO7jNfjPrnwK/wCCTP7UH7IcPhnwf428G+APGzaOsun67f315puqW96Icg3D3W2KX94pDh8qTkqRxn6G/wCCFHwk1b/gjl/wSJ+MHjj4jap4N8QaNb39342sb7wtrkWsWWp2kem20aiOeP5GZpYigwcDcvOKAPuj9vH/AIKo/A3/AIJvaNp918WvGUOh3GsOyWWn29rNe31wFxucQwqzKgyBvYKpJGCa83/Yx/4L5fsw/t1/FO18E+B/HkkfirUIzJp+navplxpkmogZysLzII5H4PyKxY4OAcGvx8/4IX/8E/1/4L1/tNfFj4+/tJS6r4z0XSbyGzt7Nr2S3hur6XfL5O9GEkdvbxbQIkIDG4UkjBz9Af8ABeX/AIN8fhN+zR+xhrHxq+Aehal4C8UfDWWHVby20/U52iurLzAjyAyOzxTw7/MDq3SNvUAAH7nx3sbAgE7l6jHI7/y5xU1fBf8Awbuf8FC9T/4KK/8ABOfQ9e8UXzX/AI48H3b+GNfuZDl72aBEeK6YYHzyQyx7vVlY+lfelADZOENUbnVJIG27Vb61ek+430rI1L5pjtoAjufFslv/AMsUbnH3qqS/Eb7N/rLVj/uv/wDWqnqPyj/gVYupnK/WgDef4t2sR/eWtwvuGBoT4z6OrbZPtMf/AGzyP51w2ojdG3657VgXZ2Dnb+Df/XoA9gh+Mfhx/lbUlRvRonH/ALLVyD4meH7j7usaeP8AemC/zr53vnj8wHeG9sBqy5tOmvGOy3lIPTbEf/iTQB9VW3ijTbz/AFOoWMv+5Orf1q55q7c5z9Oa+QW8F6xef6nSdSlHqkDjP/fIqNPhp45Mf+h6b4gRl+6U81D+ZagD7CaVUHzMF+vFNe5jVTllXHJyelfHNx4K+OFr/wAg2TxZHt6A3y4P/fb1xfx4+LPx8/Zf+EGv+OfEutR6Xofh+AzyS3txay+Y7MESIKrFmZ3ZUVVBLMwx61UYSk1GGreiXmGnU7b/AIKVf8FbvC/7Cb2/hfR9NTxp8Tb+EXEGhw3Yt49NhIO2e8kCsYo2IAVdhds5VSqsy/lN+0x/wUJ+NH7VviK8k8RfEHWtF0e4BWPw54Xv5NIsljwvyt5TC4m6feeUnlsBQQo8z8ba/ceNPHOveJNRurrUPEHia7a/1K/nfzJbmZsnBc8gR/dROVTccHBIrDv9QXTrWSa6uI7a1Ur5kryFACerFuh6nqDX9LcCcBZfg6ca2ZYdzrNXu78q2astP1PDxWMm5WjscJo/iDwjrn7Rtv4Bvb7StO1C5RN1/f6nLHFHcvuKxm5kb5XKBSCxDFiQM4r76+BUf7XX7CejW+u+DdS8ReLPA7p5rWb3i+MNFcIADzDI09uQOoSWPH8SNtr5t+Hf/BV34B/D34ZW3gXxV8HdA1vxI6appOpalHZw/wBoO05kWOdZmtWBYCc7GydhjyCMgV+m3/BKy0+GOu61Jrf7PnxS1jyZNjeJ/BHiMRyxuDnBjeNEMcqLuAlj8wEhg4HOPm82zenOhiPrOChKEZNL3ZWsnazlCS9m+zakm7LTc0oRbkkm7nff8E2P+Cwdl+2Z43uPAPi7w0vg34hR20l7Zpbzvc6frcKFRIYZGUMkke75oH5ChmBKjdX3Et3Hg8/d4PHrXyH+37/wTtb42aGnj74X/wBneD/jh4Vu01rw/rUMP2f7bNHjNtckZLrKgMTMclg7A8V7V+yL+0T/AMNLfBXT9eutMk8PeI7N20zxLoMj7ptA1WHAubRz32tnaw4ZGRgSrAn8ZzCWElP22Ci4QevK2m4+Sa3S2Tep6lPmvyyPWKjmYCFicYx3qSo7gZhbp0NcJoed+GvhMPCGteIrrSde1SzXxJqa6tcRrHBKIJikSy+UXjO0S+UCw+bBJI25GOVu/wBkrw9M8ulJq+pw6DL4uTxtJpEUyIk96J0usM20HyGvEFwUHO/OCFOwcx8Q9O179qv4heKvCOj+PrnwjofhS4gtr+PR4V/tC5leESnfKx+WPnjaPmwRkV8t/H//AIJafEL4Z3keqeA/EV94sXl3T7UbPUom6gqTIAw6DAGcnpX0mT5LgcVJU8ZjI0ZvZOLa+ctEvU+JzrifMMHF1sHgZV6cXaTjJKXnyx1bt1enofb+rfsu6PrPxNj8XzahqUOpQ6wurMsLRxJdKtvDD9mmG397CDBFMoY5WRBggZBsXf7PtnPq3jO6bWNU8/xhq+nax8qJ/wAS6exW3EPljbllLW8bMHLDLN0BwPgv9nv/AIKM+Pv2YPF//CM/Ey31vUNLRxDKmoLs1GxbONwZgPM291Az6Zr6N8T/ABkk/bXuLrRPCfxE0bRfAscCf2g2nMX8QXQOfMjaKQAwKuDltpJzWmacJ4zLpe0xNvY2v7Raxt6/8N621M8p4+wGYUmqCarrT2T0nfov83bRXPVfjj8M9H+Lvg3/AIRvxJ4xit9utabrUQ220ZR7K5huo4vLkBXy3lg+YEFirkBhxiz8Qv2c9L+KvgrwLplzrF1bWngPX7DX7N7aGJUkksm3QxFWDBUHC4GDgZznr8eeKv8Agmf8OdVvHt9J+IGtR6vICVlv0iuYnOSFJCiNwM4+bdnqMZBrk/AvwS/aU/Zh8ZRR+Exda1YySrbp5Nwl7YSlsN80bFTCcHHKLzXFlMOG82pT/svM4TqQ3g1b8btfdfzaJxvEHEWXVaazPKpRhU2cJqb9WlFWR+o0UqsmcjaeuB3qT7QuP4j9Bn2rH8ItqbeFLFtYWGPVGgU3Qj+6JdvzY9s1j/GmLX5Ph9cf8I6LptWjntpVS3KLJPGlxEZowWIALxbwMkfXNeJytPlbv6H3NOXPFT2v06/M7BrlFJy2Npwc+vH+I/OmnUIlXcWIGM8joPU+g9z0rxHWtc+Ktp4uuG0fSbyXQ751lhNwtr9osmaSUsh/e4KFVjIPVRKowSCBH4u1v4wafZxLp2k293Ok0qMqPDFvSOeJRMSzceZH5koHON20qW+Wr9nfql6lmR/wVh+CviD9pP8A4Jy/F3wV4Rha78Sazob/AGC1Bw15LHIk4t+e8oQpg9d+OK/nM/4J/wD7cmh/8E7NQ8beFfH37Pun+PvEmvXEKK+qzvputaBIowsNuHgleNTIxZWQIScHGAuf6QdG8SfGLzfL1HQm8oWSPHPbraKzTeZCGi8tpMKQhlYEOwYpkMgIQ0JE+IvidpJNU8C6OmqxwySW12v2OeIO1qpjDNI+5VS4EobAOVwFJ5z9jkPE8cvwFXLcTQValUkpNKo4NNW3a1a02ODF4Vzkqkdztv2OfirrXxk/Zu8L+MvEvhFfAOseKbJNUuNDN4buSyEvzRiSQxxlpDF5ZYFMq25SSwNerG6RevGASeOgHr6fjXhtsvxM0HxtcDZdapo9499c2MvnW8ZsJS/lw20wLDzIWVlkRl5BV1b5tgMcniX4uf2T4ZkbRW+3zXrQa3Ci2hht4AW/fwsZAWbGGVSOSWDbQAT8hUipTclaKbbsndLXa/lsd6jyqzPdluo3Hytu5xxzThKCe/5V4bNr/wAXrca5DDo9rdSNDP8A2Q84hjiDAoU+0ASbssu8jaD+83A4UAn0L4TeIPEWv6feSeItGvNGuPtEjwxTPE2ImZtgzG7fMFIz2yOprNq2gHZZyKKan3RTqQBRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAVj+MtHHiLwxqOnOB5eoWstu2RwQ6lf61sVXvI2dkx0zz9KqO5VOTjJSW6Pzk8M6rpngT4AfD3xXdP4g/4Sf4e63ZPrIvd09rDDpkh0u+WMdEEUBmkwwBHmk/xcfoaUXVdO3IyzQzp8hB3CRGA/A5FeA6t4J0n4J/tIeLGvLO3vtC+KGiy3y2H2cFpr61Tbewoo5ZrmDyZNg+8beU4ODmP9mDxvf/AAP8Ux/CTxI+ofZ5IWvvBOo3gJbUtNO4/YpG7XNoMBg2C8exlLfOFOVnsY6SxEVUhutfk23b5O/3nlfh3w9qXwy1Cz8PWMMknjT4A6pc32lWRUB/EvhW7zuSEkYdkixF8pws1qm4rvBr0Lwb8StB/bE/ax0PVvDmrWOt+D/hfpjX8c8EqukmrXyPGoKjkPFaibAJypuQcZxXq37R3gPw34w+Guq6l4gtWV9Csp9QtNStG8q/03y1L+ZbzKd8bfKDxw33WDAlT8y/Bn9iH4reFfhbpr3tp8GPHGua2zazq134s8PvHfLd3O6R1eWEETBGYIpKKQqIMfKM0kb4etQr0JV5vlmk4rzurS/rpck+N/7SmpfsefFzXPBPhPU9I1y18dPv0yAyoY/h7qFzLtea9H/LOxkeRplBwRL5iBdrbl9C/Yt+DOj+FvH2qano91Hq2i+D9FtfAemX4IY3skEklzqNwDzkvdSBGAz89u3TFXPDX7EWteL9MW38da/pEPhuY+ZP4S8G2H9k6RcY/gnm3Ge4j65XMatkhlZTtp/gHxLpv7FnxAtvh7fwrovw98QSvc+ENQdytpYTYMlxpj5P7v8Ailh/gCl4wB5Q3C8i6lSlVw3sMGm6rWq7pWd13lptty31Zof8FD9Re7+Dej+FYFX7Z428R2Glxr5oiAjjc3dw7NyFVLe2lJzhegzyK4/4OQPB+1p4Z0yfw/rPh3WTZ6p4g1K2vNRj1CM/LDCkkUiEgxsbl1HQnysEApipz4s0v9qLVfFXjLXrqTRfhr4d064ttBv5Zhby38aSLJfakoIOLbMMcSsfvIJMcOu7f/YH+HD/APCJ6t8QLy1mtLrxsUOlW9xGsc+m6JDn7DC6jhS6s87gdXnbPekZpqhhHTb11T9Zf5dT6Nt+Qxxj61NVe2RlLFuasVMtz52O1gooopFBRRRQAUyR9q55PTpT6juF3RHHtQKWiPDv269eI+HWjeHg1osfijV4bO6W6cJDJbIryzIzZGAwQKfYmv57P2y/F0nxO/a68fXdk1w0dxrk1hYqZ5LoRwRzC0tvnYEuAoVQSPmHUAAmv6EP217T7D4N8P8AiWSKee18M61G94sD7JjDKjWxKt0Uh5UySCAMkkAE1/Pr+3r8HpvhX+1t8SvDd5YjT76DW7i9SPKvJCs8n2mJg4VS37to/m2gEE8Lzj6ThuvKlUqqEeaXJKy07a76bX3PqOE/D3/XDEVsuhifZThByStfmemiV1fe712RteP/AARrnhz4b6H4e1W8up9A1IxWun3LIsjuq3YjmgjJDbFRkYquCdhU98DzD42fCa2+DOpWctpfR3ml37PHklVkVg6jaxHH8Q5HX5gQCuK3vDp8V/Hf4CQeBNB0G3uLjw/fC4vLn7Vb20ktuN3kxqZmTDBmJJBBIRRnnNeq23hvxl40uPhz4d8fTeFSvhd5bxrixnjlvJ5V8vyYboxL5fmfK5UAkEZycjLfguFzDH0MX9Xxs6cow9q6kIuPNyxi5KfLFenU/Ssrzifh3SxNaEvaShNLlcmnzJWad7pJ/ga3/BI/4o6jo/xP8U6BZ6k1rBdaM2vWkkVv5zrqFnNG8G0gcBtgViOCIyD1Of08/wCC4fiNPF3/AAS9/tiEfu9U1HSbtQOgVyGA/WvlH9mbw/qWo+PNT1OwsZDHYWTaekscbKn9oXZSK2iym3lk8wnPX5FxyWH1Z/wW58NL4L/4JaQ6OhJXSb3SLQEDqEIX+Qr9S8McRUrVMJVrJx5pJpeTtZ/8A/C/FDip8SUMVnDoRoyqQd4RfMr/AM17LVn5D/sg/HWL9mj9pTwl8QLjTn1iHwzcPcfY0k8qSYNC8fDdzlh2r9HY/wDg5e0PaS3wn1rr/wBBqLp/3xX5rfstfAab9p74/wDhrwDb6lHo83ia4eBbyWHzkj2xs5YpkBuVPGRX38f+DabxII8f8LW0f8dFf/47X9BcV08heIg85k1PlXfVXfY/mrhKpxEsNP8AsSCcObXbR2Xdq55B/wAFKP8Agrzpv7e3wS0/wnZeCdS8Ny6frEOp+dNqEdwhCRTIVwqA5y47Y4PPrzn/AAQ+Pnf8FHvB4btaXxz/ANsSf6Va/wCCgf8AwSI1T9gf4MWPi2+8daf4khvtVh0xbWHTjbFS8cjlwxdu6dDxyeaqf8EOht/4KQ+D/wDryvvx/wBHahRy2GQYlZTK9Oz779d/kEv7TfEuHebQ5al1226bfM/Wn9u/xXpvwe8cfBf4ia9eLY+GfCviyS01S5cnybJb+wubSOeQ9AqTPGpYngScjHNdN8b/ANsTw38NfC+itod9pHijxF4o1Kz0vQdKtdRVzqUk86IXDxh8Rxxl5WbptQ55IFeoeOpbG18HalNqlrHqGm29rJPc27xLIJkVCzLtbg8DIBP4jrXy74e/aP8Ahp8JfC1h4zX4N/8ACFf29oU2u6Re22m6ajaoiWxunhSWGQmOXyMtibYGA4JwcfhtGKqct03y366M/o2onGTkutjg/j/e/EP9qr/gpHaWvw3g8I3tl+zvp6T3Q8SS3EdnJrGoRSBQphVjvjtx1IGDPx7aX/BJu71z4AePfif+z74yi02z1rwjqH/CS6Jb2UryWp0nUCWKW7SBXaKGbKZKjGV9Tj6W+D/jL+2LjXrhvAd54R2kXlxK0mnyfb5X6sfssrkyBVHzue+NxxU3hz4h+Gdf+Gdj8Vp9PtdOhudBTUTdzwIt3b2rRGYxs55CdDtBALc8HNbTxTdL6vy+6tPO/r95FOjFT9u3qzwX9lKRf+Hq/wC1EON32fw2duQSAbBecZ+X05Az2rhPi38M/B/xI/4KWfE5fFXxJ8RfD77P4V0IQ/2T4kj0Zr0O95neGz5gUdiOMivpU/tC+GdE/Zu1D4zL4d1K1t5tLOoXlq1kkOqsYfkME2SPnjZShDvgEdQK5P4gfGzwjrOvRQ698H5dU8ZXmqpoa6ddW2l3N2262e4ic3DTGHy2RXHMoIPG3JGbo16vtXKKfwqL17WXX0FOkuTl87nnPxL+GXgv4cfsb/HZPDPxW8SfEC4vPBt2LiHV/FEesPZRxQTBGQKAYw3mYJIweOa2Pgp+2R8Nfgf/AME1/Aupa14s0GSfS/BGnwf2fb3sU17Pc/ZIlW3SFWL+Y0hCgY4yCSBk113hL4weFWe+0vwt8Hbh/Ekl5caRq2h29jpto8aW6QSTPJM0ghkh/wBJtwBvYkvjZkHCfDz4yfCh9RiuD8P9N8LXVlb6nPfTXOkWcD6Tdab5P2m2kZeRII5kdGA2vGMhuBklNuPLNN633X9fcRKOrm3ufHnin4H6/wDDz/gl/wDs1eF9cuNS8K69rvxO0S5dreRI7rSPtt5JKu0sCPNiEyEblzkHOMZrtv8Agol+zLrn7Ofg/wAC/EDVPij42+JWj+HfGWkx3fh7xnJb3GmziacQrMVt4ocSRlwysQejE4OCPpfxT+3R4Hk0SxuNe8L65Ikd5ocvlXdhDK+nNqSPJbzspY+WYVjZnP3oxnritbxx+1D4c8VXM3heHwjqXjLWJtWvdNi0UpaqlyLERvPdb7iRY1hj82H5yQd0igA5Fa08ZXhJPl0u21/wdyVQoyjy82p87fEfUfiP+1X/AMFJdQ1X4a2fg3UdI/Z/sDpEZ8RXNwlm2rXqA3LR+QrbpI4VER3bduW5559J/wCCceoax8KfHvxa+E/iyDw7ZeJ9O1s+MYbXQ5Jn042mqIsrGDzQHKi6W5LZUYMgxnPHq/gz49eF9P12705dBvPC902iP4t1OO4tI7RoD5zwzGUZBMoaNtznKsqhgxUgnW+AHxG8O/tFeFLXx/pui3Wl3V8JbFjqFkINQjWKUqY5GGTtLKrhc4+b1yBz1MRN0nTlG0dNet+n6mlOhH2vtPtHpYmXaf6U8HcKjRcJjjjrinqNq15vQ9DoLRRRQAE4FNJ3Clf7tIvNAH5z/wDByB8n7JXgs8f8jUnT/rzueK+CP+CMur2+k/8ABRrwHeXcyWttHDf75nk2xgmxnA56DJI6n27197/8HIZ/4xI8F/8AY0p/6R3NfjCzAbnYyDaM7kzu6c5I9t3pX7lwXhViOHKmHcrKbkr9tdz+cePsY8NxNHFJXcFF2P6loviR4fkZj/bmj4bgg3sf/wAVXy7/AMFkfGWi6p/wTu+I1tb6tptxdPb2hSKK6RnbF7CflUNuJ69Owr8D7ieEt8uzdyflbd/I8fjUIlUgr1287RIQW546t6he1c+B8M6eHxEK0cRflaei+Z6GZeKVTF4aeFlhrcytds9G/ZenaX9qL4c7tzbfFOmjkFTg3sPqOemSMdq/piu2aKxk9kPbsOlfzM/stBl/af8Ah2WUK3/CU6Z6/wDP7F61/TNqPED8/KoJOT+OK8nxWqNYrDzd3dP87HreEcF9RxSXdf8ApNz5R/ZD8e+Hvh1/wS+0PVvEVzbWej2ej3rXjSsqxlWnuVK/7ROCMA7iT0Ga4v8AZC8Iap4N8Yfss6frFrdWt/D8O9fMkEyndabpdNeJGBx8yowUDHG1s12vw9+PP7Leq6xp32HS/BdhNNdCGzvbjw0La3knEhzsuWh8vfvVjndkkda9N+Mn7Rnw3+DfxL0dvFBZvEcenSy6dJa6JNfXFvbSSBX2yQxN5auYgCMjO0V8JU9rGbhCnP3ubp8vwuffU405RjUlOGnL672v+B4v8HPhR8QPib49+OC+G/iU3g/RX8e31vLaW+hw3dyW8m2Lslwz5jPPHyNj8K6Cy+FOh/sy/tVfAPwvpnmWui2Xh3X9IsZJ2Mkl1ct9muTubPzSOEmlY4G5s4617V+z98RPBvxQ0TUta8HW/k2uoag8t476ZJYPNckLud1kRWLkBcnHYVzs/wAX/hj8fvjZ4m+EOpWtt4g8QeE7aLUNQ0++07zIbdGIKOrMD83IwVPuOaKmYVZ1JS5fds72tonDkv8ALcpZXh4wg+a024pX6tSc7L7jndR1iDXf+Cmejw2k0c0ui/Dy8+3Ij7mtTNqFuY1cA/KWEbHBxwKPhirf8PG/i45Vd3/CIeGUJIHzHz9TKhj7ZOBxwT14xn/Cn9qX4H+APCPxXv8Awvb2Wi2PwpujaeLDZ6QbYxyr5igH5d0xUowzu6967D4m/tA/Dj4G/CGT4z6skNnpeq2FjJLqkNiftlzauQbdGwNxVRO5AJwNx4NKUqq5qcYP3oKC9VKMtvNFXopKvUqJcs5VGv8At2UfzPmn40+DviN8X9S+Pz6H8MbzxNZeMrtNL0rWBr1tZ/YzpaeXBthfDZivkmk+XqwPfivRPgn8fdM+Jnx7+FPibUQkN542+HlzbWwkZcvfwXMLXlqvUby3UZ5MOATWp8Sf+Co3wP8A2aNV03QdS1C802bV9Ng16ztrHR55swXQeVZAsaHBZt5bjqWJ61y//DeX7Mfjb9njUvEk1hp0/grT/ECabLHdeHHjjTULstIGEUkYwzneTIo4POa7HTxUqWtCSi9Iuz2asvvdmeXB4GnWcliIyd7zTat7r5n06K57p8ZviRolzpPirwzHJHN4mXwnqGpskSeZLFa7SgZmAJXe2NqkZby24O3I8A8MWj6ZD+xPqlwsn9hWmkmzlbBEcVxPoYW3LYyBuIdVB65AHJ2n2P4u+N/hD+xP8PYdU1jSdP8AD+heLNRt9Inns9OD/bJZgwUXGBkrtz8xJwSemTnY+L/jr4c/DDTfB/g7xJZ6a+leOL6HQNG0kWAuLaZwgaNBFjakaiPOSDtOMV5dCpyQ9lGMnrLVrdJO9vRM9StT9pP2tScE7K6T681123PPf2v7i18T/tI/APQ9Na1bXrXxXNrkkICs8enxWcyzzEAggFnjXdg/ORkEV5d8MPh/q1j+yP4K+LHhG1a88WfDvVNYme2gYFtb0ptQuDdWhYD5idqyRjgB41HAYkew6L8c/gf8F/2qrX4R6XHpGg/ELWI43aC10zy3ukMRmRJJ1ALfIpwpJwSODxX0J4b8E6b4R0GPS9LsbPT7GMsywW8QjjUuxZiF7FizE/WtpYiWHUIyi7NJq/WLvr8xUsDDFyqT5ouSbT5XfllZXj8rJ3638jyj9gTxHb+KP2WfDN/aM01pfPeXNvIykb4pLyeSJufVGX6HjqDXt9Y/hbwdp/grSrfT9JsrTTtPtwRHbW0SxRRgsWwqqAAMlj9WNbFebWqRnUlKKsru3oe/g6UqVCFOW6SQUUUVmdAUUUUAFRt1qQ9Ko3+rQ6fGrTSQxKxxueQKM5xjJI74H1IqdXLlQFrNFVpdTjimEe1fMbO1c4L4APGcZHIGemaUXfzY2joD7Y/r07VXS4FjP8s0YqP7WuF+6NzYGT19vr7daal2ZJWjA+ZcEjJzg5x/LpU8yAmppj3Pu9sVCbvGMphjjjuM/wCf0NOW93qp+VtxAAVs9f8AOfpUtx6g1cq634ctfEuk3VhqFta3llexmGeC4iEsUyHOVZD8rAg4wR9c1+cf7X3/AAbA/A79oPXptZ8F3mrfCnVLl2e4i0YLJYXBIHBgfhBnJ+U9TX6Tm4yDtTcR2z+FKZvo30NevlGfY3LJ+0wFaUG97Pf1WzJqU4z+I/Hn4ef8GhXgjS9bhk8TfFvxVqumxlt1pp9nFZGQHpl8sa/Qz9i//gmf8H/2BNAaz+GvhCw0u7mDC41KY+ff3G48hpmG7bwPlGB25r3gXXLfL/H61GmqRvOY9y7wMkbgSPw6+g/Gu3NuLs2zSPs8XWlJPdbL52tcmFKMXdImWJlVdwTd3NSVXTU4ZZ5IY5I5JYhl0DqWTuMjPGe2akF4CrFcttJHynPTr/n8OtfOdexo2SZo/wAcVCbv94F27jnDYGfX8unU8UpueflVW52nB+6ff+VPmXcCWjufaoTfxBVbd8rKGBPHB6H9R9MjNOFwCoDKfTIxz3/z9aLvoBJT0+7UQkyPut75HSpV4WmttQFpGGVNLTX+6aYHlv7Ujag/grTI9Lj8y+k1i3MCecIA8q7pI1LkHYGdEXd2zXE+C/FPibwT8ZtSXWNB8S+LNTk0S23TadDaRRRf6RdNtxJLFu42oHHMghJwMDPoH7UmnSXfwV1K6VpFbR57fVS8fEkccE6SyFSe4jV8HBz6VyPwngk0b4lafNb6Hq2i6ZLFfaC39oyiSTUGgkWe3ulbc2YXVrsgnb2wADiqid1GovZNNX3/AKueK/8ABQr9tm++A2jSa/deEfEWkXWl+HtSOkretZhf7RmaCCCU+VO5KqskucAnJwBySPgn4Rfsv658dfhbb6T8Mfh74n1s61H5/jXxfqlvHC185lE32fTzcSIF2GNl80MNzO5O0Nmvvf8A4Lb/ALMGtftGfs12d94Xt5LjXPCt9DdmFX2Ga1bIkGTgDYdjnPQJmvnrwpq/7Tnx71bwh4F+M3iOL4V+H7y4tkexgxpuoeJLcbmnzKrhlRUjcOgkRiSnHzqT5OIlOVd05K6tofpXDlejQyr2+GnCnUXM5ucndKKb9yMU27fFbvZvQ8bv/jx4q/bd+MVp4PsvAOveKPhb8J7QiHwhY6lDZWs0Vs+wS39xyp3ABQAxUrygIyT94fsv/tB2/jT4a/CXxh4b+Hfii202aTVdOtba1WxaL7MxuG+ywuZ4ztiktkQFkXd5bMQMgn4x8efAb44fB/Q9W+Cfgnw+NJ0mSe/S+1fRL43F54nsJZ2lhV0hO+NxGTHztby2ZeQQB9/fsO/DWz8LeDfh74f0WaO+8M/DPRBC95HnytQ1S8RZZGhJPKxJJJkkD/j429VYB4HnTfOY8XVcA8FB4flScrxjFu/LZ3lJLRSk2u7Og/aH+Il94g8L6PDceBfGWnrBrFsq3dz9iKKTuTIEVxJJlgxQYU5MnOOtbH7O5tZ/G94bXRbjQrddDtYIba4n8yR7ZJ7nyWZT8y58xzg9y31Nr9o9rzXPFXhHSbHTptXisJ5Nbv7S3fbLNHCFhiQOWUKfNuVkznOIWOPlxTv2dtP/ALQ8c+LNW+x3WnLBHZ6T9mmvJLowSxo88gR3Y5H+lKDhVwVx2r0os/PJSX1dxSKH7R/7JMP7Ssj2+saukNnHJIbEx2oW60/zLKW0lRZgwYxyeaS6cbsAZ5yF8Pfsf/8ACN/FO68aWeuIniDVLeezu5Ws1aFI2ECxCBMgQ+WluidTuXJOCc1x/wAU01bxh+3Do9vI1/b+GvD2gwRS7beR4L+5v7wp5YdTgPFFb79xyEEhr6eWIcY45B+uOlOUR1pVaNOMOa6av6Hzze/sEyHwvpOm2XiprE6T4cuPCyTR2jZaylto4du3zMBt6GYt1LOfrWppP7GlxpfivxBqx1rR55NciisRbvpDG3hsIoVhS02NMQUChyCACDIevOfeKM0Gf16ta1/wRyvwe+Gg+Enw40vw7Hf3WpR6VF5EdxctulZAxKgnvgELnuFBrqqTd/n1pN/sfeg5JSbd2Ooo3cUUCCiiigAoozzVeC9Eo+6ecHoRxjOecfp0qdQJ93saN3saY10q9m/KmvdbP4T+Z5/HpT1C6Jd3semaA2fWomuNp/h64GWxmmtdfu9yrubIAxk9Tjn0x39KNQJicNj1Oa/J/wCGkbP/AMHQfxjB2MsnhnSU2uu5TnTrMdDjqrYGPU1+rjTAtuw3BI9z+FeEWX7A3gfSf219S+O1nHeW/jTXLWGzv3STMN3HFCsMe5ecYVV6Y5WvVyvGQw7qOa+KDivVtfocOPoyqRio9JJ/gzkz/wAEcP2fT4l/tq1+HegWWpLdG+hube2RJbabdvEkbbSVYNg+lfnN8Dba3/Y0/wCDpXxtb+LLy10jSfiFY3V5o9zdy7IZftdtDMi727+ZBMgDY+YheSa/bxGwNuOPc14L+2z/AME9fhf/AMFAvANvofxG0CDUGsZfPstRjGy/smAx+6mA3op6so4JwfetMtzidOco4mTcZQlBu+ye25GIwiaU6fxLVeZ6J4h/aD8E+EfG2g+G9V8S6PYeIvFUzW+labJdRm5v5FQyOkcYJY4UZJxjBGCa7rd7GviL9kv/AIIW/BT9j/4jWHijQbS4uNe02VZra5uGMskZXHyq8rySIhxyquoPpjivtd73YrMQWVf4QPmP4H8q4MRHDRUVhpufe6sdOHnWlH9/Hlfre5MHz2NOBzUP2obtvzb/APdOPz/z29RSm6+bG1umcmuXU6B5kCmjfUcl0EI+X5iOBxnPpTFvFZXKruVSQSAeMdfrjpx3p6hdFkUVD9qVX27SMcdDj8+nH+PoamByKAPyd/4O6f2TNW/aM/4Jw6f4u0OCa4uPhLrY1m9hjG4/YZYngnfjP+rPkuc4+VWIyQAfav8AggJ+3f4A/aL/AOCYHwk0qx8UaKniXwP4ftfDGtabNdJHdWM9nGIYyyMclXijWRWGVIbqDkD68+KnxR8G+BbNbXxhrug6Taasskaw6pNFGl2oGHUK/DqARkYIIr8p/wBqL/ggP+wj+0X8XNU8Xab8TtQ+HMmtzNc3ek+GNYsotNSQnJMMMkD+QC2W2IQmTwoHFcc8wwsHyyqK/qjqo4HFVo81KlKS/uxbPfvjv/wcDeCfhf8A8FRPAP7OPhfwxdfEaXxPLBZarrGg30ci6LeXLAxqFxtlWKH97KVddiOOrBlGp+3l4I/4Ud8RNW8UXmoTWek+MvKisr6zt99x4cvfs5imnQcHbLFDGnyMGAY4J2AMf8E4/wBjj9jv/gmHoMkfw+8SeF7/AMSXQK3XibWb23utXmUnmNZQi+VH/sRhVPfJyT9EeP8A4+fBH4kaG9jrXjrwndQsu1WXUFSSE8gsjA5U4Prz3zXz3EdHC5lgnRhVhzdOaStfzsfScM1cdlmPVaeGqOPVKLTa8tH+R8E/CjTfEfjDxVoc93p/w5+I1vFf2zjUp7tLe/hjWRfmlRnhkLKoH+sjZiAfXNdZ8A/DN54p/aKht7zxJ4L0HQNDvf7a1C18OIgVre3kM6vfTqGWNOAcySAsN2Afmx7l4K8Cfs6+DfFttqy+OfBupNZuZIVvIbEMrEEA71jViRnqOvfNdf40179m3x58FfFXw/fxF4G0vwz4w0q40bU4dLuorOSW3nieN8OgyH2ufm5r4LJOFacKkPrGIp2pyvpPXySutrn6Pn/GFScKscFhJ3qRSb5JLl3u2rWbtJq9vM/FL9kr4peG9K/4O+/F3ia68QaDZ+HG17xGRqs+owx2TI2lXCowmZghDEgDB5JFd1/weA/CfVPCH7THwI/aB0UR6h4dWyi0j7RE26BLy2uXvoDvHBE0Uh2kZyIiR2z9ER/8G+X/AATmilP/ABVGpfMNox42cEcDPT15z7GvvTVPFn7OHif4EWfw117xJ4C8TeC7LS4NH/szWLmK9int4YxHGH35BYKM7wAwPIIxiv16pmWDUr+1j96/zPxinlOPsl9Xnp/dZsfsP/8ABR/4Y/tw/sweH/iX4d8RabZ2ep2xN9Z3tylvcaTcxgefBKrEEeW38X3SuGzg1+CP/Bwh/wAFA/h7+2d/wV7+C0Pw/wDEVnr3hn4Y3Fhp9/rELhbF7w6mJLgxzMQrxRxrGDKp2blfDFV3H6/+Iv8AwbpfsGeN/iXea1p/xf8AE3hbTb6cTy6Dpuv2f2KMnPyR+dA8ipnopZtnQYGAPUfiL/wRV/4J4/ELwr4X0dbzR9EtfCsD28DaX4leCW937C8tzJkvLKdigMTxzxglTP8AamD/AOfi/wDAolf2Tjv+fE//AABnL/8AB2poui/tMf8ABLKx8XeDdc0bxLb/AA38aWd7qMmlahFeRwwzw3FrljGzbSrywcccMT2NWP8AgjD+zx+wn/wUb/Y78I38Pwh+FNx8Q9B0y00/xZptxZIL2G/jjCyTbScyRSshkEgyGJYHGMV9KfsM/s2/sjf8E9fhb4p8GfD3xZobeG/GVwLrV7PWtaXVI7lxH5WCswI2smAVxg+hr5p/ai/4IQfsCftE+ObjxFo/jp/hXeXjNJNB4Q1q1t7OR2wGIhmilWNcA/LHtXJyAOcn9qYP/n5H/wACQLKce/8AlxP/AMBZD/wUiuf+CZ3/AATP8Q+HtF8X/BHwDruuatdqlxpmgaXHd3OlW38dzcoJFCjOMRk7m4O3Fej/APBY7/grv4V/4Jg/BP4N+H7X4QaL8QPhx8WNIe2Gm6jObOKx0y1iswkLW7QOWVYpwdkm0grt7HDP2Jv+CTv7B37D2srrek614d8ceK4njkh1nxhqEOqTWbr/ABQRbFhjbuG2FgQOcDFeof8ABQP9l/8AZJ/4Kbah4TuPit4003Uf+ELkmfTI7DXhZoBKYjKJAM7w3lKO2FyPcn9qYP8A5+x+9f5h/ZOO/wCfE/8AwFnzP+0h/wAG4/7FP7VXwbf4teBPE9x8KdJ8SWC63Z6to2rwzaDFG8ZdX8icNhCyZMcUkZB3ABeVr5t/4Nw/hZ4g/a//AOCRv7ZXwLi1J7qw1DFvoLtI/kLe3NpMqhd33Ud7W2PQY3ZIJOK9s8ff8G5/7CfjT4hXmqWvxp8WeHdDu7prlfD2neJrT7DaBjlo4TJA8ip6ZZiORnAAH6A/sd6d+y7+wX8I4fBHwu17wR4b0SNxPOEvle4vZyioZppCcySEKuSeOOAM0v7Uwf8Az8j/AOBR/wAyf7Kx/wDz4n/4Cz8qP+DQT9sDw9+zp4p+MP7P/j7ULPwn4mutZTVdMi1SVbZ7q5iU217a5cgecnlRHYOSA5Gdtfan/BzL+334E+Cn/BL7x14Pt/Eeg6h4x+KFuug6VpEV5HJcSRNNG1zcFVYlY44Q53Hjc6Lxu4vf8FGf+Cdn7FP/AAUtubfVPGXijw94b8XWpY/8JH4YvrWx1G7BA+S5YxstwoIGC67gMhSuTny/9jX/AIIjfsK/sifFm38a3XxBX4n6tp4JsofF+qWl3YWkh584QJEgkcdF8wsB1xuAYH9qYP8A5+R+9f5l/wBk47/nxP8A8BZ2v/Bp5+yprH7NX/BLe21vxBbSWt98Udcl8TW8Mmd62jRQ29szAgcssJcAZ+VlPBJA/UAtiuN+GfxY8K/Eq2mHhXW9F1q3sQscn9nXKSiAbfkUhSdoxwAewrsU5rrp1I1I80djgqRlCXLLRg/zKR7VQktmkIbd5ak49+uPpV+VN8bD+8McV+dv/Bb/APaB8deIfHvwV/Zd+FviS88IeLv2hNaeDVdfsJWjvdG0S2AkupIWXlWZN43AqcIVGN4YbQjzOyJPvCWzsLjUPsrahGt4w3mAyJ5gHqVzmm/8IbYzthppWPBwpA4Ocd/Y/XHGa+ZdO/4Iafszx/Br/hD5vhvpd9M9t5UviWd3k8SPLtwbgagxM4l3HduDYz/DXjv/AAWD+AOj/B39gj4DfDSDUPEGt+Grf4s+EfD076xqk95fajaS3bxypPcFvMk3IzL1HHHTiqjFOSihPY+/h4B0jI3W7Nu6Avnd606HwVoUf/MPixk8sM/pnPYjHXg18/6f/wAEhP2Z9G1GG8tvhL4Zt7i2mS5R/Nn/AHbj7rnMpHHpjBr5z/a81e7s/wDg5c/ZPtI7i6jsZvAPiMzxBmWF8W17gsD8pwwGPTA7EZIwu7LsLm01P0Zg0LTYc7NPs1C9T5Stg9x+H9RVqJbeCNdkcaKTgEKBmuG/acl/4xu+IMg3o3/CM6kwwfmj/wBGlO4c9QRkEDtX40/tMeJtStP+Ddf9ie8W/wBQS6ufGvhmOaYTsski+bcgqzcMwOBkE84FFOm5K/mDlrY/c5tRjCMzMYVj6l/lx+o9/wAvTBMel+IrHX4GazuIbpFO0mNg21v7pAOQfUEDGK/OD9ubRvhh8Yf+C2Hw18AfHbUVm8CyfDZ9S8J6Bql+YNC1rXW1KWOcTRMRFNJHbrG6I+c7flzjFfS/hf8A4JZ/BjwB8ePCPxC8C+GY/hvrvhKWXMXhB/7HstcheN4xb39vCAlwieZvwyhg4BJPSiUEkrhc+lHHHr65r8z/APg5N8cXVp8BvhR4ThkaO38TeMRqF2veVLG2luEUjrxMYWOOm0YxxX6YPzmvzZ/4OQ/Ak1/8Avhb4tRC0fhvxn9iuCB/qor6zniBJ95lhX6uO4Gfb4TdNZ3hPbfC6kV97M8Sn7KTjvY/KojCHb8q8DYO5Bb5j7kbSfeqHijSI9e8LalbSNNHHNAymWIbjDgE9cFe3fFXwVZdy5GR0PDZyw6f98n6Gsnx1ff2f4I1m6xva3sJZQBhmbCk4GQeTn0Nf2/WqWw82+0rW06N/ofLx+yNsf8Ag2X/AGn/AIg/DHwx8VPBur+A/FEPiXS7PxLAkmqPaXkPmRLMiuskaxFlyoIEmAU/iwM/r1+z7+wha/Cj9nn4DfF7wzqV9N4/0OLTLnxFfMYy/ieK+kjS8WQRDyyyea2wrwAgzzkn5C8Bf8G5X7Uvws8AeHdX+Df7YHiLQ4Z9LtbtNMur3UdPggcwoxiHkzSR7FY4HyAMOuK/UT/glf8Ab9G/4J5/C3RfFmoWuoeJPDelf2Hq05laRZ7uxnktZW3SAM37yE8kZyK/iPE5xi41JVYVW73TSXR3un3ufTRpQskfRcMB2L/Ev5g/X6da+cfghbv4C/4KSfG/w/GFSx8W6B4e8ZRxrwEuiLvTrhsd9yWVsT1ywJ4NfRK6vaqigTQ88ABxyfSvnX4MaxD8Rv8Agpf8ZNatZI7ix8H+FPD3hMSo25ftTSX2oTRjHdY7i2J9C+Oxr5mMUklZpdFsdGh9NVHPnyW7HFSUyZcxt9Ktq6A+G/2lvgN8V/gt+1DqPxc+GcMmv2evLENV0iAEtMyoIyHQD94oA3KQQQxPFdH4V/bq+KnjNorK3+AfiZNWI5M90bW1BIxnzJE+X1wM8gc175qPxU16x1O4t4/hj44vIo2ZVuorzSBDOo/iUSX6yY+qqfaoV+LuvLJ8vwr8dAHH/L1ovOP+4hivcqZ1Tq0oQxVFVHBKMZbNJaK9t/mfG0eF5UK9SpgMRKnGpLmlC11d6u19r9bHz38Y/wBgLxn+1r4bvta8Ya9o/h/xW5QabZadbGW30xFB3RPMw3ytISuX24XbwDXxj8SP2Svi1+zD4hj1CbRdSj+xtut9V0nfdQp0wQy4bH+y6gHIr9WE+MWvAbf+FV+POmOLvRB/7kOlM/4W54gC8/Czx59Pteif/LDP69q9nKeOsXgabw1WMatKWnJJK1uqT6I8XOvDLLMwqLE0pyp1l9uL1b7s/Or4a/tceItcvrXT9U8B65qWpNiMT6TFIst44PBeIpw/vuA6cZyT+kXwQ03Uh4Nt7nUrCbR7q4Tc1lMyl4sZGG25Gen8TVnw/FjXIfM2/Cnx5Hv+8ftmi8/+VDj9KsQ/GHXo49v/AAqvx568XeiDPP8A2EK/P63D/DtHHTzDKMDHDzqfHyybT+WyPuMohnGHw6wuZYyWIUfh5oxTXzWr/I9CMGFXheP0pPIzt/2Tkc9P89Pxrg/+F069/wBEr8e/+Bmif/LCkPxr14bf+LV+Pvm/6etF/wDlh/Kuw9Q1Pi7Ya1qPw41Wz8Pm3h1i+ha2tJLiby1iZxjzM9cjOQMZzXi/xO/Z78dePvhHpWh/2xaQ6raabqOk3Mq3ZRvLubYQRAOFzvC4kycENwCRzXpk3xV1i9RRN8JvHFwsbh1L3OhsN4/iz9vwGqI/EnVjN5jfCXxsWLhzmfQ/mYAYY/8AEw5YY4PaqjK3QDzm1+B/xKg1vRpoNRt4dPgu9Je6s11ST/R4rSCWGSFTtGfN3xyEHBLADoM1p+Mfgx491DxVp99pt81ra2etXV1eRtrVwo1C2kuC0SFVcBWSM7QM4G6uyT4j6pFJJj4SeN98jiR/9I0PLOMYdv8AiYdflHJ9KH+I2pywTJ/wqHxs4uHWRwZ9EKs2eM/8TDHGBx7VXtHe60+QHN+PfgRq/wATJfC8V8/2NND02a3uZY70Gd5lltJYSCVJ2loTnJBww4zWXD8HfiPf2Nja6hfKsMOn6bYMsWrTbvNtp4ZJ5yeAzTo1xG3Q4WLj5jt7Y/EPUsTKPhD42C3EnmyAT6H878DeR/aGN2AOcZ4605viNqk6yf8AFofGzLcSrPKpm0QiR1K4cj+0PmYbVw3JG0Y6ClGdtkvuA0vg3oOveHoteh1q4W4hn1R7uwRZ3na2hkCnyW3jcMMGPphuCa7hIv3Y+VemOnHvxXm9p8U9atWkaP4T+Nlklx5jLcaJ+9wAoLH+0OcAceg4rpvA3j7UPFr3C3nhTX/DfkBSp1KaxkE2ey/ZribGP9rbUt3dwOoUYFFAORRSAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACo5RuP0qSmHlqBS1VjhPjl8CtL+OHhu3sdQmvrG6027j1PS9RspvKutLu487J4j0yASCrAqysysCCc/Lnxl8T+NdY8X6P4D+Ic1hpd9Z3f2nw/r1nvtLbXpo1kaJo5xu+zXceVaRGBDxo7Ku1/Lr7bYqzZ/iA+7XN/ET4aaH8WvCGo+HvEljDqmj6lHsuIJFPzAcggjlWBAIKkFSARzzVas78HjlQmlPXt/wAD/I+Qfin8Tvi7qXgPT9Emj0fxl4W8SXKXF6kCx2PiabRopVNzi2OIJjNCfl2mJykg/dhs49qtv+ChXw5jTbfS+JtFnBAaHUPDOoQOjnoOYdp/A1zd/wDsZeKvDt+y6F46XxF4d8qSAaR4qtJJriNXUp8l/EyyHapAVpY5tuAcnGK0vG/w2+KHiDxv4YvL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pTvJ5HzNxyPm/wA/rTbIYtlyxb3PU1NQAKMCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKq3sphbd/CoJI+lWqrXyLIGDf3DQFk9z4w1X/gsLCvji60fQ/g78UvEVuLS6u7G7gs4bZb6K2kEEkojldXii8wjDyhQQcjivVf2QP269H/AGtfDPibU20HVfBQ8N60dAnt9dlhSY3KW0dxIuFYqAFlxkE5Az64+Kv2y/2Q/iZfftteNr678BeOfiR8PfHksVzZP4b1mDT4rdGtre1vNOvzNwtrJ9njkJX5sj5c5Obf7P8A+xv8QLDxLa2/jr4T6fD4buvjJc+IRZRMNUhtbK40aez3NE3JtklihUM4ySwkAVQMVBa6n6FickymWBhUpSUZON7812/Llb/RWP0RufG89n8SbOz+2eG08O3mnvcCVr0x3z3HmIq4TBV4ijHDhgd6gdxW63i/TYhGP7S09fOl+zqHuFGX/u4JyW/2c59q/OT9nb9kjxdfWek6fqPw91fT5vC3w51XTtPm1G1Ajg1OPW0vLGGORiflVYlZSCMK+BgKa6P4kfsxJ4S+MV5aeJvhP4u8caD458K2+ljUPDDyQrBqZnluL2K7EbJ5UU8zLJ9obIVRsNPl6nzksnw3Oqaq/cl+rR903nxR8NWZmaTX9FRYZAsjPdxqIiSVAY5+XLKwBPUqR14ryP8Aaw/aA174X/sufErXtN8QeEdF8UaHYX93ockkiXURSFS0aSRsVzJxgqCRkjGea+V/2hP2OrHXPguv/CM/CTWI/HUHjbWtRsGGgJJb6rL9puBFBqBYh2s7m2lwJw21Mbgy1Jo/wf8AiVoE/wAerW1+Bl9qmj/FyxvYNLUSWVu2nzIk8S28od1At5Wc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bWnzlYFZSZWlOFUk4AHOc8V9CxnzIlb5uRnnrSrCFO7au76U+pAKKKKAAjNMaFZPvDP40+igBoXBoaMOeadRQAxYVSPaB8uMY9qeBRRQAVH5Ckk7Vy3J9/SpKKAGiLaf65pWXeMUtFAEP2NMs235iNpYHDH8ev61Jsx+tOooAQrk0jRqx6fjTqKAEC7RwKWiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACmtHu6+4p1Ju9jQBwHxy+N2j/AzRrC+1JLua41i/i0nT7a0h824v7qQNsiUepCsc542mvlv9mD9oTS/hv8AFr9orxJ4jk8UaXpreMNJ0yy0rVJJZZoC9lCVEMLs2xXaR5AFwMJkA9K+jv2nf2b2+P8AB4TuLTXLrw7rngjXofEGlXkcAuI1nSGe3dJIiy745IbmZGXIOG4I5z5e/wCwXrg8UeJvEcvja1k8Qa34lsPFNrJHojLbWc9tZ/Y2haP7RukhkiLfLvUqWyDxWkbbHvZdVwMcPUp19JSSSduvPF9n0W5i/tcfGjSvjT+wra/E7wf4k8VaFZ/abSa1vdLvrnTblFe8jhlV414kG3f94HP3kwSDXA/8FH/2gtPvPAXgFPBPizx9ouqXPjTRdDmk02fVLD7RZ3NwEuEdz5aNmPLeY3zgjOc8V9DftD/AHxd8aP2eIfB9rrmk2+pzXFtdX1/eaa5jPk3CzqsUMcoC/MiryxOOSSRzJ+2J+z14i/aQ+GOleH9N1bStFaz1nTtZu5riwluRK9pdRXSRxqksfytLEAxYn5Sepp+R1ZTjsLSr4f2lnGNSV/JPl8tVozXvP2nfh14EudK0e98TWti95JqFjYtfPKxuZNO3JdJ5z53mPy5NxZiflJzkGvDPHX7ePg/xP8Rfhv4q8KeJ9Zl8N6XfalFr8FqJjDcWq6TLeLK9uikSEbVkV8ZAB6ZNafxZ/wCCbWpfHDQ4dP1rxpb2uni8129khs9GK3BbV4rlZ0EzzMMRtdPsPl52hQcnJPR+G/2O/EkWu/Ddta1jwvqll4Je4a7NtoMli+qrJYGyG9POdN+12Zn6EKFCqGJCsZYWnlVKMZubbtK6t/clbp3t8zN/ak/a71bRfhhq2s/De802S80Hwt/wmFxcalp8ssElox3W0CkmPEk6rKx+Y7PKAK/MCPobwHrjeLPCulanNbiGW+soZpI8lvKZ0Vih64xux1P6c/Kvj7/gmBqGv/B//hCLfxjDfabeW+o6fczaxpb3DQWrqqaakSRSRA/YUDKgY7WMrsQDgV9Q/Bzw3rPhT4daLY69LYXWtWdkkV5PYwvFbyyKAMorMzAcdCaNTixlPBRwsfYO8rvp0uzq0jwSf71SUKMCiszyQooooAKKKKAChhkUUUAJigLilopWQB1o6UUUwCiiigAoxRRQAYoxRRQAYooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAphGTT6KAI6CM9gakooArrbRr0jXjkfKKeUV15VfTkZqWigCLbz0/wA5zSeUCcnrzz3/AM/hU1FAEJjVm3FQWpQiqBtGPwqWigCHy124wvtx0o8iMn/Vp/3yKmooAiK5OcD/ABpcZ9O1SUUAQpCsaBVVQFxgAYxQ8KyLhlVgeuRU1FAEQQBs/wBKWpKKAI6kUYFFFABRRRQAUUUUAFFFFABj2oAxRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABiiiigAooooAMUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAd6aF/wp1FADdpo2U6igBoXFGzNOooAaFpcGlooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAP/9k=" alt="logo" style="position:fixed; bottom:0; padding:0px; width: 100%; left:0px;"/>
