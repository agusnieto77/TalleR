require(tidyverse)
require(quanteda)
require(quanteda.textplots)
require(extrafont)

# Cargmos los datos 
# tw8mcomp <- readRDS(url('https://estudiosmaritimossociales.org/archivos/8Mcompleto.rds','rb'))

# Preparamos los datos
tw8mcomp_dfm <- dfm(tokens_select(tokens(tw8mcomp$text, remove_punct = TRUE), 
                                  pattern = '#8m', selection = "remove"))

# Activamos las fuentes que vamos a usar
windowsFonts(sans="Raleway Medium")
windowsFonts(sans="Rockwell")
loadfonts(device="win")
loadfonts(device="postscript")

# Hashtags --------------------------------------------------------------------------------

# Extraemos los hashtags
(hashtags_dfm <- dfm_select(tw8mcomp_dfm, pattern = "#*"))

# Armamos el top 200
(top_hashtags <- names(topfeatures(hashtags_dfm, 50)))

# Construimos una matriz de co-ocurrencia de hashtags
(hashtags_fcm <- fcm(hashtags_dfm))

# armamos el top 50
top_hashtags_fcm <- fcm_select(hashtags_fcm, pattern = top_hashtags)

# Visualizamos
set.seed(12345)
ggsave(
textplot_network(top_hashtags_fcm, min_freq = 0.5, edge_alpha = 0.1, edge_size = 4,
                 edge_color = "purple",
                 vertex_labelsize = log10((Matrix::rowSums(top_hashtags_fcm)*.3)+1),
                 vertex_color = "purple",
                 vertex_labelfont = if (Sys.info()["sysname"] == "Raleway Medium") "Raleway Medium" else NULL,
                 vertex_size = 1,
                 vertex_labelcolor = "grey10"),
filename = 'red_hashtags.png',
width = 13,
height = 10,
units = "in")

# Nombres de usuarixs --------------------------------------------------------------------
# Extraemos lxs usuarixs
usuarixs_dfm <- dfm_select(tw8mcomp_dfm, pattern = "@*")

# Quitamos los @
usuarixs_dfm@Dimnames$features <- gsub("@", "", usuarixs_dfm@Dimnames$features)

# Armamos el top 200
(top_usuarixs <- names(topfeatures(usuarixs_dfm, 200)))

# Creamos una matriz de co-ocurrencia de usuarixs
(usuarixs_fcm <- fcm(usuarixs_dfm))

# Nos quedamos con el top 200
usuarixs_fcm <- fcm_select(usuarixs_fcm, pattern = top_usuarixs)

# Visualizamos la red
set.seed(12345)
ggsave(
textplot_network(usuarixs_fcm, min_freq = 0.2, edge_alpha = 0.25, edge_size = 2,
                 edge_color = "purple",
                 vertex_labelsize = log10((rowSums(usuarixs_fcm)+1)/min((rowSums(usuarixs_fcm)+1))), #log((Matrix::rowSums(usuarixs_fcm)*.1)+1),
                 vertex_color = "purple",
                 vertex_labelfont = if (Sys.info()["sysname"] == "Raleway Medium") "Raleway Medium" else NULL,
                 vertex_size = 1,
                 vertex_labelcolor = "grey10",
                 mode = "lower"),
filename = 'red_usuarixs.png',
width = 15,
height = 12,
units = "in")

# Recursos, guías y tutoriales

# https://github.com/briatte/awesome-network-analysis#r
# https://github.com/vosonlab/vosonSML
# https://www.bioconductor.org/packages/devel/bioc/vignettes/RedeR/inst/doc/RedeR.html
# https://kateto.net/network-visualization
# https://igraph.org/
# http://talks.schochastics.net/netViz/slides.html#1
# http://mr.schochastics.net/netVizR.html
# http://blog.schochastics.net/post/non-hierarchical-edge-bundling-in-r/
# http://blog.schochastics.net/post/visualizing-multilevel-networks-with-graphlayouts/
# http://blog.schochastics.net/post/ggraph-tricks-for-common-problems/
# http://graphlayouts.schochastics.net/
# https://www.data-imaginist.com/2017/introducing-tidygraph/
# https://www.r-graph-gallery.com/250-correlation-network-with-igraph.html
# https://sci-hub.se/https://doi.org/10.2200/S00298ED1V01Y201009DMK003
# https://www.r-craft.org/r-news/twitter-data-analysis-in-r/
# https://algotech.netlify.app/blog/social-network-analysis-in-r/
# https://juanitorduz.github.io/text-mining-networks-and-visualization-plebiscito-tweets/
# https://journals.sagepub.com/doi/full/10.1177/2056305117691545
# https://www.tandfonline.com/doi/full/10.1080/23311983.2016.1171458
# https://www.sciencedirect.com/science/article/pii/S0925231221000874
# https://medium.com/analytics-vidhya/social-network-analysis-in-r-38fbf2512290
# https://slcladal.github.io/net.html
