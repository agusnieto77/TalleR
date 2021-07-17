



















## ¡Bienvenidxs!

Este tutorial está orientado a la instalación de
[R](https://es.wikipedia.org/wiki/R_(lenguaje_de_programación)), y de su
IDE (Entorno de Desarrollo Integrado)
[RStudio](https://es.wikipedia.org/wiki/RStudio), en ordenadores que
tienen Windows como sistema operativo.

Empecemos por el principio. R Project es un entorno y lenguaje de
programación que es útil para extraer, procesar, analizar y visualizar
datos. Y algo muy importante, está bajo [licencia GNU
GPL](https://es.wikipedia.org/wiki/GNU_General_Public_License), esto
quiere decir que es de libre acceso y de código abierto.

Este tutorial lo ayudará a:

-   Instalar R
-   Instalar RStudio
-   Instalar [`tidyverse`](https://www.tidyverse.org/)

Y, sobre todo, les va a ayudar a tener todo listo para el talleR, cuyo
primer encuentro es el **jueves 22 de julio**.

Puede omitir este tutorial si ya tiene instalado R, RStudio y el paquete
`tidyverse` en su computadora personal.

## Instalar R

### ¿Cuáles son los pasos para instalar R?

-   Ir a la web oficial de R Project
-   Descargar el ejecutable de R
-   Instalar R en nuestro ordenador
-   Iniciar el programa para probar que funciona

#### 

#### Descargar e instalar R

#### 

**Primero**, buscar la página oficial de R Project para acceder al link
de descarga o ***googlear*** “download R”. Googleemos…

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/googlear_download_r.png)

#### 

Sí, tienen razón, el número de versión de la imagen no coincide con el
número de versión que aparece en estas líneas. Esto es así porque las
capturas son de diciembre de 2020 y en 2021 R y RStudio cambiaron de
versión. ATENTI: esto va a ocurrir con todas las capturas de pantalla.

#### 

**Segundo**, accedemos a la página
[cran.r-project.org/bin/windows/base/](https://cran.r-project.org/bin/windows/base/)

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/download_r_4.png)

#### 

…y luego hacemos clic sobre ‘R-4.1.0 for Windows (32/64 bit)’ para bajar
el archivo .exe de R.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/exe_r.png)

#### 

**Tercero**, ejecutamos el archivo ‘R-4.1.0-win.exe’ que bajamos desde
la página oficial de R. Es probable que el archivo se haya descargado en
la carpeta Downloads (Descargas) del disco `C:\` de nuestro ordenador.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/exe_r_b.png)

#### 

Una vez que localizamos en donde se descargó el `archivo` de R, hacemos
doble clic sobre ‘R-4.1.0-win.exe’ o nos posamos sobre el archivo con
nuestro puntero, luego presionamos el botón derecho del ratón,
seleccionamos de la lista la opción `Ejecutar como administrador` y
finalmente lo ejecutamos como ***administrador*** haciendo un solo clic.
Esta última es la opción que recomendamos.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/exe_r_admin.png)

#### 

Una vez que ejecutamos el archivo ‘R-4.1.0-win.exe’ como administrador
se abre la ventana de `Control de cuentas de usuario` de Windows. Nos
pregunta si queremos permitir que R haga cambios, respondemos haciendo
clic en `Sí`.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/INSTALL.png)

#### 

Una vez que ejecutamos el archivo ‘R-4.1.0-win.exe’ se abre la ventana
de selección del idioma de instalación. Por defecto el instalador escoge
el idioma de nuestro sistema operativo, en este caso `Español`.
Escogemos el idioma que deseamos y hacemos clic en `Aceptar`.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/exe_r_aceptar.png)

#### 

La nueva ventana es la de `Información`. Una vez leída la información
hacemos clic en `Siguiente >`. No es tan importante leer la Información,
solo si tienen ganas, no creo que lo haga mucha gente.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/exe_r_sig_1.png)

#### 

Ahora nos toca elegir la `carpeta de instalación`. Ya viene seleccionada
una carpeta por el instalador (recomendamos dejar la carpeta que viene
elegida por defecto). En este caso: `C:\Program Files\R\R-4.1.0`. Luego
hacemos clic en `Siguiente >`.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/exe_r_directorio.png)

#### 

La nueva ventana es la de `Selección de Componentes`. Dejamos todos los
valores que vienen seleccionados por defecto. Luego hacemos clic en
`Siguiente >`.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/exe_r_instalacion_usuario.png)

#### 

Si es la primera vez que se instala R en el ordenador la siguiente
ventana será la de selección de la carpeta del menú de inicio de
Windows. Dejamos el valor preestablecido y hacemos clic en
`Siguiente >`.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/menu_inicio_r.png)

#### 

En la siguiente ventana seleccionamos `No` en las
`opciones de configuración` y hacemos clic en `Siguiente >`.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/exe_r_opc_config.png)

#### 

La ventana emergente es la de `Tareas Adicionales`. Dejamos los valores
preseleccionados, agregamos la selección de ‘Crear un acceso directo en
el Escritorio’ y hacemos clic en `Siguiente >`.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/exe_r_acciones.png)

#### 

Si todo salió bien la instalación se tiene que haber iniciado. Así se ve
la ventana de instalación ya en ejecución:

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/exe_r_instalando.png)

#### 

La última ventana es la de finalización. Para terminar con el proceso de
instalación hacemos clic en `Finalizar`.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/exe_r_completo.png)

#### 

**Cuarto**, abrimos el programa para comprobar que todo está bien. Lo
podemos abrir desde el icono
![](https://estudiosmaritimossociales.org/archivos/imagenes/favicon-16x16.png)
creado en el escritorio o desde el archivo `RGui.exe`. Se tendría que
ver algo como esto:

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/RGui.png)

#### 

Para saber si R está funcionado bien debemos hacer una prueba: escribir
y ejecutar en consola `4 + 4`. Para que corra el código y nos dé el
resultado esperado, después de escribir `4 + 4` en la consola de R
presionamos la tecla `Enter`. El resultado tendría que ser este:

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/RGui4.png)

#### 

## Instalar RStudio

### ¿Qué es RStudio?

RStudio es un entorno de desarrollo integrado (IDE) para R. ¿Qué
significa esto? Bueno, si piensas en R como un lenguaje de programación,
que es lo que efectivamente es, puedes pensar en RStudio como un
programa que te ayuda a escribir y trabajar en el lenguaje R. RStudio
hace que la programación en R sea mucho más amigable. ¡Les sugerimos que
lo usen!

### ¿Cuáles son los pasos para instalar RStudio?

-   Ir a la web oficial de RStudio
-   Descargar el ejecutable de RStudio
-   Instalar RStudio en nuestro ordenador
-   Iniciar el programa para probar que funciona

#### 

#### Descargar e instalar RStudio versión libre

#### 

**Primero**, buscar la página oficial de RStudio para acceder al link de
descarga o ***googlear*** “download RStudio”. Googleemos…

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rstudio_1.png)

#### 

**Segundo**, accedemos a la página
[rstudio.com/products/rstudio/download/](https://rstudio.com/products/rstudio/download/)
y hacemos clic en `Free DOWNLOAD` como se ve abajo en la imagen.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rstudio_2.png)

#### 

Cuando se abre la página de descarga hacemos clic sobre
`DOWNLOAD RSTUDIO FOR WINDOWS` para bajar el archivo
‘RStudio-1.4.1717.exe’ de RStudio.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rstudio_3.png)

#### 

**Tercero**, ejecutamos el archivo ‘RStudio-1.4.1717.exe’ que bajamos
desde la página oficial de RStudio. Es probable que, como ocurrió
anteriormente con el .exe de R, el archivo se haya descargado en la
carpeta Downloads (Descargas) del disco `C:\` de nuestro ordenador.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rstudio_5.png)

#### 

Una vez que localizamos en donde se descargó el `archivo` de RStudio,
nos posamos sobre **RStudio-1.4.1717.exe** con nuestro puntero, luego
presionamos el botón derecho del ratón, seleccionamos de la lista la
opción `Ejecutar como administrador` y finalmente lo ejecutamos como
***administrador*** haciendo un solo clic.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rstudio_6.png)

#### 

Una vez que ejecutamos el archivo **RStudio-1.4.1717.exe** como
administrador se abre la ventana de `Control de cuentas de usuario` de
Windows. Nos pregunta si queremos permitir que RStudio haga cambios,
respondemos haciendo clic en `Sí`.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/INSTALL.png)

#### 

Una vez que ejecutamos ‘RStudio-1.4.1717.exe’ se abre la ventana del
***Asistente de Instalación de RStudio***, lo que sigue es hacer clic en
`Siguiente >`.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rstudio_7.png)

#### 

Ahora nos toca elegir la `carpeta de instalación`. Ya viene seleccionada
una carpeta por el instalador, es recomendable dejar la carpeta que
viene seleccionada por defecto. En este caso:
`C:\Program Files\RStudio`. Y hacemos clic en `Siguiente >`.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rstudio_8.png)

#### 

La nueva ventana es `Elegir Carpeta del Menú de Inicio`. Dejamos todos
los valores que vienen seleccionados por defecto. Luego hacemos clic en
`Instalar`.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rstudio_9.png)

#### 

Si todo salió bien la instalación se tiene que haber iniciado. Así se ve
la ventana de instalación una vez iniciado el proceso:

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rstudio10.png)

#### 

La última ventana es la de finalización. Para terminar con el proceso de
instalación hacemos clic en `Terminar`.

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rstudio11.png)

#### 

**Cuarto**, abrimos el programa para comprobar que todo está bien. Lo
podemos abrir desde el
[icono](https://rstudio.com/wp-content/uploads/2018/10/RStudio-Logo.svg)
creado en el escritorio o desde el archivo `rstudio.exe`. Se tendría que
ver algo como esto, pero con fondo blanco:

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rstudio12.png)

#### 

Una breve descripción de las cuatro ventas de la imagen de arriba. La
ventana de arriba a la izquierda sirve para escribir código sin tener la
obligación de ejecutarlo línea por línea. La ventana de abajo a la
izquierda sirve para ejecutar código línea por línea, es la consola de R
que RStudio reproduce en su entorno de trabajo. La ventana de arriba a
la derecha sirve para visualizar y saber con qué tipo de objetos estamos
trabajando: un vector, un texto, una tabla, etc. La ventana de abajo a
la derecha sirve para acceder a las carpetas y los archivos que tenemos
en nuestro ordenador. Como habrán notado, cada ventana tiene solapas con
otras funciones, pero no es necesario entrar en ello ahora mismo.

Para saber si RStudio está funcionado bien hacemos una prueba:
escribimos y ejecutamos en consola `4 + 4`. Para que corra el código y
nos dé el resultado esperado, después de escribir `4 + 4` en la consola
de R(Studio) presionamos la tecla `Enter`. El resultado tendría que ser
este:

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rstudio13.png)

#### 

## Instalar paquetes

### ¿A qué se le llama paquetes (`packages`) en el entorno de trabajo de R y RStudio?

Los paquetes son colecciones de funciones y de datos que están reunidos
(**empaquetados**) de forma estructurada, que se almacenan en una
carpeta accesible desde R.

Una función es un grupo de instrucciones que toma datos de entrada
(`input`) y retorna un resultado (`output`). Tiene un objetivo
particular y se ejecuta al ser llamada de forma explícita.

Bueno, tampoco es que haya que entender de entrada y en detalle de que
se trata una función. Viene al caso solo para que se hagan una idea.

### ¿Cómo instalar paquetes en R(Studio)?

¡Con una función! Sí, los paquetes son conjuntos de funciones que se
pueden instalar usando otras funciones.

En este caso la función que necesitamos usar para instalar cualquier
paquete es `install.packages()`. Vale aclarar que **install.packages()**
ya viene activa como función base de R, al igual que muchas otras
funciones.

También existen otras funciones para instalar paquetes. Pero por ahora
nos alcanza con conocer la que más se usa.

Hagamos la instalación del paquete `tidyverse` que es uno de los
paquetes más utilizado en el entorno de trabajo de R(Studio). Para
hacerlo debemos completar la función `install.packages()` con el nombre
del paquete que queremos instalar.

Pero antes hablemos un poco del paquete que estemos por instalar.
Tidyverse es un paquete de paquetes, es una colección de paquetes que
funcionan bien juntos y proporcionan herramientas para tareas comunes de
ciencia de datos. Ya sabemos de qué trata `tidyverse`, ahora pasemos a
instalarlo en nuestro ordenador.

Vamos a la consola de R en RStudio y copiamos o pegamos la siguiente
instrucción: `install.packages("tidyverse")`. Luego presionamos la tecla
`Enter` y listo…

El resultado tiene que ser una lista larga de paquetes instalándose,
algo parecido a lo que se ve abajo en la imagen, que es solo una parte
del listado que se imprime en consola:

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rstudio14b.png)

#### 

Ahora probemos si el paquete se instaló bien. Para saber si `tidyverse`
se carga bien debemos usar la función `library()` de esta forma:

    library(tidyverse)

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.3.5     v purrr   0.3.4
    ## v tibble  3.1.2     v dplyr   1.0.6
    ## v tidyr   1.1.3     v stringr 1.4.0
    ## v readr   1.4.0     v forcats 0.5.1

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter()         masks stats::filter()
    ## x readr::guess_encoding() masks rvest::guess_encoding()
    ## x dplyr::lag()            masks stats::lag()

#### 

Si el mensaje es igual o similar al impreso acá arriba quiere decir que
el paquete se cargó bien. **¡Felicitaciones!**

Si por el contrario R(Studio) mostró un mensaje de error, que no cunda
el pánico, siempre hay una solución. Primero debemos revisar el código
porque cualquier símbolo incorrecto (una letra, una coma, un número, una
comilla) aborta la instrucción y devuelve un fallo. Si ya revisaron lo
escrito y el fallo persiste pude que tengan que instalar otro archivo
.exe, nos referimos al archivo `Rtools` para gestión de “paquetes
binarios” de R en Windows. En esta página oficial de R Project tienen
todos los pasos necesarios para instalar el Rtools:
[cran.r-project.org/bin/windows/Rtools/](https://cran.r-project.org/bin/windows/Rtools/).

#### 

Igualmente, aquí les dejo los pasos básicos en castellano para instalar
Rtools:

#### 

1º Bajamos el Rtools según sean las características de nuestro Windows:

-   En Windows de 64 bits:
    [rtools40-x86\_64.exe](https://cran.r-project.org/bin/windows/Rtools/rtools40-x86_64.exe)
    (recomendado: incluye compiladores i386 y x64)
-   En Windows de 32 bits:
    [rtools40-i686.exe](https://cran.r-project.org/bin/windows/Rtools/rtools40-i686.exe)
    (solo compiladores i386)

#### 

2º Ejecutamos como administrador el archivo `rtools40-x86_64.exe`

#### 

![](https://estudiosmaritimossociales.org/archivos/imagenes/rtools.png)

#### 

3º Colocamos Rtools en el PATH. Después de que la instalación se
complete, necesitaran realizar un paso más para poder compilar los
paquetes en R: necesitaran poner la ubicación de las utilidades de
Rtools make en el PATH. Pueden hacer esto desde R ejecutando esta línea
de código:
`writeLines('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', con = "~/.Renviron"))`

Ahora reinicien R y verifiquen que pueden encontrar la `make`, que
debería mostrar la ruta de su instalación de Rtools. Pueden hacer esto
desde R ejecutando esta línea de código: `Sys.which("make")`. El
resultado en consola tendría que verse así:
`## "C:\\rtools40\\usr\\bin\\make.exe"`

Si esto funcionó, ahora podrá instalar paquetes de R desde la fuente.
Pruebe con la siguiente línea:
`install.packages("jsonlite", type = "source")`

#### 

###### ¿Tuvieron éxito? ¡Felicitaciones!

### Créditos

Este tutorial es una versión no interactiva del tutorial interactivo
(<https://gesmar-mdp.shinyapps.io/Instalr_R/>) que fue realizado con el
paquete learnr de R [ver el código
fuente](https://github.com/agusnieto77/instalr_R/blob/main/tutorial_rmd).
Para desarrollar el código de la versión interactiva me base en este
ejemplo [Set
Up](https://github.com/rstudio/learnr/blob/master/inst/tutorials/ex-setup-r/ex-setup-r.Rmd).

### 

<p style="text-align: center;">

Esto es todo por ahora. ¡Nos vemos pronto!
