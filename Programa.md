# TalleR

## Presentación

<p align="justify">
El giro digital y su boom de datos forzó diálogos insospechados entre
las ciencias comunicacionales y las ciencias sociales y humanas. Las
nuevas tecnologías y la proliferación de datos masivos en formato
digital trajeron más desorden a los ya desordenados escritorios de
científicxs sociales y humanistas (historiadorxs, sociólogxs,
politólogxs, antropólogxs, filósofxs, etc., etc., etc.), que el contexto
pandémico no hizo más que amplificar con su hipertrofiada virtualidad.
¿Cómo hacer archivo de forma remota? ¿Se puede hacer etnografía en la
virtualidad? ¿Las encuestas online son confiables? ¿Son viables las
entrevistas por telegram o whatsapp? ¿Cómo ir a la hemeroteca sin salir
de casa? ¿Cómo leer cientos de periódicos sin hojearlos?
</p>
<p align="justify">
Las relaciones entre programación y ciencias sociales no son nuevas,
pero sí más visibles y necesarias que hace unos años. No parece ser
conveniente encerrarse en una postura contraria. Estamos cada vez más
cerca de la incorporación de técnicas y métodos computacionales en los
planes de estudios de las carreras universitarias de grado. Ciencias
Sociales Computacionales, Humanidades Digitales, Historia Digital,
lectura distante, métodos cualitativos digitales, son nombres cada vez
más escuchados en nuestros ámbitos de trabajo. Y lo serán aún más en
poco tiempo.
</p>
<p align="justify">
Dentro de la maraña de epistemologías, problemáticas, metodologías,
técnicas, enfoques y lenguajes de programación disponibles para
adentrarse en el mundo de las ciencias sociales computacionales y las
humanidades digitales, elegimos el camino utilitarista de les
autodidactas de tutoriales de youtube. A partir de un set pequeño de
problemas concretos a resolver (cómo bajar de internet grandes
cantidades de texto, de qué modo darle formato tabular, cómo limpiarlos,
procesarlos, explorarlos y visualizarlos sin hacer una lectura cercana
de lo recolectado, y no morir en el intento) nos relacionaremos con el
lenguaje de programación R (no con Julia, Python, Java, C, C++, etc.,
etc., que son buenos pero no tanto, 😉) para desarrollar ejercicios de
web scraping, minería de texto y lectura distante.
</p>
<p align="justify">
Este taller se mete en todo esto con el horizonte de que quienes lo
cursen puedan realizar análisis y mediciones de la conflictividad
social, hechos de rebelión, eventos de protesta, o como quieran
llamarlos. En este sentido, y esta vez va en serio, los lenguajes de
programación como R, Python, Julia y otros nos brindan herramientas muy
potentes tanto para desarrollar los tradicionales análisis estadísticos
como para utilizar y desarrollar algoritmos útiles para procesar y
analizar un gran volumen de información no estructurada como son las
notas periodísticas publicadas diariamente por los portales noticiosos
como <em>La Nación</em>, <em>La Capital</em>, <em>Los Andes</em>, por
nombrar solo algunos.
</p>

## Objetivos

<ol>
<li>
Conocer los aspectos básicos de la programación en R (como humanistas 🤓
no como programadorxs 👽, o sea, más o menos…).
</li>
<li>
Dar los primeros pasos en el manejo del IDE RStudio (entorno de
desarrollo integrado para R, fuera esa horrible ventana ⬛ de R base).
</li>
<li>
Aprender los rudimentos elementales del manejo de cadena de caracteres 🔠
y corpus de textos 📃📑📜.
</li>
<li text-align="justify">
Saber transformar las palabras 🔤 en números 🔢 para realizar mediciones
de frecuencias, proporciones y relaciones (veremos que las palabras y
los números no se llevan tan mal y que la frontera entre lo cuali y lo
cuanti no es tan nítida como creíamos.
</li>
<li align="justify">
Lograr familiarizarse con algunos de los paquetes de visualización 📊 📈
más populares en R. ‘Si no lo veo no lo creo’: las visualizaciones son
una forma muy conveniente de detectar patrones y correlaciones (ni
palabras ni números, garabatos).
</li>
</ol>

## Contenidos

<ol>
<li>
Instalación del lenguaje R y exploración de su sintaxis básica.
Introducción a la sintaxis básica. Distintos objetos R: vectores,
arrays, matrices, listas, base de datos, etc. Distintos tipos de
objetos: cadena de caracteres, numéricos, factores, etc. Funciones
básicas, sum(), paste(), mean(), table(), summary(), etc.
</li>
<li>
Instalación de RStudio y reconocimiento de sus ventanas (consola,
script, visualización, objetos en memoria, etc.). Creación de scripts.
Organización del directorio de trabajo. Creación de proyectos.
Vinculación con github.
</li>
<li>
Web Scraping con rvest y RSelenium. Inspección de estructuras html.
Recuperación de información publicada en la web, tanto en páginas
estáticas como en páginas dinámicas. Transformación de la información
semi-estructurada en datos estructurados.
</li>
<li>
Tránsito de información semiestructurada a datos estructurados. 
Normalización y limpieza de datos. 
Visualización de datos con el paquete ggplot2. 
Interacción entre paquetes para la georreferenciación: ggplot2 + sf.
</li>
</ol>

## Encuentros

### Los días jueves de 10 a 14 horas

#### La primera y la última media hora serán destinadas para que les cursantes realicen consultas y despejen dudas.

### Primer encuentro [jueves 22 de julio](https://github.com/agusnieto77/TalleR/blob/main/encuentros/Primer_encuentro.md)

<p align="justify">
De palabras a números y viceversa. Alcance y límites de la minería de
textos para la medición de la conflictividad social: experiencias de
investigación en el marco del Observatorio de Conflictividad Social de
la UNMdP. Constatar que a todxs lxs participantes les funcionen R y
RStudio.
</p>

### Segundo encuentro [jueves 29 de julio](https://github.com/agusnieto77/TalleR/blob/main/encuentros/Segundo_encuentro.md)

<p align="justify"; text-color="red">Dudas y consultas sobre lo visto en el primer encuentro. Web Scraping con rvest y RSelenium. HTML, CSS y coso: las etiquetas para la recuperación de la información que necesitamos.  Prácticas de codeo en vivo (sincrónicas). Dudas y consultas de lo ejercitado durante el encuentro.</p>

### Tercer encuentro [jueves 5 de agosto](https://github.com/agusnieto77/TalleR/blob/main/encuentros/Tercer_encuentro.md)

<p align="justify">
Dudas y consultas sobre lo visto en el segundo encuentro. Limpieza y
normalización del corpus que logramos scrapear. Palabras vacías
(stopwords), lemas, raíces, entidades, etiquetas POS (Parts Of Speech),
etc. Tokenizado de textos. Primeras mediciones: palabras más frecuentes
y relaciones más fuertes. Uso de diccionarios para la detección de
eventos (de protesta) y otras entidades (provincias, barrios,
organizaciones, etc.). Prácticas de codeo en vivo (sincrónicas). Dudas y
consultas de lo ejercitado durante el encuentro.
</p>

### Cuarto encuentro [jueves 12 de agosto](https://github.com/agusnieto77/TalleR/blob/main/encuentros/Cuarto_encuentro.md)

<p align="justify">
Dudas y consultas sobre lo visto en el tercer encuentro. Análisis
profundo del corpus: filtros y sub-corpus (sobre notas referidas a
eventos de protesta). Ajuste de las palabras vacías con un diccionario
personalizado. Eliminación de notas repetidas. Elaboración de resúmenes
con palabras clave, etc. Análisis exploratorio de los datos normalizados
con paquetes de visualización: ggplot2 y sf. Armado de índices de
conflictividad. Prácticas de codeo en vivo (sincrónicas). Dudas y
consultas de lo ejercitado durante el encuentro.
</p>

### Paquetes a usar

-   tidyverse
-   tidytext
-   quanteda
-   spacyr
-   udpipe

### [Bibliografía recomendada](https://github.com/agusnieto77/TalleR/blob/main/Bibliografia.md)
