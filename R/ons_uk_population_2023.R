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
#'
#' library(dplyr)
#' library(tidyr)
#'
#' # create a dataset that has total population by age groups for England
#' ons_uk_population_2023 |>
#'   filter(Name == "ENGLAND") |>
#'   mutate(age_group = case_when(
#'     as.numeric(age) <= 17 ~ "0-17",
#'     as.numeric(age) >= 18 & as.numeric(age) <= 64 ~ "18-64",
#'     as.numeric(age) >= 65 ~ "65+",
#'     age == "90+" ~ "65+"
#'   )) |>
#'   group_by(age_group) |>
#'   summarise(count = sum(count))
#'
"ons_uk_population_2023"
