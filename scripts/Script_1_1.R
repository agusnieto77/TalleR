require(tidyverse)
require(lubridate)
require(scales)

notas_norm <- readRDS(url("https://estudiosmaritimossociales.org/Data_TalleR/notas_norm.rds","rb"))

(tabla_piquetes <- notas_norm %>% 
  mutate(piquetes = str_count(nota_limpia, 'piquete|corte de ruta|corte de calle')) %>% 
    mutate(año = year(fecha)) %>% 
  filter(año < 2021) %>% 
  group_by(año) %>% 
  summarise(frec=sum(piquetes)))

ggplot(data=tabla_piquetes, aes(x=año,y=frec)) +
  geom_bar(stat = 'identity')

(tabla_paros <- notas_norm %>% 
    mutate(paros = str_count(nota_limpia, 'huelga|paro de |paro activo|paran los')) %>% 
    mutate(año = year(fecha)) %>% 
    filter(año < 2021) %>% 
    group_by(año) %>% 
    summarise(frec=sum(paros)))

ggplot(data=tabla_paros, aes(x=año,y=frec)) +
  geom_bar(stat = 'identity')

ggplot() +
  geom_line(data=tabla_paros, aes(x=año,y=frec), color='skyblue', size = 1.5) +
  geom_line(data=tabla_piquetes, aes(x=año,y=frec), color='violet', size = 1.5)

ggplot() +
  geom_line(data=tabla_paros, aes(x=año,y=scale(frec)), color='skyblue', size = 1.5) +
  geom_line(data=tabla_piquetes, aes(x=año,y=scale(frec)), color='violet', size = 1.5)
