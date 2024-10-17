#' ONS Mid-2023 Population Estimate for UK
#'
#' ONS Population Estimates for Mid-year 2023
#' National and subnational mid-year population estimates for the UK and its
#'  constituent countries by administrative area, age and sex (including
#'   components of population change, median age and population density).
#'
#' Data sourced from
#' \href{https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationestimatesforukenglandandwalesscotlandandnorthernireland}
#'
#' @docType data
#'
#' @keywords datasets ons population
#'
#' @format Tibble with six columns
#' \describe{
#' \item{sex}{male or female}
#' \item{Code}{The country/geography code}
#' \href{Name}{country of the UK}
#' \item{Geography}{Country}
#' \item{age}{year of age}
#' \item{count}{the number of people in this group}
#' }
#'
#' @source \href{https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationestimatesforukenglandandwalesscotlandandnorthernireland}{ONS Estimates of the population for the UK, England, Wales, Scotland, and Northern Ireland}
#'
#' @usage data(ons_uk_population_2023)
#'
#' @examples
#' data(ons_uk_population_2023)
#'
#' library(readxl)
#' library(tidyverse)
#' library(tidyr)

#' Load the data in
#' population_data_2023_f <- read_excel(
#' "mye23tablesuk.xlsx",
#'  sheet="MYE2 - Females",
#'  skip = 7)

#' population_data_2023_m <- read_excel(
#'  "mye23tablesuk.xlsx",
#'  sheet="MYE2 - Males",
#'  skip = 7)


#' pivot longer
#' population_data_2023_f <- population_data_2023_f |>
#'  select(!`All ages`) |>
#'  pivot_longer(`0`:`90+`, names_to = "age", values_to = "count")

#' population_data_2023_m <- population_data_2023_m |>
#'  select(!`All ages`) |>
#'  pivot_longer(`0`:`90+`, names_to = "age", values_to = "count")

#' population_data_combined <- bind_rows(
#'  females = population_data_2023_f,
#'  males = population_data_2023_m,
#'  .id = "sex"
#' )
#'
#'
#'
"ons_uk_population_2023"
