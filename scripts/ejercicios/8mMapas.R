require(tidyverse)
require(sf)
require(rnaturalearth)
require(rnaturalearthdata)
require(ggspatial)
require(maps)
require(ggthemes)
require(gganimate)
require(grid)
require(ggtext)

# Definimos el tema
theme_set(theme_bw())

# Definimos el mapa
world <- ne_countries(scale = "medium", returnclass = 'sf')

# Lo vemos
ggplot(data = world) +  geom_sf()

# Cargamos los datos 
tw8mcomp <- readRDS(url('https://estudiosmaritimossociales.org/archivos/8Mcompleto.rds','rb'))

# Activamos las fuentes que vamos a usar
windowsFonts(sans="Raleway Medium")
windowsFonts(sans="Rockwell")
loadfonts(device="win")
loadfonts(device="postscript")

# Gráfico de líneas
ggsave('graflineas.png',
tw8mcomp %>%
  rtweet::ts_plot("4 hours", color="green", size=1.5) +
  scale_x_datetime(breaks = seq(as.POSIXct("2020-02-01 00:00:00 UTC"),
                              as.POSIXct("2020-03-10 00:00:00 UTC"), "72 hours"),
                   labels = scales::date_format("%a-%d\n%H:%M", tz = "UTC"),
                   expand = c(0, 0),
                   limits = c(
                     as.POSIXct("2020-02-01 00:00:00 UTC"),
                     as.POSIXct("2020-03-10 00:00:00 UTC"))) + 
  ggplot2::theme_minimal(base_size = 20) +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = 'Año 2020', y = NULL,
    title = "Frecuencia de tweets sobre el #8M entre el 1º de febrero y el 14 de marzo",
    subtitle = "Tweets agrupados en intervalos de 4 horas",
    caption = paste("\nn = ", format(as.integer(nrow(tw8mcomp)), big.mark="."), 
                    "\nFuente: Datos recogidos de la API REST de Twitter a través de rtweet")), 
width = 16, height = 13, dpi = 600, units = "in", device='png')

# preparamos los datos para georreferenciarlos en el mapa
tw8m <- rtweet::lat_lng(tw8mcomp) %>% filter(!is.na(lat)) %>% filter(!is.na(lng))

tw8m_x_dia <- tw8m %>% group_by(lng,lat,fecha=as.Date(created_at)) %>% count(lng) %>% arrange(desc(n))

tw8m_x_total <- tw8m %>% group_by(lng,lat) %>% count(lng) %>% arrange(desc(n))

# Mapa 1 - estático
ggsave('mapa1.png',
ggplot(tw8m_x_total) + 
  geom_sf(fill="white", data = world) +
  geom_point(aes(lng,lat, size = n), color="darkgreen", alpha = .5) +
  labs(title = "Distribución socioterritorial del hashtag #8M",
       x = " ", y = " ") +
  theme_bw() +
  theme(text = element_text(face="bold", size = 20, color = "black"),
        legend.text = element_text(colour = "black", size = 18),
        legend.key = element_blank(),
        legend.key.size = unit(1, "cm"),
        legend.key.width = unit(1,"cm"),
        axis.text.x = element_text(colour="black", size=rel(0.8)),
        axis.text.y = element_text(face="bold", colour="black", size=rel(0.8)),
  ) +
  labs(size = 'tweets'), 
width = 14, height = 13, dpi = 600, units = "in", device='png')

# Mapa 2 - dinámico
ggplot() +
  borders("world", colour = "white", fill = "black") +
  geom_point(aes(lng,lat, size = n),
             data = tw8m_x_dia, 
             colour = 'green', alpha = .5) +
  theme_map()

anim_save("tw8m_x_diamap6.gif",
animate(
  ggplot() +
  borders("world", colour = "white", fill = "black") +
  geom_point(aes(lng,lat, size = n),
             data = tw8m_x_dia, 
             colour = 'green', alpha = .5) +
  labs(title = "Distribución socioterritorial del hashtag #8M: <span style = 'color: purple;'>{frame_time}</span>",
    caption = "\nn = 12.128
    \nFuente: Datos recogidos de la API REST de Twitter a través de rtweet",
    size = 'tweets',
    x= NULL, y=NULL) +
  theme_bw() +
  theme(text = element_text(face="bold", size = 14, color = "black"),
        legend.background = element_rect(fill = "transparent"),
        legend.position = c(0.18, 0.38),
        legend.text = element_text(colour = "black", size = 14),
        legend.key = element_blank(),
        legend.key.size = unit(1, "cm"),
        legend.key.width = unit(1,"cm"),
        axis.text.y = element_blank(),
        axis.text.x = element_blank(),
        plot.title = element_markdown()) + 
  transition_time(fecha) + shadow_mark(),
  nframes = 25, fps = 5, end_pause = 10, #duration = 15,
  height = 10, width = 15, units = "in", res = 200
  )
)

# Recursostutoriales y Guías para usar la API de Twitter con el paquete rtweet

# https://analiticaurbana.netlify.app/obteniendo-y-analizando-datos-de-redes-sociales.html
# https://docs.ropensci.org/rtweet/index.html
# https://medium.com/@traffordDataLab/exploring-tweets-in-r-54f6011a193d
# https://rtweet-workshop.mikewk.com/#1
# https://dev.to/twitterdev/getting-started-with-r-and-the-twitter-api-1fdf
# https://www.storybench.org/get-twitter-data-rtweet-r/
# https://developer.twitter.com/en/docs/tutorials/getting-started-with-r-and-v2-of-the-twitter-api
# https://cran.r-project.org/web/packages/rtweet/vignettes/intro.html
# https://crd230.github.io/lab4b.html

