library(tidyverse)
library(sf)
library(osmdata)


city <- "Salem, Oregon, USA"

sidewalks <- opq(city) %>%
  add_osm_feature(key = "sidewalk", value = "(both|yes|no)", value_exact = FALSE) %>%
  osmdata_sf()

sidewalks$osm_lines$length <- st_length(sidewalks$osm_lines)
total_sidewalks <- sum(sidewalks$osm_lines$length)

footways <- opq(city) %>%
  add_osm_feature(key = "highway", value = "(footway|path)", value_exact = FALSE) %>%
  osmdata_sf()

footways$osm_lines$length <- st_length(footways$osm_lines)
total_footways <- sum(footways$osm_lines$length)

cycleways <- opq(city) %>%
  add_osm_feature(key = "highway", value = "cycleway") %>%
  osmdata_sf()

cycleways$osm_lines$length <- st_length(cycleways$osm_lines)
total_cycleways <- sum(cycleways$osm_lines$length)


roads <- opq(city) %>%
  add_osm_feature(key = "highway", value = "(primary|secondary|tertiary|residential|service)", value_exact = FALSE) %>%
  osmdata_sf()

roads$osm_lines$length <- st_length(roads$osm_lines)
total_roads <- sum(roads$osm_lines$length)

crossings <- opq(city) %>%
  add_osm_feature(key = "crossing") %>%
  osmdata_sf()

xings <- crossings$osm_points
xings$tactile_paving <- as_factor(xings$tactile_paving)

ggplot() +
  geom_sf(data = sidewalks$osm_lines) +
  geom_sf(data = xings, mapping=aes(color = tactile_paving))

total_sidewalks / total_roads
total_cycleways / total_roads
