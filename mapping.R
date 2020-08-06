library(sf) #sf simple features standard https://r-spatial.github.io/sf/
library(tidyverse)

# Mapping example with heat data of LA
la_heat_income <- sf::read_sf(file.path("data", "los-angeles.geojson"))
kelvin2farenheit <- function(k) (9/5) * (k - 273) + 32

la_temp_map <- la_heat_income %>%
  mutate(temp = kelvin2farenheit(X_median)) %>%
  ggplot() +
  geom_sf(aes(fill = temp), color = "white", size = .2) +
  cowplot::theme_map() +
  theme(legend.position = c(.9, .2)) +
  scale_fill_viridis_c(option = "inferno")

la_temp_map
