# Cargar librerías -------------------------------------------------------------------------

require(tidyverse)
require(rvest)
require(lubridate)
require(qdapRegex)
require(ggalt)

# Normalizar datos fechas y eliminar duplicaciones --------------------------------------------------------

RP_Tok_notas <- readRDS(url("https://estudiosmaritimossociales.org/modulo_3/notas_rev_puerto.rds","rb")) %>% 
  mutate(fecha = dmy(fecha)) %>% distinct(link, .keep_all = TRUE)

#limpieza

RP_Tok_notas$nota_limpia <- RP_Tok_notas$nota
RP_Tok_notas$nota_limpia <- rm_url(RP_Tok_notas$nota_limpia, replacement = "_LINK_")
RP_Tok_notas$nota_limpia <- rm_twitter_url(RP_Tok_notas$nota_limpia, replacement = "_TWITTER_")
RP_Tok_notas$nota_limpia <- rm_email(RP_Tok_notas$nota_limpia, replacement = "_MAIL_")
RP_Tok_notas$nota_limpia <- gsub("comercial_cmiam@mrecic", " _MAIL_ ", RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(pattern = "@[[:alnum:]|[:punct:]]+", replacement = "_@@_", RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("FCYWhmwggCPkYHdc", "", RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("SnDFUa_ QcU", "", RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("EfwiiPXDNE", "", RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("NWQvISZvZA", "", RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("NORMLEXPUB::::NO::P_ILO_CODE:C", "", RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("NORMLEXPUB::::NO::P_ILO_CODE:R", "", RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("SISTEMA-NACIONAL-DE-%C%REAS-MARINAS-PROTEGIDAS.pdf", "", RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("C%Bn-libro-el-margen-continental-argentino", "", RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Video----at-.mp", "", RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("la Banca", "la Banca 25", RP_Tok_notas$nota_limpia)


###################----PuertosXProvincias----###################
## Buenos Aires
RP_Tok_notas$nota_limpia <- gsub("Buenos Aires","Buenos_Aires",RP_Tok_notas$nota_limpia)

#MDP
RP_Tok_notas$nota_limpia <- gsub("Mar del Plata","mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Batán","mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Partido de General Pueyrredón","mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Partido de General Pueyrredon","mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("partido de General Pueyrredón","mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("partido de General Pueyrredon","mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("General Pueyrredón","mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("General Pueyrredon","mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Gral. Pueyrredon","mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Gral Pueyrredon","mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Gral. Pueyrredón","mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Gral Pueyrredón","mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("del Partido de Gral. Pueyrredon","de mdp",RP_Tok_notas$nota_limpia)

#BAHÍA_BLANCA
RP_Tok_notas$nota_limpia <- gsub("Bahía Blanca","Bahía_Blanca",RP_Tok_notas$nota_limpia)

#WHITE
RP_Tok_notas$nota_limpia <- gsub("Ingeniero White","Ing_White",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Ing. White","Ing_White",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" En White "," En Ing_White ",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" en White "," en Ing_White ",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" de White "," de Ing_White ",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" de White,"," de Ing_White,",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" de White."," de Ing_White.",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" en White"," en Ing_White",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("oriundo de White","whitense",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("White con el vertido de desechos tóxicos","Ing_White con el vertido de desechos tóxicos",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub('Ingeniero  White','Ing_White',RP_Tok_notas$nota_limpia)


#### Rio Negro
RP_Tok_notas$nota_limpia <- gsub("Río Negro","Río_Negro",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Rio Negro","Río_Negro",RP_Tok_notas$nota_limpia)

#SAN_ANTONIO_ESTE
RP_Tok_notas$nota_limpia <- gsub("San Antonio de Este","San_Antonio_Este",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("San Antonio Este","San_Antonio_Este",RP_Tok_notas$nota_limpia)

#SAN_ANTONIO_OESTE
RP_Tok_notas$nota_limpia <- gsub("San Antonio Oeste","San_Antonio_Oeste",RP_Tok_notas$nota_limpia)



####--------------Chubut
# MADRYN
RP_Tok_notas$nota_limpia <- gsub("Puerto Madryn","Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("puerto Madryn","Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("el puerto de Madryn","Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("PUERTO MADRYN","Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("del Puerto madrynense","de Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("del puerto madrynense","de Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("puerto madrynense","Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Puerto madrynense","Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("en Madryn","en Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("de Madryn","de Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("a Madryn","a Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("hacia Madryn","hacia Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("MADRYN","Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" Madryn "," Puerto_Madryn ",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(". Madryn",". Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" Madryn,"," Puerto_Madryn,",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" Madryn."," Puerto_Madryn.",RP_Tok_notas$nota_limpia)

# COMODORO
RP_Tok_notas$nota_limpia <- gsub("Pesquera Pesca Comodoro","Pesquera_Pesca_Comodoro",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Pesquera Puerto Comodoro","Pesquera_Puerto_Comodoro",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro Py","Comodoro_Py",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro de Marina","comodoro de marina",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Agencia Comodoro Conocimiento","Agencia_Comodoro_Conocimiento",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro Rivadavia","Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro  Rivadavia","Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("comodoro Rivadavia","Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("COMODORO RIVADAVIA","Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" de Comodoro"," de Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" en Comodoro"," en Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" a Comodoro"," a Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" desde Comodoro"," desde Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Desde Comodoro ","Desde Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("en Comodoro","en Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("En Comodoro","En Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" EN COMODORO"," En Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("COMODORO","Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro ","Comodoro_Rivadavia ",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro.","Comodoro_Rivadavia.",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro_Rivadavia_Rivadavia_Rivadavia_Rivadavia_Rivadavia","Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro_Rivadavia_Rivadavia_Rivadavia_Rivadavia","Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro_Rivadavia_Rivadavia_Rivadavia","Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro_Rivadavia_Rivadavia","Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro_Rivadavia.Rivadavia_Rivadavia","Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro_Rivadavia.Rivadavia","Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Autovía Comodoro_Rivadavia","Autovía_Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Pesquera Comodoro_Rivadavia","Pesquera_Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("comodoro_rivadavia_py","comodoro_py",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("“pesquera_comodoro_rivadavia.","“Pesquera_Comodoro_Rivadavia”",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("“agencia_comodoro_rivadavia.conocimiento”","“agencia_comodoro_rivadavia”",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("pesquera_puerto_comodoro_rivadavia","pesquera_comodoro_rivadavia",RP_Tok_notas$nota_limpia)

# CAMARONES
RP_Tok_notas$nota_limpia <- gsub("Criadores de Camarones","Criadores de Camarón",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Bahía de Camarones","Bahía_Camarones",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Bahía Camarones","Bahía_Camarones",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Colegio Camarones","Colegio_Camarones",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("en Camarones","Bahía_Camarones",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" Camarones"," Bahía_Camarones",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("bahía Camarones","Bahía_Camarones",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("BAHÍA CAMARONES","Bahía_Camarones",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("bahía camarones","Bahía_Camarones",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(". Camarones",". Bahía_Camarones",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(", Camarones y",", Bahía_Camarones",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Camarones logró su certificación","Bahía_Camarones logró su certificación",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("deBahía_Camarones","de Bahía_Camarones",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Camarones: $","Bahía_Camarones: $",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(",Bahía_Camarones",", Bahía_Camarones",RP_Tok_notas$nota_limpia)

# CALETA CORDOVA
RP_Tok_notas$nota_limpia <- gsub("Caleta Córdova","Caleta_Córdova",RP_Tok_notas$nota_limpia)

# CALETA SARA
RP_Tok_notas$nota_limpia <- gsub("Caleta Sara","Caleta_Sara",RP_Tok_notas$nota_limpia)

#MAS DE UNO
RP_Tok_notas$nota_limpia <- gsub("Comodoro y Madryn","Comodoro_Rivadavia y Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("MADRYN O COMODORO"," Puerto_Madryn o Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("RAWSON Y COMODORO"," Rawson y Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("MADRYN O COMODORO"," Puerto_Madryn o Comodoro_Rivadavia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro tiene un punto más que Puerto_Madryn","Comodoro_Rivadavia tiene un punto más que Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro se está recuperando gracias","Comodoro_Rivadavia se está recuperando gracias",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro es un puerto","Comodoro_Rivadavia es un puerto",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Madryn, Deseado y Caleta Olivia","Puerto_Madryn, Puerto_Deseado y Caleta_Olivia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Deseado y Caleta","Puerto_Deseado y Caleta_Olivia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Madryn y Deseado","Puerto_Madryn y Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Madryn, Comodoro o Deseado","Puerto_Madryn, Comodoro_Rivadavia o Puerto_Deseado y Caleta_Olivia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Deseado o Madryn","Puerto_Deseado o Puerto_Madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Deseado o mdp","Puerto_Deseado o mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Ushuaia y Deseado","Puerto_Deseado y Ushuaia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Comodoro y Deseado","Comodoro_Rivadavia y Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" Deseado, Madryn, mdp y Montevideo"," Puerto_Deseado, Puerto_Madryn, mdp y Montevideo",RP_Tok_notas$nota_limpia)

####----------Santa Cruz
RP_Tok_notas$nota_limpia <- gsub("Santa Cruz","Santa_Cruz",RP_Tok_notas$nota_limpia)

#DESEADO
RP_Tok_notas$nota_limpia <- gsub("Puerto Deseado","Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("PUERTO DESEADO","Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("DESEADO","Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("En Deseado","En Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" en Deseado"," en Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Deseado es","Puerto_Deseado es",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Deseado fue","Puerto_Deseado fue",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Deseado tiene","Puerto_Deseado tiene",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Deseado queda","Puerto_Deseado queda",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Deseado ha","Puerto_Deseado ha",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Deseado dejó","Puerto_Deseado dejó",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Deseado recibe","Puerto_Deseado recibe",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("el puerto de Deseado","el Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Puerto de Deseado","Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Departamento Deseado","Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("hacia Deseado","hacia Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("hacia Deseado","hacia Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" a Deseado"," a Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" de Deseado"," de Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" desde Deseado"," desde Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" Deseado, que se ve sumamente"," Puerto_Deseado, que se ve sumamente",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" o Deseado"," o Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" con Deseado"," con Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("para Deseado","para Puerto_Deseado, que se ve sumamente",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub(" Deseado como"," Puerto_Deseado como",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("vive Deseado"," vive Puerto_Deseado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cosechando Deseado","cosechando Puerto_Deseado",RP_Tok_notas$nota_limpia)

#CALETA OLIVIA
RP_Tok_notas$nota_limpia <- gsub("Caleta Olivia","Caleta_Olivia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("CALETA OLIVIA","Caleta_Olivia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Puerto_Puerto_Puerto_Deseado y Caleta_Olivia_Olivia Olivia","Puerto_Deseado y Caleta_Olivia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Caleta Paula","Caleta_Paula",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("la planta de Caleta bajo los dominios de Barillari","la planta de Caleta_Paula bajo los dominios de Barillari",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("estaban en Caleta están viajando a Gallegos","estaban en Caleta_Paula están viajando a Gallegos",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("la crisis en Caleta va a profundizarse","la crisis en Caleta_Paula va a profundizarse",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("En Caleta a la zafra","En Caleta_Olivia a la zafra",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Si los pescadores de Caleta confían","Si los pescadores de Caleta_Olivia confían",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("CALETA OLIVIA","Caleta_Olivia",RP_Tok_notas$nota_limpia)

## Tierra del Fuego
RP_Tok_notas$nota_limpia <- gsub("Tierra del Fuego","Tierra_del_Fuego",RP_Tok_notas$nota_limpia)

#USUAHIA
RP_Tok_notas$nota_limpia <- gsub("Usuahia","Ushuaia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("Ushuaía","Ushuaia",RP_Tok_notas$nota_limpia)

#RIO_GALLEGOS
RP_Tok_notas$nota_limpia <- gsub("Río Gallegos","Río_Gallegos",RP_Tok_notas$nota_limpia)


#########################-----Organizaciones-----#########################
#minúsculas
RP_Tok_notas$nota_limpia <- str_to_lower(RP_Tok_notas$nota_limpia, locale = "es")

### ORGANIZACIONES
## sindicatos

#SITRAPE
RP_Tok_notas$nota_limpia <- gsub("sindicato de trabajadores del pescado","sitrape",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sitrape \\(sitrape\\)","sitrape",RP_Tok_notas$nota_limpia)

#UTPYA
RP_Tok_notas$nota_limpia <- gsub("unión de trabajadores del pescado y afines","utpya",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("utpya \\(utpya\\)","utpya",RP_Tok_notas$nota_limpia)

#SOIP
RP_Tok_notas$nota_limpia <- gsub("sindicato de obreros de la industria del pescado","soip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de obrero de la industria del pescado","soip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato obrero de la industria del pescado","soip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato obrero de trabajadores del pescado","soip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato obrero de la industria pesquera","soip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de los obreros del pescado","soip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato obrero del pescado","soip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato del pescado","soip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("soip \\(soip\\)","soip",RP_Tok_notas$nota_limpia)

#SIMAPE
RP_Tok_notas$nota_limpia <- gsub("propios dirigentes gremiales del sindicato marplatense","propios dirigentes gremiales del simape",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato marplatense de pescadores","simape",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de marítimo pescadores","simape",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato marítimo de pescadores","simape",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato marítimos pescadores","simape",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("simape \\(simape\\)","simape",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("simape simape","simape",RP_Tok_notas$nota_limpia)

#SOMU
RP_Tok_notas$nota_limpia <- gsub("sindicato de obreros marítimos unidos","somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato obrero de marítimos unidos","somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de obrero marítimos unidos","somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato obreros marítimos unidos","somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato obrero marítimos unidos","somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("el centenario sindicato marítimo","somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato obrero marítimo","somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("somu \\(somu\\)","somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("somu somu","somu",RP_Tok_notas$nota_limpia)

#STIA
RP_Tok_notas$nota_limpia <- gsub("sindicato de trabajadores de la industria de la alimentación","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de trabajadores de industrias de la alimentación","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de trabajadores de industria de la alimentación","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de trabajadores de industrias de alimentación","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato trabajadores de industrias de la alimentación","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de trabajadores de la pesca y la alimentación","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de trabajadores de la industria alimentaria","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de trabajadores de la  alimentación","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de la industria de la alimentación","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de trabajadores de la alimentación","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de industria de la alimentación","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de la alimentación","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("stia \\(stia\\)","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("stia stia","stia",RP_Tok_notas$nota_limpia)

#SICONARA
RP_Tok_notas$nota_limpia <- gsub("sindicato de conductores navales de la república argentina","siconara",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de conductores navales","siconara",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de conductores","siconara",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("siconara \\(siconara\\)","siconara",RP_Tok_notas$nota_limpia)

#SUPA
RP_Tok_notas$nota_limpia <- gsub("sindicato único de trabajadores portuarios","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato unido de trabajadores portuarios","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato ùnico de portuarios argentinos","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato unido de portuarios argentinos","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato único de portuarios argentinos","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato único de portuarios argentino","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato único de portuarios argentino","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato unidos portuarios argentinos","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato que nuclea a los estibadores","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato unido portuarios argentina","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de trabajadores portuarios","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de los estibadores","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato unido portuarios","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de estibadores","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de la estiba","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("supa \\(supa\\)","supa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("supa supa","supa",RP_Tok_notas$nota_limpia)

#SUTAP
RP_Tok_notas$nota_limpia <- gsub("sindicato único de trabajadores de administraciones portuarias","sutap",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sutap \\(sutap\\)","sutap",RP_Tok_notas$nota_limpia)

#SAON
RP_Tok_notas$nota_limpia <- gsub("saosinra, el sindicato que reúne a la mayoría de obreros navales del país,","saon",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato argentino de obreros navales","saon",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato obrero de la industria naval","saon",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de obreros navales","saon",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato naval","saon",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("saonsinra","saon",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("saon \\(saon\\)","saon",RP_Tok_notas$nota_limpia)

#SANAM
RP_Tok_notas$nota_limpia <- gsub("sindicato de la actividad naval","sanam",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sanam \\(sanam\\)","sanam",RP_Tok_notas$nota_limpia)

#SUPARA
RP_Tok_notas$nota_limpia <- gsub("sindicato único del personal aduanero de la república argentina","supara",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato único de aduaneros de la república argentina","supara",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato único del personal de la aduana","supara",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato único del personal aduanero","supara",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato los trabajadores de aduana","supara",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("supara \\(supara\\)","supara",RP_Tok_notas$nota_limpia)

#SEC
RP_Tok_notas$nota_limpia <- gsub("sindicato de empleados de comercio zona atlántica","sec",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de empleados de comercio","sec",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato empleado de comercio","sec",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de comercio","sec",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sec \\(sec\\)","sec",RP_Tok_notas$nota_limpia)

#SUTCA
RP_Tok_notas$nota_limpia <- gsub("sindicato unidos trabajadores custodios argentinos","sutca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato que agrupa a los vigiladores","sutca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de vigiladores","sutca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sutca \\(sutca\\)","sutca",RP_Tok_notas$nota_limpia)

#STM
RP_Tok_notas$nota_limpia <- gsub("sindicato de trabajadores municipales","stm",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("stm \\(stm\\)","stm",RP_Tok_notas$nota_limpia)

#SCC
RP_Tok_notas$nota_limpia <- gsub("sindicato de camioneros","scc",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de choferes de camiones","scc",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("scc \\(scc\\)","scc",RP_Tok_notas$nota_limpia)

#SIPEDYB
RP_Tok_notas$nota_limpia <- gsub("sindicato que agrupa al personal de dragado y balizamiento","sipedyb",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato del personal de dragado y balizamiento","sipedyb",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de personal de dragado y balizamiento","sipedyb",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato del personal de dragas y balizamiento","sipedyb",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de personal de dragas y balizamiento","sipedyb",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de dragado y balizamiento","sipedyb",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sipedyb \\(sipedyb\\)","sipedyb",RP_Tok_notas$nota_limpia)

#SPP
RP_Tok_notas$nota_limpia <- gsub("sindicato de petroleros","spp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato petrolero","spp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("spp \\(spp\\)","spp",RP_Tok_notas$nota_limpia)

#UTHGRA
RP_Tok_notas$nota_limpia <- gsub("sindicato de gastronómicos","uthgra",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("uthgra \\(uthgra\\)","uthgra",RP_Tok_notas$nota_limpia)

#STIHMPRA
RP_Tok_notas$nota_limpia <- gsub("sindicato de trabajadores de la industria del hielo y de mercados particulares de la república argentina","stihmpra",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato del hielo","stihmpra",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("stihmpra \\(stihmpra\\)","stihmpra",RP_Tok_notas$nota_limpia)

#SPT
RP_Tok_notas$nota_limpia <- gsub("sindicato de peones de taxi","spt",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("spt \\(spt\\)","spt",RP_Tok_notas$nota_limpia)

#SG
RP_Tok_notas$nota_limpia <- gsub("sindicato de guardavidas","sg",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sg \\(sg\\)","sg",RP_Tok_notas$nota_limpia)

#UF
RP_Tok_notas$nota_limpia <- gsub("sindicato unión ferroviaria","uf",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("unión ferroviaria","uf",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("uf \\(uf\\)","uf",RP_Tok_notas$nota_limpia)

#SGYMGMRA
RP_Tok_notas$nota_limpia <- gsub("sindicato de guincheros y maquinistas de grúas móviles de la república argentina","sgymgmra",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de guincheros","sgymgmra",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sgymgmra \\(sgymgmra\\)","sgymgmra",RP_Tok_notas$nota_limpia)

#UOCRA
RP_Tok_notas$nota_limpia <- gsub("sindicato de obreros de la construcción","uocra",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato nacional de la industria de construcción","uocra",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("uocra \\(uocra\\)","uocra",RP_Tok_notas$nota_limpia)

#SADOP
RP_Tok_notas$nota_limpia <- gsub("sindicato de docentes privados","sadop",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sadop \\(sadop\\)","sadop",RP_Tok_notas$nota_limpia)

#SUDEPPU
RP_Tok_notas$nota_limpia <- gsub("sindicato único de patrones de pesca del uruguay","sudeppu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sudeppu \\(sudeppu\\)","sudeppu",RP_Tok_notas$nota_limpia)

#SPP
RP_Tok_notas$nota_limpia <- gsub("sociedad de patrones pescadores","spp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sociedad de patrones","spp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("spp \\(spp\\)","spp",RP_Tok_notas$nota_limpia)

#AACPYPP
RP_Tok_notas$nota_limpia <- gsub("asociación argentina de capitanes","aacpypp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("asociacion argentina de capitanes","aacpypp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("asociación de capitanes","aacpypp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("asociacion de capitanes","aacpypp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("aacpypp \\(aacpypp\\)","aacpypp",RP_Tok_notas$nota_limpia)

#CCUYOMM
RP_Tok_notas$nota_limpia <- gsub("centro de capitanes de ultramar y oficiales de la marina mercante","ccuyomm",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("centro de capitanes de ultramar","ccuyomm",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("ccuyomm \\(ccuyomm\\)","ccuyomm",RP_Tok_notas$nota_limpia)

#FRASES
RP_Tok_notas$nota_limpia <- gsub("la medida de fuerza que mantiene el sindicato de marineros","la medida de fuerza que mantiene el somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("el delegado de rawson del sindicato de marineros","el delegado de rawson del somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("capeca y capip con el sindicato de los marineros","capeca y capip con el somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("puerto madryn del sindicato de los marineros","puerto madryn del somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("el sindicato de marineros que conduce pablo trueba","el simape que conduce pablo trueba",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("la nueva conducción del sindicato de marineros","la nueva conducción del somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("desde el sindicato de marineros sostienen que","desde el somu sostienen que",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("la pretensión del sindicato de los marineros es que el valor","la pretensión del somu es que el valor",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("fue el sindicato de pablo trueba el que realizó","fue el simape de pablo trueba el que realizó",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("la renovación de autoridades del sindicato de los marineros","la renovación de autoridades del somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("la intervención nacional del sindicato de los marineros","la intervención nacional del somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato que nuclea la mayor cantidad de trabajadores en tierra de la industria pesquera en mar del plata","soip que nuclea la mayor cantidad de trabajadores en tierra de la industria pesquera en mar del plata",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("las removidas autoridades del sindicato de los marineros","las removidas autoridades del somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("lideró por años el sindicato de los obreros marítimos","lideró por años el somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("secretario general del sindicato de marineros","secretario general del simape",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("en cada seccional del país del sindicato de los marineros","en cada seccional del país del somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("al frente del sindicato de los marineros","al frente del somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("retener la conducción del sindicato de la marinería","retener la conducción del somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de los trabajadores de planta en tierra","stia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("ser parte de negociaciones paritarias que el sindicato de la marinería","ser parte de negociaciones paritarias que el somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato de a trabajadores petroleros","spp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("el sindicato de la marinería sostiene que","el somu sostiene que",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("dentro del poderoso sindicato de la marinería","dentro del poderoso somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("conducción nacional del sindicato de la marinería","conducción nacional del somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("el líder del sindicato de los marineros","el líder del somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("través del sindicato de marineros","través del somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("los fondos surgían del sindicato de obreros marítimos","los fondos surgían del somu",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("referentes del sipedyb, el sindicato del personal de dragas y balizamiento","referentes del sipedyb",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato que nuclea a los marineros recurrió en primera instancia","somu que nuclea a los marineros recurrió en primera instancia",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("el sindicato de los marítimos plantea primero","el somu plantea primero",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("el pedido del sindicato de los marineros es elevarlo","el pedido del somu es elevarlo",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("el sindicato de los marineros cedió en parte al aceptar","el somu cedió en parte al aceptar",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("el sindicato liderado por juan domingo novero","el simape liderado por juan domingo novero",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("sindicato que representa al personal de la administración portuaria de puerto madryn","sutap de puerto madryn",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("los sindicatos de marineros y conductores navales","el simape, el somu y el siconara",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("lejos quedaron aquellas manifestaciones del sindicato de la pesca","lejos quedaron aquellas manifestaciones del stia",RP_Tok_notas$nota_limpia)

## entidades_empresariales
#CAFACH
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de la flota amarilla del chubut","cafach",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de la flota amarilla de chubut","cafach",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores solicitó al gobierno de chubut","cafach solicitó al gobierno de chubut",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de la flota amarrilla de chubut","cafach",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de buques fresqueros de chubut","cafach",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de la flota amarilla de chubut","cafach",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de la flota amarilla","cafach",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cafach \\(cafach\\)","cafach",RP_Tok_notas$nota_limpia)

#CAPEC
RP_Tok_notas$nota_limpia <- gsub("cámara de empresas procesadoras de pescado del chubut","capec",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de empresas pesqueras de chubut","capec",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara pesquera de chubut","capec",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("capec \\(capec\\)","capec",RP_Tok_notas$nota_limpia)

#CEPP
RP_Tok_notas$nota_limpia <- gsub("cámara de empresas pesqueras y procesadoras de comodoro_rivadavia","cepp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de plantas de procesamiento de comodoro_rivadavia","cepp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de plantas pesqueras de comodoro_rivadavia","cepp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara pesquera de comodoro_rivadavia","cepp",RP_Tok_notas$nota_limpia)

#CAPIP
RP_Tok_notas$nota_limpia <- gsub("cámara argentino patagónica de industrias pesqueras","capip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara argentina patagónica de industrias pesqueras","capip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara argentina patagónica de industria pesquera","capip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("capip – capip","capip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("capip –capip–","capip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("capip \\(capip\\)","capip",RP_Tok_notas$nota_limpia)

#CAPECA
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de pesqueros y congeladores de argentina- cape. ca.","capeca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de buques pesqueros congeladores de argentina","capeca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de pesqueros y congeladores de la argentina","capeca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de pesqueros congeladores de la argentina","capeca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores pesqueros congeladores de la argentina","capeca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores pesqueros congeladores de argentina","capeca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores pesqueros congeladores argentinos","capeca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de pesqueros congeladores de la argentina","capeca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de pesqueros y congeladores","capeca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de pesqueros congeladores de argentina","capeca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de pesqueros congeladores","capeca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de congeladores","capeca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("capeca \\(capeca\\)","capeca",RP_Tok_notas$nota_limpia)

#CAPA
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de poteros de argentina","capa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de poteros argentinos","capa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara que agrupa a las empresas poteras","capa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores poteros argentinos","capa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("camara de armadores poteros argentinos","capa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de poteros","capa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores poteros","capa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de poteros","capa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("capa \\(capa\\)","capa",RP_Tok_notas$nota_limpia)

#CAFREXPORT
RP_Tok_notas$nota_limpia <- gsub("cafrexport, la cámara de los frigoríficos exportadores","cafrexport",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de frigoríficos exportadores de la pesca","cafrexport",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de frigoríficos exportadores","cafrexport",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de fresqueros (cafresport)","cafrexport",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cafrexport \\(cafrexpoort\\)","cafrexport",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cafrexport \\(cafrexport\\)","cafrexport",RP_Tok_notas$nota_limpia)

#CAIPA
RP_Tok_notas$nota_limpia <- gsub("cámara de la industria de procesadores de pescado","caipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara argentina de industriales de la pesca","caipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de la industria pesquera argentina","caipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara argentina de la industria pesquera","caipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de industria pesquera argentina","caipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de los industriales del pescado","caipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de la industriales del pescado","caipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de industriales de la pesca","caipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de la industria del pescado","caipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de industriales del pescado","caipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("caipa \\(caipa\\)","caipa",RP_Tok_notas$nota_limpia)

#CESYA
RP_Tok_notas$nota_limpia <- gsub("cámara de estibajes, servicios y afines de la actividad portuaria","cesya",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de empresas de servicio de estibaje","cesya",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de las empresas de estiba","cesya",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de estibaje y afines","cesya",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de estibaje","cesya",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cesya \\(cesya\\)","cesya",RP_Tok_notas$nota_limpia)

#CESP
RP_Tok_notas$nota_limpia <- gsub("cámara de empresas de servicios portuarios","cesp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de empresas de servicios portuarios y afines","cesp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de servicios portuarios","cesp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cesp \\(cesp\\)","cesp",RP_Tok_notas$nota_limpia)

#CFFH
RP_Tok_notas$nota_limpia <- gsub("cámara de frigoríficos y fábricas del hielo","cffh",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cffh \\(cffh\\)","cffh",RP_Tok_notas$nota_limpia)

#CEPPGSJ
RP_Tok_notas$nota_limpia <- gsub("cámara de empresas pesqueras y procesadoras del golfo san jorge","ceppgsj",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("ceppgsj \\(ceppgsj\\)","ceppgsj",RP_Tok_notas$nota_limpia)

#CACYAGL
RP_Tok_notas$nota_limpia <- gsub("cámara de barcos costeros y afines de lavalle","cacyagl",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de general lavalle","cacyagl",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cacyagl \\(cacyagl\\)","cacyagl",RP_Tok_notas$nota_limpia)

#CELTA
RP_Tok_notas$nota_limpia <- gsub("cámara de empresarios logística transporte automotor","celta",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de empresarios del transporte","celta",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("celta \\(celta\\)","celta",RP_Tok_notas$nota_limpia)

#CESYA
RP_Tok_notas$nota_limpia <- gsub("cámara de empresas de seguridad de la provincia de buenos_aires","caesba",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("caesba \\(caesba\\)","caesba",RP_Tok_notas$nota_limpia)

#APAPR
RP_Tok_notas$nota_limpia <- gsub("cámara de pescadores artesanales de rawson","apapr",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de la flota costera","apapr",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de la flota artesanal de rawson","apapr",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de artesanales de rawson","apapr",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de costeros de rawson","apapr",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("apapr \\(apapr\\)","apapr",RP_Tok_notas$nota_limpia)

#CALAPRAC
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de lanchas de prácticos","calaprac",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("calaprac \\(calaprac\\)","calaprac",RP_Tok_notas$nota_limpia)

#CAMAD
RP_Tok_notas$nota_limpia <- gsub("cámara de industria, comercio y producción de puerto_madryn","camad",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de comercio, industria y producción de puerto_madryn","camad",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de industria y comercio de puerto_madryn","camad",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("camad \\(camad\\)","camad",RP_Tok_notas$nota_limpia)

#CINMDP
RP_Tok_notas$nota_limpia <- gsub("cámara de la industria naval de la ciudad","cina de mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de la industria naval de mdp","cina de mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de la industria naval local","cina de mdp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de la industria naval mdp","cina de mdp",RP_Tok_notas$nota_limpia)

#CINMDP
RP_Tok_notas$nota_limpia <- gsub("cámara de la industria naval argentina","cina",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de la industria naval","cina",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cina \\(cina\\)","cina",RP_Tok_notas$nota_limpia)

#CAPCRYR
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de buques de rada o ría","capcryr",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de barcos de rada o ría","capcryr",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de rada o ría","capcryr",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("capcryr \\(capcryr\\)","capcryr",RP_Tok_notas$nota_limpia)

#CEPA
RP_Tok_notas$nota_limpia <- gsub("consejo de empresas pesqueras argentinas","cepa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cepa \\(cepa\\)","cepa",RP_Tok_notas$nota_limpia)

#UCIP
RP_Tok_notas$nota_limpia <- gsub("unión del comercio, la industria y la producción","ucip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("unión de comercio la industria y la producción","ucip",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("ucip \\(ucip\\)","ucip",RP_Tok_notas$nota_limpia)

#CNP
RP_Tok_notas$nota_limpia <- gsub("consenso nacional pesquero","cnp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cnp \\(cnp\\)","cnp",RP_Tok_notas$nota_limpia)

#UDIPA
RP_Tok_notas$nota_limpia <- gsub("unión de intereses pesqueros argentinos","udipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("unión de industriales de la pesca","udipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("udipa \\(udipa\\)","udipa",RP_Tok_notas$nota_limpia)

#CAENA
RP_Tok_notas$nota_limpia <- gsub("cámara argentina de empresas navieras y armadoras","caena",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("caena \\(caena\\)","caena",RP_Tok_notas$nota_limpia)

#CARBA
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de bandera argentina","carba",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("carba \\(carba\\)","carba",RP_Tok_notas$nota_limpia)

#CNA
RP_Tok_notas$nota_limpia <- gsub("cámara naviera argentina","cna",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cna \\(cna\\)","cna",RP_Tok_notas$nota_limpia)

## gobierno
#CFP
RP_Tok_notas$nota_limpia <- gsub("consejo federal portuario","cfp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("consejo federal pesquero","cfp",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cfp \\(cfp\\)","cfp",RP_Tok_notas$nota_limpia)

#INIDEP
RP_Tok_notas$nota_limpia <- gsub("instituto nacional de investigación y desarrollo pesquero","inidep",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("inidep \\(inidep\\)","inidep",RP_Tok_notas$nota_limpia)

#APPM
RP_Tok_notas$nota_limpia <- gsub("administración portuaria de puerto_madryn","appm",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("appm \\(appm\\)","appm",RP_Tok_notas$nota_limpia)

#CCAP
RP_Tok_notas$nota_limpia <- gsub("cámara comercial argentina del pescado","ccap",RP_Tok_notas$nota_limpia)

#CAABPA
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de buques fresqueros de altura","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de buques pesqueros de altura","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de barcos pesqueros de altura","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de buques pesquero de altura","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de fresqueros y de caipa","caabpa y de caipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de buques fresqueros","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de buques pesqueros","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de buques de altura","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de buques fresqueros de altura","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de buques pesqueros de altura","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de los fresqueros de altura","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores pesqueros","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores navieros","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("darío sócrate \\(armadores\\)","caabpa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("caabpa \\(caabpa\\)","caabpa",RP_Tok_notas$nota_limpia)

## asociaciones_empresariales
#AEPC
RP_Tok_notas$nota_limpia <- gsub("asociación de embarcaciones de pesca costera","aepc",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de embarcaciones de pesca costera","aepc",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("asociación de embarcaciones costeras","aepc",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("asociación de pesca costera","aepc",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("asociación pesca costera","aepc",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cepa y de la flota costera","cepa y aepc",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("caipa, costeros y udipa","caipa, aepc y udipa",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("caabpa y costeros","caabpa y aepc",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("aepc \\(aepc\\)","aepc",RP_Tok_notas$nota_limpia)

#ABIN
RP_Tok_notas$nota_limpia <- gsub("asociación bonaerense de la industria naval","abin",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("abin \\(abin\\)","abin",RP_Tok_notas$nota_limpia)

#Agrupaciones
RP_Tok_notas$nota_limpia <- gsub("agrupación de marineros de santa_cruz","amsc",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("ningúnhundimientomás","ningunhundimientomas",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("ningúnhundimientomas","ningunhundimientomas",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("ningunhundimientomás","ningunhundimientomas",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("niunhundimientomas","ningunhundimientomas",RP_Tok_notas$nota_limpia)

## errores
#ERRORES_TIPEO
RP_Tok_notas$nota_limpia <- gsub("reformulacionesconsultado","reformulaciones. consultado",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("espantadosinicialmente","espantados. inicialmente",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cicconedefinitivamente","ciccone. definitivamente",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("definitivosfinalmente","definitivos. finalmente",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cedenteconcluyéndose","cedente, concluyéndose",RP_Tok_notas$nota_limpia)

#DETALLES
RP_Tok_notas$nota_limpia <- gsub(" sa;",";",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("unión europea","unión_europea",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de vigo","cámara_armadores_vigo",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de armadores de bahía_blanca","cámara_armadores_bahía_blanca",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara de diputados","cámara_diputados",RP_Tok_notas$nota_limpia)
RP_Tok_notas$nota_limpia <- gsub("cámara federal","cámara_federal",RP_Tok_notas$nota_limpia)

#########--------búsqueda

#stringr::str_view_all(RP_Tok_notas$nota_limpia, "Deseado")
#stringr::str_view_all(RP_Tok_notas$nota, "Deseado")

#glimpse(RP_Tok_notas[2538,6])

#str(RP_Tok_notas[139, ]$nota_limpia, nchar.max = 10000)

#str_view_all(RP_Tok_notas[403, ]$nota_limpia, " paró")

#RP_Tok_notas[570, ]$nota_limpia

########-----Guardar---------##########

saveRDS(RP_Tok_notas, "RP_notas_normalizadas_2020.rds")

# Normalizar datos fechas y eliminar duplicaciones --------------------------------------------------------

#notas_rev_puerto <- notas_rev_puerto %>% mutate(nota_minuscula = str_to_lower(nota))

#stringr::str_view_all(RP_Tok_notas$nota_limpia, "Deseado")

#Tipo_conflictos
Dicc_Conflic <- read.csv2("../MineriaDatos/lexicos/dicc_conflic_acciones.csv", stringsAsFactors = F)
string_conflic <- as_vector(Dicc_Conflic$palabra)

#puertos_y_provincias
Dicc_localidad <- readxl::read_xlsx("../MineriaDatos/lexicos/dicc_puertos.xlsx")
string_localidad <- as_vector(Dicc_localidad$ciudad_puerto)

#org_y_motivos
Dicc_org_mot <- readxl::read_xlsx("../MineriaDatos/lexicos/dicc_org_mot.xlsx")
string_org_mot <- as_vector(Dicc_org_mot$termino)

#str_conflic
string_conflictos <- Dicc_Conflic %>% select(1) %>% as_vector()
string_ataques <- Dicc_Conflic %>% filter(nominacion_agrup == "ataques"|nominacion_agrup == "enfrentamientos") %>% select(1) %>% as_vector()
string_bloqueos <- Dicc_Conflic %>% filter(nominacion_agrup == "bloqueos") %>% select(1) %>% as_vector()
string_concil_obl <- Dicc_Conflic %>% filter(nominacion_agrup == "concil_obl") %>% select(1) %>% as_vector()
string_cortes <- Dicc_Conflic %>% filter(nominacion_agrup == "cortes") %>% select(1) %>% as_vector()
string_represion <- Dicc_Conflic %>% filter(nominacion_agrup == "desalojos"|nominacion_agrup == "represiones") %>% select(1) %>% as_vector()
string_huelga <- Dicc_Conflic %>% filter(nominacion_agrup == "huelgas") %>% select(1) %>% as_vector()
string_manif_call <- Dicc_Conflic %>% filter(nominacion_agrup == "manif_call") %>% select(1) %>% as_vector()
string_ocupaciones <- Dicc_Conflic %>% filter(nominacion_agrup == "ocupaciones") %>% select(1) %>% as_vector()
string_reun_e_par <- Dicc_Conflic %>% filter(nominacion_agrup == "reun_par"|nominacion_agrup == "reuniones") %>% select(1) %>% as_vector()
string_protestas <- Dicc_Conflic %>% filter(nominacion_agrup == "protestas"|nominacion_agrup == "motines"|nominacion_agrup == "rebeliones"|nominacion_agrup == "revueltas") %>% select(1) %>% as_vector()
string_comunicacionales <- Dicc_Conflic %>% filter(nominacion_agrup == "anuncios"|nominacion_agrup == "est_alertas"|nominacion_agrup == "comunicados"|nominacion_agrup == "amenazas"|nominacion_agrup == "petición"|nominacion_agrup == "denuncias") %>% select(1) %>% as_vector()
string_otros_conflic <- Dicc_Conflic %>% filter(nominacion_agrup == "boicots"|nominacion_agrup == "carnereadas"|nominacion_agrup == "sabotajes") %>% select(1) %>% as_vector()
#string_enfrentamientos <- Dicc_Conflic %>% filter(nominacion_agrup == "enfrentamientos") %>% select(1) %>% as_vector()
#string_denuncias <- Dicc_Conflic %>% filter(nominacion_agrup == "denuncias") %>% select(1) %>% as_vector()


##str_puertos
string_bsas <- Dicc_localidad %>% filter(region == "Bs_As") %>% select(1) %>% as_vector()
string_patagonia <- Dicc_localidad %>% filter(region == "Patagonia") %>% select(1) %>% as_vector()
string_chubut <- Dicc_localidad %>% filter(provincia == "Chubut") %>% select(1) %>% as_vector()
string_rio_negro <- Dicc_localidad %>% filter(provincia == "Río Negro") %>% select(1) %>% as_vector()
string_tierra_del_fuego <- Dicc_localidad %>% filter(provincia == "Tierra del Fuego") %>% select(1) %>% as_vector()
string_santa_cruz <- Dicc_localidad %>% filter(provincia == "Santa Cruz") %>% select(1) %>% as_vector()

##str_motivos
string_salarial <- Dicc_org_mot %>% filter(nom == "salarios") %>% select(1) %>% as_vector()
string_laboral <- Dicc_org_mot %>% filter(nom == "registración_laboral") %>% select(1) %>% as_vector()
string_despidos <- Dicc_org_mot %>% filter(nom == "despidos"|nom == "crisis") %>% select(1) %>% as_vector()
string_otros <- Dicc_org_mot %>% filter(nom == "gremial" | nom == "convenio") %>% select(1) %>% as_vector()

RP_Tok_notas$nota_sin_punct <- gsub("[[:punct:]]"," ",RP_Tok_notas$nota_limpia)

RP_Tok_notas_Conflictos <- RP_Tok_notas %>% 
  mutate(caracteres = str_count(nota_sin_punct, pattern = ""),
         palabras = sapply(strsplit(nota_sin_punct, " "), length),
         palabras_conflictivas = str_count(nota_sin_punct, paste(string_conflictos, collapse = "|")),
         #apartado tipos de conflictos
         ataques = str_count(nota_sin_punct, paste(string_ataques, collapse = "|")),
         bloqueos = str_count(nota_sin_punct, paste(string_bloqueos, collapse = "|")),
         concil_obl = str_count(nota_sin_punct, paste(string_concil_obl, collapse = "|")),
         cortes = str_count(nota_sin_punct, paste(string_cortes, collapse = "|")),
         huelga = str_count(nota_sin_punct, paste(string_huelga, collapse = "|")),
         manif_call = str_count(nota_sin_punct, paste(string_manif_call, collapse = "|")),
         ocupaciones = str_count(nota_sin_punct, paste(string_ocupaciones, collapse = "|")),
         reun_e_par = str_count(nota_sin_punct, paste(string_reun_e_par, collapse = "|")),
         represion = str_count(nota_sin_punct, paste(string_represion, collapse = "|")),
         protestas = str_count(nota_sin_punct, paste(string_protestas, collapse = "|")),
         comunicacionales = str_count(nota_sin_punct, paste(string_comunicacionales, collapse = "|")),
         otros_conf = str_count(nota_sin_punct, paste(string_otros_conflic, collapse = "|")),
         #denuncias = str_count(nota_sin_punct, paste(string_denuncias, collapse = "|")),
         #desalojos = str_count(nota_sin_punct, paste(string_desalojos, collapse = "|")),
         ##
         #enfrentamientos = str_count(nota_sin_punct, paste(string_enfrentamientos, collapse = "|")),
         #ataques = ifelse(str_detect(nota_sin_punct, paste(stringP, collapse = "|")), 1, 0),
         #bloqueos = ifelse(str_detect(nota_sin_punct, paste(stringP, collapse = "|")), 1, 0),
         #concil_obl = ifelse(str_detect(nota_sin_punct, paste(stringP, collapse = "|")), 1, 0),
         #cortes = ifelse(str_detect(nota_sin_punct, paste(stringP, collapse = "|")), 1, 0),
         #denuncias = ifelse(str_detect(nota_sin_punct, paste(stringP, collapse = "|")), 1, 0),
         #desalojos = ifelse(str_detect(nota_sin_punct, paste(stringP, collapse = "|")), 1, 0),
         #enfrentamientos = ifelse(str_detect(nota_sin_punct, paste(stringP, collapse = "|")), 1, 0),
         #huelga = ifelse(str_detect(nota_sin_punct, paste(stringP, collapse = "|")), 1, 0),
         #manif_call = ifelse(str_detect(nota_sin_punct, paste(stringP, collapse = "|")), 1, 0),
         #ocupaciones = ifelse(str_detect(nota_sin_punct, paste(stringP, collapse = "|")), 1, 0),
         #reun_e_par = ifelse(str_detect(nota_sin_punct, paste(stringP, collapse = "|")), 1, 0),
         #apartado puertos y regiones 
         patagonia = str_count(nota_sin_punct, paste(string_patagonia, collapse = "|")),
         bsas = str_count(nota_sin_punct, paste(string_bsas, collapse = "|")),
         santa_cruz = str_count(nota_sin_punct, paste(string_santa_cruz, collapse = "|")),
         tierra_del_fuego = str_count(nota_sin_punct, paste(string_tierra_del_fuego, collapse = "|")),
         chubut = str_count(nota_sin_punct, paste(string_chubut, collapse = "|")),
         rio_negro = str_count(nota_sin_punct, paste(string_rio_negro, collapse = "|")),
         #apartado org
         soip = str_count(nota_sin_punct, "soip"),
         simape = str_count(nota_sin_punct, "simape"),
         somu = str_count(nota_sin_punct, "somu"),
         stia = str_count(nota_sin_punct, "stia"),
         supa = str_count(nota_sin_punct, "supa"),
         saon = str_count(nota_sin_punct, "saon"),
         #apartado motivos
         salarial = str_count(nota_sin_punct, paste(string_salarial, collapse = "|")),
         laboral = str_count(nota_sin_punct, paste(string_laboral, collapse = "|")),
         despidos = str_count(nota_sin_punct, paste(string_despidos, collapse = "|")),
         otros_mot = str_count(nota_sin_punct, paste(string_otros, collapse = "|")),
         #cierre intensidad conflc
         notas_c_s_conf = ifelse(str_detect(nota_sin_punct, paste(string_conflictos, collapse = "|")), "NCC", "NSC"),
         grup_frec = as.factor(case_when(palabras_conflictivas == 0 ~ "Sin conflicto",
                                         palabras_conflictivas == 1 ~ "Sin conflicto",
                                         palabras_conflictivas == 2 ~ "Muy baja",
                                         palabras_conflictivas == 3 ~ "Baja",
                                         palabras_conflictivas %in% 4:6 ~ "Media",
                                         palabras_conflictivas %in% 7:10 ~ "Alta",
                                         palabras_conflictivas > 10 ~ "Muy alta")))

RP_Tok_notas_Conflictos$grup_frec <- factor(RP_Tok_notas_Conflictos$grup_frec, levels = levels(RP_Tok_notas_Conflictos$grup_frec)[ c( 6,5,2,3,1,4)])

#RP_Tok_notas_Conflictos$fecha <- date(dmy(RP_Tok_notas_Conflictos$fecha))

RP_Tok_notas_Conflictos <- RP_Tok_notas_Conflictos %>% 
  mutate(patagonia_bsas = patagonia - bsas)

RP_Tok_notas_Conflictos <- RP_Tok_notas_Conflictos %>% 
  mutate(regiones = case_when(
    patagonia_bsas > 0 ~ "Patagónicos",
    patagonia_bsas < 0 ~ "Bonaerenses",
    soip > 0 ~ "Bonaerenses",
    simape > 0 ~ "Bonaerenses"))

RP_Tok_notas_Conflictos <- RP_Tok_notas_Conflictos %>% 
  mutate(regiones = case_when(is.na(regiones) ~ "s_d",
                              TRUE ~ as.character(regiones)))

RP_Tok_notas_Conflictos <- RP_Tok_notas_Conflictos %>% 
  mutate(provincias = case_when(
    patagonia_bsas < 0 ~ "Buenos Aires",
    soip > 0 ~ "Buenos Aires",
    simape > 0 ~ "Buenos Aires",
    chubut > 0 ~ "Chubut",
    rio_negro > 0 ~ "Río Negro",
    tierra_del_fuego > 0 ~ "Tierra del Fuego",
    santa_cruz > 0 ~ "Santa Cruz"
  ))

RP_Tok_notas_Conflictos <- RP_Tok_notas_Conflictos %>% 
  mutate(provincias = case_when(is.na(provincias) ~ "s_d",
                                TRUE ~ as.character(provincias)))

RP_Tok_notas_Conflictos <- RP_Tok_notas_Conflictos %>% 
  mutate(notas_c_s_conf2 = case_when(palabras_conflictivas == 0 ~ "NSC",
                                     palabras_conflictivas == 1 ~ "NSC",
                                     palabras_conflictivas > 1 ~ "NCC"))

RP_Tok_notas_Conflictos <- RP_Tok_notas_Conflictos %>% 
  mutate(indice_palabras_conflic = (palabras_conflictivas/palabras)*100)

RP_Tok_notas_Conflictos$indice_palabras_conflic <- round(RP_Tok_notas_Conflictos$indice_palabras_conflic, 2)

tabla <- RP_Tok_notas_Conflictos %>% 
  count(indice_palabras_conflic)

RP_Tok_notas_Conflictos <- RP_Tok_notas_Conflictos %>% 
  mutate(intensidad = as.factor(case_when(indice_palabras_conflic == 0.00 ~ "Sin conflicto",
                                          between(indice_palabras_conflic, 0.01,0.20) ~ "Sin conflicto",
                                          between(indice_palabras_conflic, 0.21,0.35) ~ "Muy baja",
                                          between(indice_palabras_conflic, 0.36,0.55) ~ "Baja",
                                          between(indice_palabras_conflic, 0.56,0.90) ~ "Media",
                                          between(indice_palabras_conflic, 0.91,1.50) ~ "Alta",
                                          indice_palabras_conflic > 1.50 ~ "Muy alta")))

RP_Tok_notas_Conflictos$intensidad <- factor( RP_Tok_notas_Conflictos$intensidad, levels = levels(RP_Tok_notas_Conflictos$intensidad)[ c( 6,5,2,3,1,4)])

RP_Tok_notas_Conflictos %>% 
  filter(!is.na(intensidad)) %>% 
  count(intensidad)

RP_Tok_notas_Conflictos %>% 
  count(grup_frec)

#saveRDS(RP_Tok_notas_Conflictos, "./data/RP_notas_conflic_2020.rds")

#RP_Tok_notas_Conflictos <- readRDS("./data/RP_notas_conflic_2020.rds")

RP_Tok_notas_Conflictos %>% count(grup_frec)

RP_Tok_notas_Conflictos %>% 
  summarise(sum(huelga)+sum(concil_obl))

###GRAF0
RP_Tok_notas_Conflictos %>% 
  group_by(year(fecha)) %>% 
  filter(palabras_conflictivas > 2) %>% 
  summarise(sum(palabras_conflictivas)) %>%
  rename(años = `year(fecha)`,
         conflictos = `sum(palabras_conflictivas)`) %>% 
  gather(Tipo_acciones, frec, -años) %>%
  mutate(total_notas = c(634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581)) %>% 
  filter(años != 2020) %>% 
  #summarise(sum(frec)) #6269
  ggplot(aes(años, frec/total_notas)) +
  geom_xspline(aes(colour = Tipo_acciones), size=2) +
  scale_color_manual(values=c("#ff396f","#396fff")) +
  scale_x_continuous(breaks = c(2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019), expand = c(0,0.2)) +
  scale_y_continuous(breaks = c(0,1,2), labels = c(0,1,2), limits = c(0,2.1), expand = c(0,0)) +
  theme_elegante() + 
  theme(legend.position = c(0.8, 0.8),
        legend.title = element_blank())  +
  theme(axis.text.x = element_text(vjust = 0.5)) +
  labs(title = 'Figura III',
       subtitle = 'Conflictividad portuaria durante el periodo 2009-2012',
       caption = 'nº de palabras indizadas = 6269
       Fuentes: Elaboración propia en base a datos de la Revista Puerto',
       y = 'Índice de conflictividad', x = NULL)

###GRAF1

#fff <- RP_Tok_notas_Conflictos %>% 
# group_by(year(fecha)) %>% count(`year(fecha)`)
#fff$n

RP_Tok_notas_Conflictos %>% 
  group_by(year(fecha)) %>%
  filter(palabras_conflictivas > 2) %>% 
  summarise(sum(huelga),
            sum(bloqueos),
            sum(ocupaciones),
            sum(reun_e_par),
            sum(cortes),
            sum(concil_obl),
            sum(manif_call),
            sum(ataques),
            sum(represion),
            sum(comunicacionales),
            sum(protestas),
            sum(otros_conf),
  ) %>%
  rename(años = `year(fecha)`,
         huelgas = `sum(huelga)`,
         cortes = `sum(cortes)`,
         conciliaciones = `sum(concil_obl)`,
         manifestaciones = `sum(manif_call)`,
         ataques = `sum(ataques)`,
         bloqueos = `sum(bloqueos)`,
         ocupaciones = `sum(ocupaciones)`,
         reun_e_par = `sum(reun_e_par)`,
         represiones = `sum(represion)`,
         protestas = `sum(protestas)`,
         otras = `sum(otros_conf)`
  ) %>% 
  gather(Tipo_acciones, frec, -años) %>%
  filter(Tipo_acciones == "huelgas"|Tipo_acciones == "conciliaciones") %>% 
  mutate(Tipo_acciones = as.factor(Tipo_acciones)) %>% 
  mutate(Tipo_acciones = factor(Tipo_acciones, levels = c("huelgas", "conciliaciones"))) %>% 
  mutate(total_notas = c(634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581)) %>% 
  filter(años != 2020) %>% 
  #filter(Tipo_acciones != 'huelgas') %>% summarise(sum(frec))
  ggplot(aes(años, (frec/total_notas)*1)) +
  geom_xspline(aes(colour = Tipo_acciones), size=2) +
  scale_color_manual(values=c("#ff396f","#396fff")) +
  scale_x_continuous(breaks = c(2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019), expand = c(0,0.2)) +
  scale_y_continuous(breaks = c(.0,.1,.2,.3,.4), labels = c(.0,.1,.2,.3,.4), limits = c(.0,.5), expand = c(0,0)) +
  theme_elegante() + 
  theme(legend.position = c(0.8, 0.8),
        legend.title = element_blank())  +
  theme(axis.text.x = element_text(vjust = 0.5)) +
  labs(title = 'Figura IV',
       subtitle = 'Movimientos huelguísticos portuarios 2009-2019',
       caption = 'nº de palabras indizadas = 1270
       Fuentes: Elaboración propia en base a datos de la Revista Puerto',
       y = 'Índice de conflictividad', x = NULL)

###GRAF2
RP_Tok_notas_Conflictos %>% 
  group_by(year(fecha)) %>% 
  filter(palabras_conflictivas > 2) %>% 
  summarise(sum(huelga),
            sum(bloqueos),
            sum(ocupaciones),
            sum(reun_e_par),
            sum(cortes),
            sum(concil_obl),
            sum(manif_call),
            sum(ataques),
            sum(represion),
            sum(comunicacionales),
            sum(protestas),
            sum(otros_conf)) %>%
  rename(años = `year(fecha)`,
         huelgas = `sum(huelga)`,
         cortes = `sum(cortes)`,
         conciliaciones = `sum(concil_obl)`,
         manifestaciones = `sum(manif_call)`,
         ataques = `sum(ataques)`,
         bloqueos = `sum(bloqueos)`,
         ocupaciones = `sum(ocupaciones)`,
         reuniones = `sum(reun_e_par)`,
         represiones = `sum(represion)`,
         protestas = `sum(protestas)`,
         comunicacionales = `sum(comunicacionales)`,
         otras = `sum(otros_conf)`) %>% 
  gather(Tipo_acciones, frec, -años) %>%
  mutate(total_notas = c(634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,
                         634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,
                         634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,
                         634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,
                         634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,
                         634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581)) %>% 
  filter(años != 2020) %>% 
  #summarise(sum(frec))
  #filter(Tipo_acciones != "otras") %>% #5593
  ggplot(aes(años, frec/total_notas)) +
  geom_xspline(aes(colour = Tipo_acciones), size=2) +
  scale_x_continuous(breaks = c(2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019)) +
  facet_wrap(~ Tipo_acciones, scales = "free") +
  theme_elegante() + 
  theme(strip.text = element_text(face="bold"),
        axis.text.x = element_text(size=rel(.8)),
        axis.text.y = element_text(size=rel(.8)),
        legend.position = "none")  +
  theme(axis.text.x = element_text(angle=90, vjust = 0.5)) +
  labs(title = 'Figura V',
       subtitle = 'Conflictividad laboral en los puertos pesqueros argentinos según tipo de acciones 2009-2019',
       caption = 'nº de palabras indizadas = 6279
       Fuentes: Elaboración propia en base a datos de la Revista Puerto',
       y = 'Índice de conflictividad', x = NULL)

#NOTA: hacer dos más desagregados por region - BsAs / Patag.

#GRAF3
(figura_4_a <- RP_Tok_notas_Conflictos %>% 
    group_by(year(fecha)) %>% 
    filter(palabras_conflictivas > 2) %>% 
    summarise(sum(patagonia),
              sum(bsas)) %>%
    rename(años = `year(fecha)`,
           Patagónicos = `sum(patagonia)`,
           Bonaerenses = `sum(bsas)`) %>% 
    gather(Puertos, frec, -años) %>%
    mutate(total_notas = c(634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581)) %>% 
    filter(años != 2020) %>% 
    #summarise(sum(frec))# 1779
    #filter(Tipo_acciones != "otras") %>% 
    ggplot(aes(años, frec/total_notas)) +
    geom_xspline(aes(colour = Puertos), size=2) +
    scale_x_continuous(breaks = c(2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019),
                       labels = c('09','10','11','12','13','14','15','16','17','18','19')) +
    facet_wrap(~ Puertos, scales = "free") +
    theme_elegante() + 
    theme(strip.text = element_text(face="bold"),
          legend.position = "none")  +
    theme(axis.text.x = element_text(vjust = 0.5)) +
    labs(title = 'Figura VI',
         subtitle = 'Conflictividad laboral en los puertos pesqueros argentinos según localización 2009-2019', y = NULL, x = NULL))

(figura_4_b <- RP_Tok_notas_Conflictos %>% 
    group_by(year(fecha)) %>% 
    filter(palabras_conflictivas > 2) %>% 
    summarise(sum(patagonia),
              sum(bsas)) %>%
    rename(años = `year(fecha)`,
           Patagónicos = `sum(patagonia)`,
           Bonaerenses = `sum(bsas)`) %>% 
    gather(Puertos, frec, -años) %>%
    mutate(total_notas = c(634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581)) %>% 
    filter(años != 2020) %>% 
    #summarise(sum(frec))# 1779
    #filter(Tipo_acciones != "otras") %>% 
    ggplot(aes(años, frec/total_notas)) +
    geom_xspline(aes(colour = Puertos), size=2) +
    scale_x_continuous(breaks = c(2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019)) +
    theme_elegante() + 
    theme(strip.text = element_text(face="bold"),
          legend.position = c(0.8, 0.8))  +
    theme(axis.text.x = element_text(vjust = 0.5)) +
    labs(caption = 'nº de palabras indizadas = 4041
       Fuentes: Elaboración propia en base a datos de la Revista Puerto',
       y = NULL, x = NULL))

library(patchwork)
figura_4_a /
  figura_4_b

#GRAF4
RP_Tok_notas_Conflictos %>% 
  filter(palabras_conflictivas > 2) %>% 
  filter(regiones != "s_d") %>%
  group_by(year(fecha), regiones) %>% 
  summarise(sum(palabras_conflictivas)) %>% 
  ggplot(aes(`year(fecha)`, `sum(palabras_conflictivas)`)) +
  geom_xspline(aes(colour = regiones), size=2) +
  scale_x_continuous(breaks = c(2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019)) +
  facet_wrap(~ regiones, scales = "free") +
  theme_minimal() + 
  theme(text = element_text(face="bold", size = 18, color = "black"),
        axis.text.x = element_text(colour="black", size=rel(1)),
        axis.text.y = element_text(face="bold", colour="black", size=rel(1)),
        legend.position = "none")  +
  theme(axis.text.x = element_text(angle=90, vjust = 0.5)) +
  theme(plot.margin = margin(0.5, 3, 0.5, 0.5, "cm")) +
  labs(title = 'Conflictividad laboral en los puertos pesqueros argentinos 2009-2019',
       subtitle = 'Frecuencia anual de palabras relativas a conflictos según puertos pesqueros',
       caption = 'n = 4366
       Fuentes: Elaboración propia en base a datos de la Revista Puerto',
       y = 'Índice de conflictividad', x = '', 
       face = "bold")

RP_Tok_notas_Conflictos %>% 
  filter(palabras_conflictivas > 2) %>% 
  filter(regiones != "s_d") %>% 
  group_by(year(fecha)) %>% 
  summarise(sum(palabras_conflictivas)) %>% 
  summarise(sum(`sum(palabras_conflictivas)`))


#GRAF5 
RP_Tok_notas_Conflictos %>% 
  group_by(year(fecha)) %>% 
  filter(palabras_conflictivas > 2) %>% 
  #filter(patagonia > 1) %>% 
  #filter(bsas > 1) %>% 
  summarise(sum(soip),
            sum(simape),
            sum(somu),
            sum(stia),
            sum(supa),
            sum(saon)) %>%
  rename(años = `year(fecha)`,
         SOIP = `sum(soip)`,
         SIMAPE = `sum(simape)`,
         SOMU = `sum(somu)`,
         STIA = `sum(stia)`,
         SUPA = `sum(supa)`,
         SAON = `sum(saon)`) %>% 
  gather(Sindicatos, frec, -años)  %>% 
  mutate(total_notas = c(634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,
                         634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,
                         634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581)) %>% 
  filter(años != 2020) %>% 
  #summarise(sum(frec))# 3110
  ggplot(aes(años, frec/total_notas)) +
  geom_xspline(aes(colour = Sindicatos), size=2) +
  scale_x_continuous(breaks = c(2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019)) +
  facet_wrap(~ Sindicatos, scales = "free") +
  theme_elegante() + 
  theme(strip.text = element_text(face="bold"), legend.position = "none")  +
  theme(axis.text.x = element_text(angle=90, vjust = 0.5)) +
  labs(title = 'Figura VIII',
       subtitle = 'Conflictividad laboral en los puertos pesqueros argentinos según sindicatos 2009-2019',
       caption = 'nº de palabras indizadas = 3807
       Fuentes: Elaboración propia en base a datos de la Revista Puerto',
       y = 'Índice de conflictividad', x = NULL, 
       face = "bold")

###GRAF6
(fig_7_a <- RP_Tok_notas_Conflictos %>% 
    group_by(year(fecha)) %>% 
    filter(palabras_conflictivas > 2) %>% 
    summarise(sum(salarial),
              sum(laboral),
              sum(despidos),
              sum(otros_mot)) %>%
    rename(años = `year(fecha)`,
           salarial = `sum(salarial)`,
           laboral = `sum(laboral)`,
           'crisis y despidos' = `sum(despidos)`,
           otros = `sum(otros_mot)`) %>% 
    gather(Tipo_acciones, frec, -años) %>%
    mutate(total_notas = c(634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,
                           634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581)) %>% 
    filter(años != 2020) %>% 
    #summarise(sum(frec)) 
    ggplot(aes(años, frec/total_notas)) +
    geom_xspline(aes(colour = Tipo_acciones), size=2) +
    scale_x_continuous(breaks = c(2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019),
                       labels = c('09','10','11','12','13','14','15','16','17','18','19')) +
    facet_wrap(~ Tipo_acciones, scales = "free", ncol = 4) +
    theme_elegante() + 
    theme(strip.text = element_text(face="bold"),
          legend.position = "none")  +
    theme(axis.text.x = element_text(angle=90, vjust = 0.5)) +
    labs(title = 'Figura IX',
         subtitle = 'Conflictividad laboral en los puertos pesqueros argentinos según motivos de la acción 2009-2019',
         y = NULL, x = NULL))

(fig_7_b <- RP_Tok_notas_Conflictos %>% 
    group_by(year(fecha)) %>% 
    filter(palabras_conflictivas > 2) %>% 
    summarise(sum(salarial),
              sum(laboral),
              sum(despidos),
              sum(otros_mot)) %>%
    rename(años = `year(fecha)`,
           salarial = `sum(salarial)`,
           laboral = `sum(laboral)`,
           'crisis y despidos' = `sum(despidos)`,
           otros = `sum(otros_mot)`) %>% 
    gather(Tipo_acciones, frec, -años) %>%
    mutate(total_notas = c(634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,
                           634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581,634, 682, 596, 735, 686, 630, 620, 675, 637, 639, 637, 581)) %>% 
    filter(años != 2020) %>% 
    #summarise(sum(frec)) 
    ggplot(aes(años, frec/total_notas)) +
    geom_xspline(aes(colour = Tipo_acciones), size=2) +
    scale_x_continuous(breaks = c(2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019)) +
    theme_elegante() + 
    theme(legend.position = c(0.8,0.8))  +
    theme(axis.text.x = element_text(vjust = 0.5)) +
    labs(caption = 'nº de palabras indizadas = 4097
       Fuentes: Elaboración propia en base a datos de la Revista Puerto',
       y = NULL, x = NULL))
library(patchwork)
fig_7_a /
  fig_7_b

#MAPA1
require(sf)
require(ggspatial)
require(tidyverse)

#provincias <- read_sf("C:/Users/agust/Box Sync/R/PROYECTOS/GeoQGISconR/shapes/provincias_latlong.shp")
provincias <- read_sf("C:/Users/agusn/Google Drive/R/PROYECTOS/GeoQGISconR/shapes/provincias_latlong.shp")
st_crs(provincias) <- 4326

(provinciasN <- provincias$NOMBRE)
provincias <- provincias %>% 
  mutate(NOMBRE = case_when(NOMBRE == "Rio Negro" ~ "Río Negro",
                            TRUE ~ as.character(NOMBRE)))

prov_pesqueras <- provincias %>% 
  filter(FIRST_MIN1 == 6|FIRST_MIN1 == 26|FIRST_MIN1 == 62|FIRST_MIN1 == 78|FIRST_MIN1 == 94)

(prov_pes <- prov_pesqueras$NOMBRE)

ggplot(data=prov_pesqueras) + 
  geom_sf(fill="white")

provincias2 <- read_sf("./shapes/provincia.shp")#pxpciadatosok
st_crs(provincias) <- 4326
(provinciasN2 <- provincias2$nam)
prov_pesqueras2 <- provincias2 %>% 
  filter(gid == 21|gid == 20|gid == 19|gid == 18|gid == 17)
(prov_pes2 <- prov_pesqueras2$nam)

(d <- RP_Tok_notas_Conflictos %>% 
    filter(palabras_conflictivas > 2) %>% 
    filter(provincias != "s_d") %>%
    group_by(provincias, year(fecha)) %>% 
    summarise(sum(palabras_conflictivas)) %>% 
    rename(años = `year(fecha)`,
           índice = `sum(palabras_conflictivas)`) %>% 
    full_join(prov_pesqueras, by = c("provincias" = "NOMBRE")))

d[31:37,]

pobla_prov <- tibble(
  NOMBRE = prov_pesqueras$NOMBRE,
  poblacion = c(618989, 81315, 21643, 14183, 74752),
  desembarques = c(471264.3, 158192.4, 14009.2, 138166.9, 15.8) # año 2013
)

RP_Tok_notas_Conflictos %>% 
  filter(palabras_conflictivas > 2) %>% 
  filter(provincias != "s_d") %>%
  group_by(provincias, year(fecha)) %>% 
  summarise(sum(palabras_conflictivas)) %>% 
  rename(años = `year(fecha)`,
         índice = `sum(palabras_conflictivas)`) %>% 
  full_join(prov_pesqueras, by = c("provincias" = "NOMBRE")) %>% 
  full_join(pobla_prov, by = c("provincias" = "NOMBRE")) %>% 
  st_as_sf() %>% 
  ggplot() + 
  geom_sf(data = provincias) +
  geom_sf(fill="white", data=prov_pesqueras) +
  geom_sf(aes(fill = índice)) + 
  geom_sf_label(aes(label = índice), size = 8.5) +
  scale_fill_gradient2(low = "white" , mid = "#396fff", high = "#ff396f") +
  #annotation_scale(location = "tl") +
  #annotation_north_arrow(location = "br", which_north = "true") +
  annotation_scale(location = "bl", width_hint = 0.2, height = unit(0.4, "cm"), 
                   text_pad = unit(0.15, "cm"),
                   text_cex = 1.7,#size km
                   tick_height = 0.6) +
  annotation_north_arrow(height = unit(3.0, "cm"), width = unit(3.0, "cm"),
                         location = "br", which_north = "true", 
                         #pad_x = unit(1.5, "in"), pad_y = unit(0.30, "in"),
                         style = north_arrow_fancy_orienteering) +
  coord_sf(xlim = c(-75.0, -54.0), ylim = c(-56.0, -33.0), expand = F) +
  facet_wrap(~ años,
             nrow = 2) +
  labs(title = "Figura X",
       subtitle = "Distribución socioterritorial de la conflictividad en los puertos pesqueros (2009-2019)",
       x = " ", y = " ") +
  theme_elegante() +
  theme(#text = element_text(size = 34, color = "grey30"),
    legend.position = c(0.93, 0.24),
    legend.title = element_text(colour = "grey30", size = 32),
    legend.text = element_text(colour = "grey30", size = 30),
    legend.key = element_blank(),
    legend.key.size = unit(2.5, "cm"),
    legend.key.width = unit(2.5,"cm"),
    axis.text.x = element_text(face="bold", colour="grey30", size=rel(0.8)),
    axis.text.y = element_text(face="bold", colour="grey30", size=rel(0.8)),
    panel.spacing = unit(3, "lines"),
    #legend.position = "bottom"
  )


#MAP2
(map2 <- RP_Tok_notas_Conflictos %>% 
    filter(palabras_conflictivas > 2) %>% 
    filter(provincias != "s_d") %>%
    group_by(provincias, year(fecha)) %>% 
    summarise(sum(palabras_conflictivas)) %>% 
    rename(años = `year(fecha)`,
           índice = `sum(palabras_conflictivas)`) %>% 
    full_join(prov_pesqueras, by = c("provincias" = "NOMBRE")) %>% 
    full_join(pobla_prov, by = c("provincias" = "NOMBRE")) %>% 
    st_as_sf() %>% 
    filter(años != "2012" & años != "2020") %>% 
    mutate(índice_2 = índice) %>% 
    ggplot() + 
    geom_sf(data = provincias) +
    geom_sf(fill="white", data=prov_pesqueras) +
    geom_sf(aes(fill = índice_2)) + 
    geom_sf_label(aes(label = índice_2), size = 4.0, alpha = 0.8) +
    scale_fill_gradient2(low = "white" , mid = "#396fff", high = "#ff396f") +
    #annotation_scale(location = "tl") +
    #annotation_north_arrow(location = "br", which_north = "true") +
    annotation_scale(location = "bl", width_hint = 0.2, height = unit(0.3, "cm"), 
                     text_pad = unit(0.2, "cm"),
                     text_cex = 0.95,#size km
                     tick_height = 0.6) +
    annotation_north_arrow(height = unit(1, "cm"), width = unit(1, "cm"),
                           location = "br", which_north = "true", 
                           #pad_x = unit(1.5, "in"), pad_y = unit(0.30, "in"),
                           style = north_arrow_fancy_orienteering) +
    coord_sf(xlim = c(-75.0, -54.0), ylim = c(-57.0, -33.0), expand = F) +
    facet_wrap(~ años,
               nrow = 2) +
    labs(title = "Figura VII",
         subtitle = "Distribución socioterritorial de la conflictividad en los puertos pesqueros (2009-2019)",
         caption = "Quitamos el año 2012 por su excepcionalidad",
         x = NULL, y = NULL) +
    theme_elegante() +
    theme(strip.text = element_text(face="bold"),
          axis.text.x = element_text(angle = 90, size=rel(0.9)),
          axis.text.y = element_text(size=rel(0.9)),
          panel.spacing = unit(2, "lines"),
          legend.title = element_text(colour = "grey30", size = 12, vjust = 0.5),
          legend.text = element_text(colour = "grey30", size = 10),
          legend.key = element_blank(),
          legend.key.width = unit(0.2,"cm"),
          legend.key.height = unit(0.3,"cm"),
          legend.position = c(0.97, 0.75)
    ))

###OTRA_COSA###########################

pais <- read_sf("./shapes/pxpciadatosok.shp")

head(provincias, 2)

ggplot(pais) + 
  geom_sf(aes(fill = link))

pais$geometry[24]


RP_Tok_notas_Conflictos %>% count(grup_frec) %>% ggplot()+
  geom_bar(aes(x=grup_frec, y=n), stat = "identity")

RP_Tok_notas_Conflictos %>% group_by(grup_frec) %>% summarise(sum(palabras_conflictivas)) %>% ggplot()+
  geom_bar(aes(x=grup_frec, y=`sum(palabras_conflictivas)`), stat = "identity")


tabla_conf <- RP_Tok_notas_Conflictos %>% arrange(desc(palabras_conflictivas)) %>% filter(palabras_conflictivas > 1)

tabla_conf %>% arrange(desc(palabras_conflictivas)) %>%  
  mutate(año = lubridate:: year(fecha)) %>% group_by(año) %>% summarise(sum(palabras_conflictivas)) %>% 
  rename(freq = `sum(palabras_conflictivas)`) %>% 
  ggplot() +
  geom_bar(aes(x = as.factor(año), y = freq), stat = "identity")

tabla_conf %>% arrange(desc(palabras_conflictivas)) %>%  
  mutate(año = lubridate::year(fecha)) %>% group_by(año) %>% summarise(sum(palabras_conflictivas)) %>% 
  rename(freq = `sum(palabras_conflictivas)`) %>% 
  ggplot() +
  geom_line(aes(x = as.factor(año), y = freq), group = 1)

tabla_conf %>% arrange(desc(palabras_conflictivas)) %>% 
  mutate(año = lubridate:: year(fecha)) %>% group_by(año) %>% summarise(sum(palabras_conflictivas)) %>% 
  rename(freq = `sum(palabras_conflictivas)`) %>% 
  ggplot() +
  geom_bar(aes(x = as.factor(año), y = freq), stat = "identity")

tabla_conf %>% arrange(desc(palabras_conflictivas)) %>%  
  mutate(año = lubridate:: year(fecha)) %>% group_by(año) %>% summarise(sum(palabras_conflictivas)) %>% 
  rename(freq = `sum(palabras_conflictivas)`) %>% 
  ggplot() +
  geom_line(aes(x = as.factor(año), y = freq), group = 1)

tabla_conf %>% arrange(desc(palabras_conflictivas)) %>%
  mutate(año = lubridate:: year(fecha)) %>% group_by(año) %>% summarise(sum(palabras_conflictivas)) %>% 
  rename(freq = `sum(palabras_conflictivas)`) %>% 
  ggplot() +
  geom_bar(aes(x = as.factor(año), y = freq), stat = "identity") +
  geom_line(aes(x = as.factor(año), y = freq), size=3, colour= "red", group = 1)


tabla_conf %>% count(palabras_conflictivas)


#### idf

library(dplyr)
library(tidytext)

RP_words <- RP_Tok_notas_Conflictos %>%
  mutate(anio = year(fecha)) %>% 
  #filter(anio != "2020") %>% 
  unnest_tokens(word, titulo) %>%
  count(anio, word, sort = TRUE) %>% 
  filter(!word %in% tm::stopwords(kind = 'es')) %>% 
  filter(!word %in% c('js','d','id','fjs')) %>% 
  filter(!str_detect(word, "[[:digit:]]")) %>% 
  filter(!word %in% c('puerto','pesca','año','twitter','garrone','nahum','wis','widgets','createelement',
                      'document','getelementbyid','insertbefore','parentnode','platform','script','src',
                      'wjs','twittear','function','segui','var','com')) %>% 
  filter(nchar(word) > 2 & !nchar(word) > 19)

total_words <- RP_words %>% 
  group_by(anio) %>% 
  summarize(total = sum(n))

RP_words <- left_join(RP_words, total_words)

RP_words

library(ggplot2)

ggplot(RP_words, aes(n/total, fill = as.factor(anio))) +
  geom_histogram(show.legend = FALSE) +
  xlim(NA, 0.0009) +
  facet_wrap(~anio, ncol = 4, scales = "free_y")

freq_by_rank <- RP_words %>% 
  group_by(anio) %>% 
  mutate(rank = row_number(), 
         `term frequency` = n/total) %>%
  ungroup()

freq_by_rank %>% 
  ggplot(aes(rank, `term frequency`, color = as.factor(anio))) + 
  geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) + 
  scale_x_log10() +
  scale_y_log10()

rank_subset <- freq_by_rank %>% 
  filter(rank < 500,
         rank > 10)

lm(log10(`term frequency`) ~ log10(rank), data = rank_subset)

freq_by_rank %>% 
  ggplot(aes(rank, `term frequency`, color = as.factor(anio))) + 
  geom_abline(intercept = -0.62, slope = -1.1, 
              color = "gray50", linetype = 2) +
  geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) + 
  scale_x_log10() +
  scale_y_log10()

RP_tf_idf <- RP_words %>%
  bind_tf_idf(word, anio, n)

RP_tf_idf

RP_tf_idf %>%
  select(-total) %>%
  arrange(desc(tf_idf))

library(forcats)

RP_tf_idf %>%
  #summarise(sum(n))
  group_by(anio) %>%
  slice_max(tf_idf, n = 11) %>%
  ungroup() %>%
  ggplot(aes(tf_idf, fct_reorder(word, tf_idf), fill = as.factor(anio))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~anio, ncol = 6, scales = "free") +
  labs(title = 'Figura XI',
       subtitle = 'Tópicos por año según la métrica tf-idf (frecuencia de término - frecuencia inversa de documento)',
       caption = 'nº de palabras indizadas = 37800
       Fuentes: Elaboración propia en base a datos de la Revista Puerto (todas las notas)',
       x = NULL, y = NULL) +
  theme_elegante() +
  theme(strip.text = element_text(face="bold"),
        axis.text.x = element_text(angle = 90, size=rel(0.7)),
        axis.text.y = element_text(size=rel(0.7)),
        panel.spacing = unit(0.5, "lines"),
        legend.title = element_text(colour = "grey30", size = 12, vjust = 0.5),
        legend.text = element_text(colour = "grey30", size = 10)
  )

#### idf 2

library(dplyr)
library(tidytext)

RP_words <- RP_Tok_notas_Conflictos %>%
  mutate(anio = year(fecha)) %>% 
  filter(palabras_conflictivas > 2) %>%
  #filter(anio != "2020") %>% 
  unnest_tokens(word, titulo) %>%
  count(anio, word, sort = TRUE) %>% 
  filter(!word %in% tm::stopwords(kind = 'es')) %>% 
  filter(!word %in% c('js','d','id','fjs')) %>% 
  filter(!str_detect(word, "[[:digit:]]")) %>% 
  filter(!word %in% c('puerto','pesca','año','twitter','garrone','nahum','wis','widgets','createelement',
                      'document','getelementbyid','insertbefore','parentnode','platform','script','src',
                      'wjs','twittear','function','segui','var','com')) %>% 
  filter(nchar(word) > 2 & !nchar(word) > 19)

total_words <- RP_words %>% 
  group_by(anio) %>% 
  summarize(total = sum(n))

RP_words <- left_join(RP_words, total_words)

RP_words

library(ggplot2)

ggplot(RP_words, aes(n/total, fill = as.factor(anio))) +
  geom_histogram(show.legend = FALSE) +
  xlim(NA, 0.0009) +
  facet_wrap(~anio, ncol = 4, scales = "free_y")

freq_by_rank <- RP_words %>% 
  group_by(anio) %>% 
  mutate(rank = row_number(), 
         `term frequency` = n/total) %>%
  ungroup()

freq_by_rank %>% 
  ggplot(aes(rank, `term frequency`, color = as.factor(anio))) + 
  geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) + 
  scale_x_log10() +
  scale_y_log10()

rank_subset <- freq_by_rank %>% 
  filter(rank < 500,
         rank > 10)

lm(log10(`term frequency`) ~ log10(rank), data = rank_subset)

freq_by_rank %>% 
  ggplot(aes(rank, `term frequency`, color = as.factor(anio))) + 
  geom_abline(intercept = -0.62, slope = -1.1, 
              color = "gray50", linetype = 2) +
  geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) + 
  scale_x_log10() +
  scale_y_log10()

RP_tf_idf <- RP_words %>%
  bind_tf_idf(word, anio, n)

RP_tf_idf

RP_tf_idf %>%
  select(-total) %>%
  arrange(desc(tf_idf))

library(forcats)

RP_tf_idf %>%
  #summarise(sum(n))
  group_by(anio) %>%
  slice_max(tf_idf, n = 11) %>%
  ungroup() %>%
  ggplot(aes(tf_idf, fct_reorder(word, tf_idf), fill = as.factor(anio))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~anio, ncol = 6, scales = "free") +
  labs(title = 'Figura XII',
       subtitle = 'Tópicos por año según la métrica tf-idf (frecuencia de término - frecuencia inversa de documento)',
       caption = 'nº de palabras indizadas = 5933
       Fuentes: Elaboración propia en base a datos de la Revista Puerto (solo notas referidas a conflictos)',
       x = NULL, y = NULL) +
  theme_elegante() +
  theme(strip.text = element_text(face="bold"),
        axis.text.x = element_text(angle = 90, size=rel(0.7)),
        axis.text.y = element_text(size=rel(0.7)),
        panel.spacing = unit(0.5, "lines"),
        legend.title = element_text(colour = "grey30", size = 12, vjust = 0.5),
        legend.text = element_text(colour = "grey30", size = 10)
  )

require(dplyr)
require(gganimate)
require(ggplot2)
require(ggraph)
require(igraph)
require(lubridate)
require(readxl)
require(scales)
require(stringr)
require(tm)
require(tidyr)
require(tidytext)
require(tidyverse)
require(widyr) 
require(zoo)

RP_bigram <- RP_Tok_notas_Conflictos %>%
  filter(year(fecha) == '2012') %>% 
  filter(palabras_conflictivas > 2) %>% 
  unnest_tokens(bigram, nota_limpia, token = "ngrams", n = 2)

RP_bigram <- RP_bigram %>% 
  mutate(año = year(fecha))

#str_view_all(readRDS("./data/RP_notas_conflic_nuevo.rds")$nota_sin_punct, "no")

RP_bigram %>%
  count(bigram, sort = TRUE)

bigrams_separated <- RP_bigram %>%
  separate(bigram, c("palabra1", "palabra2"), sep = " ")

bigrams_filtered <- bigrams_separated %>%
  filter(!palabra1 %in% read_xlsx("./lexicos/stopwords_es.xlsx")$palabra) %>%
  filter(!palabra2 %in% read_xlsx("./lexicos/stopwords_es.xlsx")$palabra) %>% 
  filter(!palabra1 %in% c('js','d','id','fjs')) %>% 
  filter(!palabra2 %in% c('diego','izquierdo','fernández','fotos')) %>% 
  filter(!str_detect(palabra1, "[[:digit:]]")) %>% 
  filter(!palabra1 %in% c('puerto','pesca','año','twitter','garrone','nahum','wis','widgets','createelement',
                          'document','getelementbyid','insertbefore','parentnode','platform','script','src',
                          'wjs','twittear','function','segui','var','com')) %>% 
  filter(nchar(palabra1) > 2 & !nchar(palabra1) > 19) %>% 
  filter(!palabra2 %in% c('js','d','id','fjs')) %>% 
  filter(!palabra2 %in% c('diego','izquierdo','fernández','fotos')) %>% 
  filter(!str_detect(palabra2, "[[:digit:]]")) %>% 
  filter(!palabra2 %in% c('puerto','pesca','año','twitter','garrone','nahum','wis','widgets','createelement',
                          'document','getelementbyid','insertbefore','parentnode','platform','script','src',
                          'wjs','twittear','function','segui','var','com')) %>% 
  filter(nchar(palabra2) > 2 & !nchar(palabra2) > 19)

# nuevo bigram counts:
bigram_counts <- bigrams_filtered %>%
  group_by(año) %>% 
  count(palabra1, palabra2, sort = TRUE)

bigram_counts

bigrams_united <- 
  bigrams_filtered %>%
  unite(bigram, palabra1, palabra2, sep = " ")

bigrams_united

bigram_tf_idf <- bigrams_united %>%
  count(titulo, bigram) %>%
  bind_tf_idf(bigram, titulo, n) %>%
  arrange(desc(tf_idf))

bigram_tf_idf


# original counts
bigram_counts

# filter for only relatively common combinations
bigram_graph <- bigram_counts %>% as.data.frame() %>% as_tibble() %>% 
  select(2,3,4) %>% 
  filter(n > 11) %>%
  graph_from_data_frame()

bigram_graph

set.seed(2016)

a <- grid::arrow(type = "closed", length = unit(.09, "inches"))

ggraph(bigram_graph, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                 arrow = a, end_cap = circle(.07, 'inches')) +
  geom_node_point(color = "lightblue", size = 3) +
  geom_node_text(aes(label = name), vjust = 0, hjust = 0, size = 4, repel = T, segment.color = NA) +
  labs(title = 'Figura XIII',
       subtitle = 'Red de bigramas para las noticias del año 2012 referidas a conflictos',
       caption = 'Fuentes: Elaboración propia en base a datos de la Revista Puerto',
       x = NULL, y = NULL) +
  scale_x_discrete(breaks = NULL) +
  scale_y_discrete(breaks = NULL) +
  theme_elegante()

# Thema_nuevo -------------------------------------------------------------

library(extrafont)
# for windows
windowsFonts(sans="Raleway")
loadfonts(device="win")
loadfonts(device="postscript")

theme_elegante <- function(base_size = 16)
{
  color.background = "#FFFFFF" # Chart Background
  color.grid.major = "#D9D9D9" # Chart Gridlines
  color.axis.text = "#666666" # 
  color.axis.title = "#666666" # 
  color.title = "#666666"
  color.subtitle = "#666666"
  strip.background.color = '#000000'
  
  ret <-
    theme_bw(base_size=base_size) +
    
    # Set the entire chart region to a light gray color
    theme(panel.background=element_rect(fill=color.background, color=color.background)) +
    theme(plot.background=element_rect(fill=color.background, color=color.background)) +
    theme(panel.border=element_rect(color=color.background)) +
    
    # Format the grid
    theme(panel.grid.major=element_line(color=color.grid.major,size=.55, linetype="dotted")) +
    theme(panel.grid.minor=element_line(color=color.grid.major,size=.55, linetype="dotted")) +
    theme(axis.ticks=element_blank()) +
    
    # Format the legend, but hide by default
    theme(legend.position="none") +
    theme(legend.background = element_rect(fill=color.background)) +
    theme(legend.text = element_text(size=base_size-3,color=color.axis.title)) +
    
    theme(strip.text.x = element_text(size=base_size,color=color.background)) +
    theme(strip.text.y = element_text(size=base_size,color=color.background)) +
    #theme(strip.background = element_rect(fill=strip.background.color, linetype="blank")) +
    theme(strip.background = element_rect(fill = "#735f5f", colour = NA)) +
    # theme(panel.border= element_rect(fill = NA, colour = "grey70", size = rel(1)))+
    # Set title and axis labels, and format these and tick marks
    theme(plot.title=element_text(color=color.title, 
                                  size=20, 
                                  vjust=1.25, 
                                  hjust = 0.5
    )) +
    
    theme(plot.subtitle=element_text(color=color.subtitle, size=base_size+2,  hjust = 0.5))  +
    
    theme(axis.text.x=element_text(size=base_size,color=color.axis.text)) +
    theme(axis.text.y=element_text(size=base_size,color=color.axis.text)) +
    theme(text=element_text(size=base_size, color=color.axis.text)) +
    
    theme(axis.title.x=element_text(size=base_size+2,color=color.axis.title, vjust=0)) +
    theme(axis.title.y=element_text(size=base_size+2,color=color.axis.title, vjust=1.25)) +
    theme(plot.caption=element_text(size=base_size-2,color=color.axis.title, vjust=1.25)) +
    
    # Legend  
    theme(legend.text=element_text(size=base_size,color=color.axis.text)) +
    theme(legend.title=element_text(size=base_size,color=color.axis.text)) +
    theme(legend.key=element_rect(colour = color.background, fill = color.background)) +
    theme(legend.position="bottom", 
          legend.box = "horizontal", 
          legend.title = element_blank(),
          legend.key.width = unit(.75, "cm"),
          legend.key.height = unit(.75, "cm"),
          legend.spacing.x = unit(.25, 'cm'),
          legend.spacing.y = unit(.25, 'cm'),
          legend.margin = margin(t=0, r=0, b=0, l=0, unit="cm")) +
    
    # Plot margins
    theme(plot.margin = unit(c(.5, .5, .5, .5), "cm"))
  
  ret
}

# Thema_nuevo_gris_oscuro -------------------------------------------------------------

library(extrafont)

# for windows
windowsFonts(sans="Raleway")
loadfonts(device="win")
loadfonts(device="postscript")

theme_elegante <- function(base_size = 16)
{
  color.background = "#FFFFFF" # Chart Background
  color.grid.major = "#D9D9D9" # Chart Gridlines
  color.axis.text = "grey30" # 
  color.axis.title = "grey30" # 
  color.title = "grey30"
  color.subtitle = "grey30"
  strip.background.color = '#000000'
  
  ret <-
    theme_bw(base_size=base_size) +
    
    # Set the entire chart region to a light gray color
    theme(panel.background=element_rect(fill=color.background, color=color.background)) +
    theme(plot.background=element_rect(fill=color.background, color=color.background)) +
    theme(panel.border=element_rect(color=color.background)) +
    
    # Format the grid
    theme(panel.grid.major=element_line(color=color.grid.major,size=.55, linetype="dotted")) +
    theme(panel.grid.minor=element_line(color=color.grid.major,size=.55, linetype="dotted")) +
    theme(axis.ticks=element_blank()) +
    
    # Format the legend, but hide by default
    theme(legend.position="none") +
    theme(legend.background = element_rect(fill=color.background)) +
    theme(legend.text = element_text(size=base_size-3,color=color.axis.title)) +
    
    theme(strip.text.x = element_text(size=base_size,color=color.background)) +
    theme(strip.text.y = element_text(size=base_size,color=color.background)) +
    #theme(strip.background = element_rect(fill=strip.background.color, linetype="blank")) +
    theme(strip.background = element_rect(fill = "#735f5f", colour = NA)) +
    # theme(panel.border= element_rect(fill = NA, colour = "grey70", size = rel(1)))+
    # Set title and axis labels, and format these and tick marks
    theme(plot.title=element_text(color=color.title, 
                                  size=20, 
                                  vjust=1.25, 
                                  hjust = 0.5
    )) +
    
    theme(plot.subtitle=element_text(color=color.subtitle, size=base_size+2,  hjust = 0.5))  +
    
    theme(axis.text.x=element_text(size=base_size,color=color.axis.text)) +
    theme(axis.text.y=element_text(size=base_size,color=color.axis.text)) +
    theme(text=element_text(size=base_size, color=color.axis.text)) +
    
    theme(axis.title.x=element_text(size=base_size+2,color=color.axis.title, vjust=0)) +
    theme(axis.title.y=element_text(size=base_size+2,color=color.axis.title, vjust=1.25)) +
    theme(plot.caption=element_text(size=base_size-2,color=color.axis.title, vjust=1.25)) +
    
    # Legend  
    theme(legend.text=element_text(size=base_size,color=color.axis.text)) +
    theme(legend.title=element_text(size=base_size,color=color.axis.text)) +
    theme(legend.key=element_rect(colour = color.background, fill = color.background)) +
    theme(legend.position="bottom", 
          legend.box = "horizontal", 
          legend.title = element_blank(),
          legend.key.width = unit(.75, "cm"),
          legend.key.height = unit(.75, "cm"),
          legend.spacing.x = unit(.25, 'cm'),
          legend.spacing.y = unit(.25, 'cm'),
          legend.margin = margin(t=0, r=0, b=0, l=0, unit="cm")) +
    
    # Plot margins
    theme(plot.margin = unit(c(.5, .5, .5, .5), "cm"))
  
  ret
}
