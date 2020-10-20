library(tidyverse)
library(tidycensus)

census_api_key("627fdf979572cf1949ff00fbb6e69652558f65e1", install = TRUE)

get_acs(geography = "state", variables="B01003", year=2018)

v18 <- load_variables(2018, "acs5", cache=TRUE)

View(v18)

or <- get_acs(geography = "county",
              variables = c(pop = "B01001_001E"),
              state = "OR",
              year = 2018)


multco <- get_acs(geography = "tract",
              variables = c(pop = "B01001_001E"),
              county = 51,
              state = 41,
              year = 2018,
              geometry = TRUE)

View(multco)

multco %>%
  ggplot(aes(fill = estimate)) +
  geom_sf(color = NA) + 
  coord_sf(crs = 26910) +
  scale_fill_viridis_c(option = "magma")
