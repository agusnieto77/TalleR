# Instalar los paquetes que no tengan instalados

# install.packages("devtools")
devtools::install_github("yutannihilation/ggsflabel")
# Enter one or more numbers, or an empty line to skip updates: 3

# Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------


require(dplyr)

require(sf)

require(lubridate)

require(ggspatial)

require(ggsflabel)

require(ggplot2)





# Normalizamos los datos, le damos formato fecha a las fechas y eliminamos las duplicaciones ----------------------------------------------------------



notas_rev_puerto_procesadas <- readRDS(url("https://estudiosmaritimossociales.org/modulo_3/notas_rev_puerto_procesadas.rds","rb"))





# Bajamos, cargamos y preparamos el mapa de las provincias argentinas ----------------------------------------------------------------------------------

# Bajamos los tres archivos en el mismo directorio



download.file("https://estudiosmaritimossociales.org/modulo_3/provincias_latlong.zip", "provincias_latlong.zip")





# Descomprimimos los archivos -------------------------------------------------------------------------------------------------------------------------



unzip(zipfile = "provincias_latlong.zip", exdir = ".")





# Creamos el objeto 'provincias' ----------------------------------------------------------------------------------------------------------------------



provincias <- read_sf("provincias_latlong.shp")





# Le asignamos un sistema de coordenadas --------------------------------------------------------------------------------------------------------------



st_crs(provincias) <- 4326





# Normalizamos los nombres para que coincidan con los de nuestra base de datos ------------------------------------------------------------------------



provincias$NOMBRE



provincias <- provincias %>%  mutate(NOMBRE = case_when(NOMBRE == "Rio Negro" ~ "Río Negro", TRUE ~ as.character(NOMBRE)))





# Nos quedamos solo con las provincis con litoral marítimo --------------------------------------------------------------------------------------------



prov_pesqueras <- provincias %>% 

  filter(FIRST_MIN1 == 6|FIRST_MIN1 == 26|FIRST_MIN1 == 62|FIRST_MIN1 == 78|FIRST_MIN1 == 94)



prov_pesqueras$NOMBRE





# Elaboramos una tabla con datos de población y desembarques para armar un índice de conflictividad



pobla_prov <- tibble(

  NOMBRE = prov_pesqueras$NOMBRE,

  poblacion = c(618989, 81315, 21643, 14183, 74752),

  desembarques = c(471264.3, 158192.4, 14009.2, 138166.9, 15.8)) # año 2013





# Testeamos el mapa -----------------------------------------------------------------------------------------------------------------------------------



ggplot(data=prov_pesqueras) + 

  geom_sf(fill="white")





# Hacemos el primer mapa ------------------------------------------------------------------------------------------------------------------------------



# Preparamos los datos

notas_rev_puerto_procesadas %>% 

  filter(palabras_conflictivas > 2) %>% 

  filter(provincias != "s_d") %>%

  group_by(provincias, year(fecha)) %>% 

  summarise(sum(palabras_conflictivas)) %>% 

  rename(años = `year(fecha)`,

         índice = `sum(palabras_conflictivas)`) %>% 

  full_join(prov_pesqueras, by = c("provincias" = "NOMBRE")) %>% 

  full_join(pobla_prov, by = c("provincias" = "NOMBRE")) %>% 

  st_as_sf() %>% 

# Arrancamos con el mapa (la generación del mapa tarda unos minutos...)

  ggplot() + 

  geom_sf(data = provincias) +

  geom_sf(fill="white", data=prov_pesqueras) +

  geom_sf(aes(fill = índice)) + 

  geom_sf_label(aes(label = índice), size = 3.5) +

  scale_fill_gradient2(low = "white" , mid = "#396fff", high = "#ff396f") +

  annotation_scale(location = "br", 

                   width_hint = 0.3, 

                   height = unit(0.15, "cm"), 

                   text_pad = unit(0.15, "cm"),

                   text_cex = 0.55, 

                   pad_y = unit(0.05, "in"),

                   pad_x = unit(0.05, "in")) +

  annotation_north_arrow(location = "br", which_north = "true", 

                         height = unit(.8, "cm"), width = unit(.8, "cm"),

                         pad_x = unit(0.05, "in"), pad_y = unit(0.15, "in"),

                         style = north_arrow_fancy_orienteering)+

  coord_sf(xlim = c(-75.0, -54.0), ylim = c(-56.0, -33.0), expand = F) +

  facet_wrap(~ años, nrow = 2) +

  labs(title = "Distribución socioterritorial de la conflictividad en los puertos pesqueros (2009-2020)",

       x = NULL, y = NULL) +

  theme_classic() +

  theme(

    title = element_text(size = 16),

    strip.text = element_text(face="bold"),

    legend.title = element_blank(),

    legend.text = element_text(colour = "grey30", size = 10),

    legend.key = element_blank(),

    legend.key.size = unit(0.5, "cm"),

    legend.key.width = unit(0.5,"cm"),

    axis.text.x = element_text(face="bold", angle = 90, colour="grey30", size=rel(1)),

    axis.text.y = element_text(face="bold", angle = 360, colour="grey30", size=rel(1)),

    panel.spacing = unit(1.0, "lines"),

    legend.position = "none")





# Hacemos el segundo mapa -----------------------------------------------------------------------------------------------------------------------------



# Preparamos los datos

datos_mapa_2 <- notas_rev_puerto_procesadas %>% 

  filter(palabras_conflictivas > 2) %>% 

  filter(provincias != "s_d") %>%

  group_by(provincias, year(fecha)) %>% 

  summarise(sum(palabras_conflictivas)) %>% 

  rename(años = `year(fecha)`,

         índice = `sum(palabras_conflictivas)`) %>% 

  filter(años != 2012) %>% 

  full_join(prov_pesqueras, by = c("provincias" = "NOMBRE")) %>% 

  full_join(pobla_prov, by = c("provincias" = "NOMBRE")) %>% 

  st_as_sf()



# Arrancamos con el mapa (la generación del mapa tarda unos minutos...)

ggplot(datos_mapa_2) + 

  geom_sf(data = provincias) +

  geom_sf(fill="white", data=prov_pesqueras) +

  geom_sf(aes(fill = índice)) + 

  geom_sf_label(aes(label = índice), size = 3.5, alpha = .6) +

  scale_fill_gradient2(low = "white" , mid = "#396fff", high = "#ff396f") +

  annotation_scale(location = "br", 

                   width_hint = 0.3, 

                   height = unit(0.15, "cm"), 

                   text_pad = unit(0.15, "cm"),

                   text_cex = 0.55, 

                   pad_y = unit(0.05, "in"),

                   pad_x = unit(0.05, "in")) +

  annotation_north_arrow(location = "br", which_north = "true", 

                         height = unit(.8, "cm"), width = unit(.8, "cm"),

                         pad_x = unit(0.05, "in"), pad_y = unit(0.15, "in"),

                         style = north_arrow_fancy_orienteering)+

  coord_sf(xlim = c(-75.0, -54.0), ylim = c(-56.0, -33.0), expand = F) +

  facet_wrap(~ años, nrow = 2) +

  labs(title = "Distribución socioterritorial de la conflictividad en los puertos pesqueros (2009-2020)",

       x = NULL, y = NULL) +

  theme_classic() +

  theme(

    title = element_text(size = 16),

    strip.text = element_text(face="bold"),

    legend.title = element_blank(),

    legend.text = element_text(colour = "grey30", size = 10),

    legend.key = element_blank(),

    legend.key.size = unit(0.5, "cm"),

    legend.key.width = unit(0.5,"cm"),

    axis.text.x = element_text(face="bold", angle = 90, colour="grey30", size=rel(1)),

    axis.text.y = element_text(face="bold", angle = 360, colour="grey30", size=rel(1)),

    panel.spacing = unit(1.0, "lines"),

    legend.position = c(0.93, 0.24),

    plot.title = element_text(size = 18, hjust = .5, face = "bold", color = "grey35"))





sessionInfo()



# Fin del script ----------------------------------------------------------------------------------



# Pueden copiar y pegar o descargarlo desde RStudio con esta línea de comando:



download.file("https://estudiosmaritimossociales.org/ejercicio08.R", "ejercicio08.R")

