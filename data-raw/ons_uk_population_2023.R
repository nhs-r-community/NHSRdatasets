# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationestimatesforukenglandandwalesscotlandandnorthernireland

library(readxl)
library(tidyverse)
library(tidyr)

# Load the data in
population_data_2023_f <- read_excel(
  "mye23tablesuk.xlsx", # add full file path here before file name
  sheet = "MYE2 - Females",
  skip = 7
)

population_data_2023_m <- read_excel(
  "mye23tablesuk.xlsx", # add full file path here before file name
  sheet = "MYE2 - Males",
  skip = 7
)


# pivot longer
population_data_2023_f <- population_data_2023_f |>
  select(!`All ages`) |>
  pivot_longer(`0`:`90+`, names_to = "age", values_to = "count")

population_data_2023_m <- population_data_2023_m |>
  select(!`All ages`) |>
  pivot_longer(`0`:`90+`, names_to = "age", values_to = "count")

ons_uk_population_2023 <- bind_rows(
  females = population_data_2023_f,
  males = population_data_2023_m,
  .id = "sex"
)

usethis::use_data(ons_uk_population_2023, overwrite = TRUE)
