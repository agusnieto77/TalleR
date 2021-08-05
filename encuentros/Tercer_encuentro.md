# De palabras a números y viceversa

## Una introducción a la minería de corpus textuales

Este encuentro está enfocado en ejercicios de minería de textos como la
limpieza y normalización de los corpus textuales que logramos scrapear.
¿De qué se tratan estos ejercicios? El proceso de limpieza y
normalización de los corpus textuales implica remover palabras vacías
(stopwords); simplificar las variaciones de las palabras a sus lemas, un
ejemplo es la reducción de todas las conjugaciones de un verbo a su
infinitivo; identificar entidades, etiquetar palabras (POS - Parts Of
Speech); etc. Una acción que se desarrolla tanto en el proceso de
limpieza y normalización como posteriormente es el tokenizado de textos,
separar el texto en palabras. Finalmente, con el corpus limpio y
normalizado realizamos un análisis estadístico descriptivo para
identificar las palabras más frecuentes y las relaciones más fuertes
entre pares de palabras. En esta etapa también haremos uso de
diccionarios para la detección de eventos (de protesta) y otras
entidades (provincias, barrios, organizaciones, etc.).

### ¿Qué hacer con la información que raspamos de la web?

Como ya dijimos, las tareas limpieza y normalización del corpus textual
es lo primero y más extenso de todo el proceso. Aquí, para que sea más
claro y menos prolongado, vamos a usar un corpus pequeño, con no más de
una decena de notas.

Una primera acción es la eliminación de duplicados y valores perdidos.
Los NA´s, si se repiten en cada una de las variables, son tratados como
valores duplicados y se los elimina. Para realizar esta tarea se pueden
usar varias funciones. Una es la función `unique()` que R trae de base.
Otra, la que vamos a usar aquí, es la función `distinct()` del paquete
dplyr de tidyverse.

Veamos un ejemplo aún más acotado:

    # bajar el script completo
    utils::download.file("https://estudiosmaritimossociales.org/ejercicio04.R", "ejercicio04.R")
    # cargar paquetes
    require(tidyverse)
    # creamos una base
    (Tabla <- tibble(fecha=c('02/02/2021','09/04/2021','02/07/2021','02/07/2021','02/07/2021',NA,NA), 
                     titulo=c('El clima            en Mar del            Plata https://www.lacapitalmdp.com/',
                              'Los    trabajadores        estatales estan            en huelga @lacapitalmdq',
                              '@lacapitalmdq El sindicato docente__ declaro un paro por tiempo indeterminado', 
                              '@lacapitalmdq El sindicato docente__ declaro un paro por tiempo indeterminado', 
                              'El clima            en Mar del            Plata https://www.lacapitalmdp.com/',
                              NA, NA)))

    ## # A tibble: 7 x 2
    ##   fecha      titulo                                                             
    ##   <chr>      <chr>                                                              
    ## 1 02/02/2021 El clima            en Mar del            Plata https://www.lacapi~
    ## 2 09/04/2021 Los    trabajadores        estatales estan            en huelga @l~
    ## 3 02/07/2021 @lacapitalmdq El sindicato docente__ declaro un paro por tiempo in~
    ## 4 02/07/2021 @lacapitalmdq El sindicato docente__ declaro un paro por tiempo in~
    ## 5 02/07/2021 El clima            en Mar del            Plata https://www.lacapi~
    ## 6 <NA>       <NA>                                                               
    ## 7 <NA>       <NA>

    # eliminamos los valores perdidos 
    (Tabla <- Tabla %>% filter(!is.na(titulo)))

    ## # A tibble: 5 x 2
    ##   fecha      titulo                                                             
    ##   <chr>      <chr>                                                              
    ## 1 02/02/2021 El clima            en Mar del            Plata https://www.lacapi~
    ## 2 09/04/2021 Los    trabajadores        estatales estan            en huelga @l~
    ## 3 02/07/2021 @lacapitalmdq El sindicato docente__ declaro un paro por tiempo in~
    ## 4 02/07/2021 @lacapitalmdq El sindicato docente__ declaro un paro por tiempo in~
    ## 5 02/07/2021 El clima            en Mar del            Plata https://www.lacapi~

    # eliminamos los duplicados 
    (Tabla <- Tabla %>% unique())

    ## # A tibble: 4 x 2
    ##   fecha      titulo                                                             
    ##   <chr>      <chr>                                                              
    ## 1 02/02/2021 El clima            en Mar del            Plata https://www.lacapi~
    ## 2 09/04/2021 Los    trabajadores        estatales estan            en huelga @l~
    ## 3 02/07/2021 @lacapitalmdq El sindicato docente__ declaro un paro por tiempo in~
    ## 4 02/07/2021 El clima            en Mar del            Plata https://www.lacapi~

    # eliminamos el contenido redundante 
    (Tabla <- Tabla %>% distinct(titulo, .keep_all = T))

    ## # A tibble: 3 x 2
    ##   fecha      titulo                                                             
    ##   <chr>      <chr>                                                              
    ## 1 02/02/2021 El clima            en Mar del            Plata https://www.lacapi~
    ## 2 09/04/2021 Los    trabajadores        estatales estan            en huelga @l~
    ## 3 02/07/2021 @lacapitalmdq El sindicato docente__ declaro un paro por tiempo in~

    # incorporamos un id
    (Tabla <- Tabla %>% mutate(id = row_number(), .before = fecha))

    ## # A tibble: 3 x 3
    ##      id fecha      titulo                                                       
    ##   <int> <chr>      <chr>                                                        
    ## 1     1 02/02/2021 El clima            en Mar del            Plata https://www.~
    ## 2     2 09/04/2021 Los    trabajadores        estatales estan            en hue~
    ## 3     3 02/07/2021 @lacapitalmdq El sindicato docente__ declaro un paro por tie~

    # guardamos la tabla
    saveRDS(Tabla,'./Tabla.rds')

La segunda acción que vamos a realizar es la normalización del contenido
el texto y otras variables, fecha por ejemplo. La fecha está en formato
caracter y la vamos a pasar a formato fecha. Veamos…

    require(tidyverse)
    require(lubridate)
    # cargamos la base
    Tabla <- readRDS('./Tabla.rds')
    # imprimimos en pantalla los títulos
    Tabla$titulo

    ## [1] "El clima            en Mar del            Plata https://www.lacapitalmdp.com/"
    ## [2] "Los    trabajadores        estatales estan            en huelga @lacapitalmdq"
    ## [3] "@lacapitalmdq El sindicato docente__ declaro un paro por tiempo indeterminado"

    # normalizamos el contenido de los textos
    (Tabla$titulo_limpio <- gsub('?(f|ht)tp\\S+', '', Tabla$titulo))    # eliminamos urls

    ## [1] "El clima            en Mar del            Plata "                             
    ## [2] "Los    trabajadores        estatales estan            en huelga @lacapitalmdq"
    ## [3] "@lacapitalmdq El sindicato docente__ declaro un paro por tiempo indeterminado"

    (Tabla$titulo_limpio <- gsub('@\\S*\\s?', '', Tabla$titulo_limpio)) # eliminamos @names y @mails

    ## [1] "El clima            en Mar del            Plata "                
    ## [2] "Los    trabajadores        estatales estan            en huelga "
    ## [3] "El sindicato docente__ declaro un paro por tiempo indeterminado"

    (Tabla$titulo_limpio <- gsub('__', '', Tabla$titulo_limpio))        # eliminamos un contenido particular 

    ## [1] "El clima            en Mar del            Plata "                
    ## [2] "Los    trabajadores        estatales estan            en huelga "
    ## [3] "El sindicato docente declaro un paro por tiempo indeterminado"

    (Tabla$titulo_limpio <- gsub(' +', ' ', Tabla$titulo_limpio))       # borramos los espacios en blanco repetidos

    ## [1] "El clima en Mar del Plata "                                   
    ## [2] "Los trabajadores estatales estan en huelga "                  
    ## [3] "El sindicato docente declaro un paro por tiempo indeterminado"

    (Tabla$titulo_limpio <- gsub(' +$', '', Tabla$titulo_limpio))       # borramos los espacios en blanco finales

    ## [1] "El clima en Mar del Plata"                                    
    ## [2] "Los trabajadores estatales estan en huelga"                   
    ## [3] "El sindicato docente declaro un paro por tiempo indeterminado"

    # imprimimos en pantalla los títulos limpios
    Tabla$titulo_limpio

    ## [1] "El clima en Mar del Plata"                                    
    ## [2] "Los trabajadores estatales estan en huelga"                   
    ## [3] "El sindicato docente declaro un paro por tiempo indeterminado"

    # transformamos la fecha en fecha
    (Tabla <- Tabla %>% mutate(fecha = dmy(fecha)))

    ## # A tibble: 3 x 4
    ##      id fecha      titulo                          titulo_limpio                
    ##   <int> <date>     <chr>                           <chr>                        
    ## 1     1 2021-02-02 El clima            en Mar del~ El clima en Mar del Plata    
    ## 2     2 2021-04-09 Los    trabajadores        est~ Los trabajadores estatales e~
    ## 3     3 2021-07-02 @lacapitalmdq El sindicato doc~ El sindicato docente declaro~

    # guardamos la tabla
    saveRDS(Tabla,'./Tabla.rds')

La tercera acción que vamos a realizar es la tokenización, también como
parte de la normalización del contenido el texto. Tokenizar es separar
el texto en sus palabras constitutivas, a las cuales se las llama
tokens. Aquí la tokenización la vamos a realizar con el paquete
tidytext.

    require(tidyverse)
    require(tidytext)
    # cargamos la base
    Tabla <- readRDS('./Tabla.rds')
    # tokenizamos
    (Tabla <- Tabla %>% tidytext::unnest_tokens(palabras,titulo_limpio, drop = FALSE) %>% select(id,palabras))

    ## # A tibble: 21 x 2
    ##       id palabras    
    ##    <int> <chr>       
    ##  1     1 el          
    ##  2     1 clima       
    ##  3     1 en          
    ##  4     1 mar         
    ##  5     1 del         
    ##  6     1 plata       
    ##  7     2 los         
    ##  8     2 trabajadores
    ##  9     2 estatales   
    ## 10     2 estan       
    ## # ... with 11 more rows

    # borramos las palabras vacías
    (Tabla <- Tabla %>% anti_join(tibble(palabras = c('en','el','un','por','del','los','mar','plata'))))

    ## # A tibble: 11 x 2
    ##       id palabras     
    ##    <int> <chr>        
    ##  1     1 clima        
    ##  2     2 trabajadores 
    ##  3     2 estatales    
    ##  4     2 estan        
    ##  5     2 huelga       
    ##  6     3 sindicato    
    ##  7     3 docente      
    ##  8     3 declaro      
    ##  9     3 paro         
    ## 10     3 tiempo       
    ## 11     3 indeterminado

    # guardamos la tabla
    saveRDS(Tabla,'./Tabla_tokens.rds')

La cuarta acción que vamos a realizar es la lemmatización, también como
parte de la normalización del contenido el texto. Lemmatizar es separar
el texto en sus palabras constitutivas y reducirlas la forma que por
convenio se acepta como representante de todas las formas flexionadas de
una misma palabra. Ejemplo: perra | perro | perras | perros = perro.

    require(tidyverse)
    require(udpipe)
    # bajamos el modelo para español 
    es_model <- udpipe_download_model(language = "spanish")
    # lo activamos 
    es_model <- udpipe_load_model(es_model$file_model)
    # cargamos la base
    Tabla <- readRDS('./Tabla.rds')
    # lematizamos
    (Tabla_lemas <- udpipe_annotate(es_model, x = Tabla$titulo_limpio))

    ## $x
    ## [1] "El clima en Mar del Plata"                                    
    ## [2] "Los trabajadores estatales estan en huelga"                   
    ## [3] "El sindicato docente declaro un paro por tiempo indeterminado"
    ## 
    ## $conllu
    ## [1] "# newdoc id = doc1\n# newpar\n# sent_id = 1\n# text = El clima en Mar del Plata\n1\tEl\tel\tDET\t_\tDefinite=Def|Gender=Masc|Number=Sing|PronType=Art\t2\tdet\t_\t_\n2\tclima\tclima\tNOUN\t_\tGender=Masc|Number=Sing\t0\troot\t_\t_\n3\ten\ten\tADP\t_\t_\t4\tcase\t_\t_\n4\tMar\tmar\tPROPN\t_\t_\t2\tnmod\t_\t_\n5-6\tdel\t_\t_\t_\t_\t_\t_\t_\t_\n5\tde\tde\tADP\t_\t_\t7\tcase\t_\t_\n6\tel\tel\tDET\t_\tDefinite=Def|Gender=Masc|Number=Sing|PronType=Art\t7\tdet\t_\t_\n7\tPlata\tplata\tPROPN\t_\t_\t4\tnmod\t_\tSpacesAfter=\\n\n\n# newdoc id = doc2\n# newpar\n# sent_id = 1\n# text = Los trabajadores estatales estan en huelga\n1\tLos\tel\tDET\t_\tDefinite=Def|Gender=Masc|Number=Plur|PronType=Art\t2\tdet\t_\t_\n2\ttrabajadores\ttrabajador\tNOUN\t_\tGender=Masc|Number=Plur\t4\tnsubj\t_\t_\n3\testatales\testatal\tADJ\t_\tNumber=Plur\t2\tamod\t_\t_\n4\testan\testar\tVERB\t_\tMood=Ind|Number=Plur|Person=3|Tense=Pres|VerbForm=Fin\t0\troot\t_\t_\n5\ten\ten\tADP\t_\t_\t6\tcase\t_\t_\n6\thuelga\thuelga\tNOUN\t_\tGender=Fem|Number=Sing\t4\tobl\t_\tSpacesAfter=\\n\n\n# newdoc id = doc3\n# newpar\n# sent_id = 1\n# text = El sindicato docente declaro un paro por tiempo indeterminado\n1\tEl\tel\tDET\t_\tDefinite=Def|Gender=Masc|Number=Sing|PronType=Art\t2\tdet\t_\t_\n2\tsindicato\tsindicato\tNOUN\t_\tGender=Masc|Number=Sing\t4\tnsubj\t_\t_\n3\tdocente\tdocente\tADJ\t_\tNumber=Sing\t2\tamod\t_\t_\n4\tdeclaro\tdeclaro\tVERB\t_\tMood=Ind|Number=Sing|Person=1|Tense=Pres|VerbForm=Fin\t0\troot\t_\t_\n5\tun\tuno\tDET\t_\tDefinite=Ind|Gender=Masc|Number=Sing|PronType=Art\t6\tdet\t_\t_\n6\tparo\tparo\tNOUN\t_\tGender=Masc|Number=Sing\t4\tobj\t_\t_\n7\tpor\tpor\tADP\t_\t_\t8\tcase\t_\t_\n8\ttiempo\ttiempo\tNOUN\t_\tGender=Masc|Number=Sing\t6\tnmod\t_\t_\n9\tindeterminado\tindeterminado\tADJ\t_\tGender=Masc|Number=Sing|VerbForm=Part\t6\tamod\t_\tSpacesAfter=\\n\n\n"
    ## 
    ## $errors
    ## [1] "" "" ""
    ## 
    ## attr(,"class")
    ## [1] "udpipe_connlu"

    # lo pasamos a formato data frame
    (Tabla_lemas <- as.data.frame(Tabla_lemas) %>% select(doc_id,token,lemma,upos,feats) %>% 
      anti_join(tibble(token = c('en','el','El','un','por','del','Los','de','Mar','Plata'))))

    ##    doc_id         token         lemma upos
    ## 1    doc1         clima         clima NOUN
    ## 2    doc2  trabajadores    trabajador NOUN
    ## 3    doc2     estatales       estatal  ADJ
    ## 4    doc2         estan         estar VERB
    ## 5    doc2        huelga        huelga NOUN
    ## 6    doc3     sindicato     sindicato NOUN
    ## 7    doc3       docente       docente  ADJ
    ## 8    doc3       declaro       declaro VERB
    ## 9    doc3          paro          paro NOUN
    ## 10   doc3        tiempo        tiempo NOUN
    ## 11   doc3 indeterminado indeterminado  ADJ
    ##                                                    feats
    ## 1                                Gender=Masc|Number=Sing
    ## 2                                Gender=Masc|Number=Plur
    ## 3                                            Number=Plur
    ## 4  Mood=Ind|Number=Plur|Person=3|Tense=Pres|VerbForm=Fin
    ## 5                                 Gender=Fem|Number=Sing
    ## 6                                Gender=Masc|Number=Sing
    ## 7                                            Number=Sing
    ## 8  Mood=Ind|Number=Sing|Person=1|Tense=Pres|VerbForm=Fin
    ## 9                                Gender=Masc|Number=Sing
    ## 10                               Gender=Masc|Number=Sing
    ## 11                 Gender=Masc|Number=Sing|VerbForm=Part

    # guardamos la tabla
    saveRDS(Tabla_lemas,'./Tabla_lemas.rds')

Ya con el corpus textual procesado y normalizado podemos decidir qué
enfoque vamos a elegir para hacer un análisis de la conflictividad. El
primer paso es diferenciar entre notas que refieren a conflictos y notas
que no. Si tomamos al última tabla podemos (intuitivamente) sobre los
lemmas que refieren y no refieren a notas sobre conflictos. Veamos.

    require(tidyverse)
    # cargamos la base
    Tabla_lemas <- readRDS('./Tabla_lemas.rds')
    # armamos un diccionario sobre conflictos
    (dicc_conf <- Tabla_lemas %>% filter(doc_id != 'doc1') %>% .[,3])

    ##  [1] "trabajador"    "estatal"       "estar"         "huelga"       
    ##  [5] "sindicato"     "docente"       "declaro"       "paro"         
    ##  [9] "tiempo"        "indeterminado"

    # rearmamos los títulos con los lemmas
    (Tabla_notas <- Tabla_lemas %>% group_by(doc_id) %>% summarise(titulo = paste0(lemma, collapse = ' ')))

    ## # A tibble: 3 x 2
    ##   doc_id titulo                                             
    ##   <chr>  <chr>                                              
    ## 1 doc1   clima                                              
    ## 2 doc2   trabajador estatal estar huelga                    
    ## 3 doc3   sindicato docente declaro paro tiempo indeterminado

    # vemos si contiene referencias a conflictos o no
    Tabla_notas %>% mutate(p_conf = str_count(titulo, paste0(dicc_conf, collapse = '|')))

    ## # A tibble: 3 x 3
    ##   doc_id titulo                                              p_conf
    ##   <chr>  <chr>                                                <int>
    ## 1 doc1   clima                                                    0
    ## 2 doc2   trabajador estatal estar huelga                          4
    ## 3 doc3   sindicato docente declaro paro tiempo indeterminado      6

    # guardamos la tabla
    saveRDS(Tabla_notas,'./Tabla_notas.rds')

Hasta aquí una breve introducción. En en encuentro del jueves 05/08
veremos todo esto con más profundidad.

## Documentación sobre `tidytext`

-   [Package `tidytext`. Manual en
    pdf.](https://cran.r-project.org/web/packages/tidytext/tidytext.pdf)

-   [Package `tidytext`. Su repositorio en
    GitHub.](https://github.com/juliasilge/tidytext)

-   [Package `tidytext`. Una
    introducción.](https://cran.r-project.org/web/packages/tidytext/vignettes/tidytext.html)

## Documentación sobre `udpipe`

-   [Package `udpipe`. Manual en
    pdf.](https://cran.r-project.org/web/packages/udpipe/udpipe.pdf)

-   [Package `udpipe`. Su repositorio en
    GitHub.](https://github.com/bnosac/udpipe)

-   [Package `udpipe`. Su
    web.](https://bnosac.github.io/udpipe/en/index.html)

## Bibliografía

-   [Algo reciente sobre análisis de texto con R](https://smltar.com/)
