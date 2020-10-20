library(tidyverse)
library(rvest)

url <- "https://multco.us/elections/voter-turnout-november-2020-election"

page <- read_html(url)
table <- html_nodes(page, 'table')

data <- html_table(table) %>% data.frame()


