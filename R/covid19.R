#' International COVID-19 reported infection and death rates
#'
#' Reported COVID-19 infections, and deaths, collected and collated by the European Centre for Disease Prevention
#' and Control (ECDC). These are provided by day and country.
#' Data were collated and published up to 14th December 2020, and has been tidied to be easily usable within the tidyverse of packages.
#'
#' Data sourced from \href{https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide}{European Centre for Disease Prevention and Control}
#' which is available under the open licence, compatible with the  CC BY 4.0 license, further details available at \href{https://www.ecdc.europa.eu/en/copyright}{ECDC}.
#'
#' @docType data
#'
#' @keywords datasets covid coronavirus deaths countries
#'
#' @format Tibble with seven columns
#' \describe{
#' \item{date_reported}{The data cases were reported}
#' \item{contient}{A `factor` for the geographical continent in which the reporting country is located.}
#' \item{countries_and_territories}{A `factor` for the geographical continent in which the reporting country is located.}
#' \item{countries_territory_code}{A `factor` for the three-letter country or territory code.}
#' \item{population_2019}{The reported population of the country for 2019, taken from Eurostat for Europe and the World Bank for the rest of the world}
#' \item{cases}{The reported number of positive cases.}
#' \item{deaths}{The reported number of deaths.}
#' }
#'
#' @source \href{https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide}{European Centre for Disease Prevention and Control}
#'
#' @usage data(covid19)
#'
#' @examples
#' data(covid19)
#' library(dplyr)
#' library(ggplot2)
#' library(scales)
#'
#' # Create a plot of the performance for England over time
#' ae_attendances %>%
#'   group_by(period) %>%
#'   summarise_at(vars(attendances, breaches), sum) %>%
#'   mutate(performance = 1 - breaches / attendances) %>%
#'   ggplot(aes(period, performance)) +
#'   geom_hline(yintercept = 0.95, linetype = "dashed") +
#'   geom_line() +
#'   geom_point() +
#'   scale_y_continuous(labels = percent) +
#'   labs(title = "4 Hour performance over time")
#'
#' # Now produce a plot showing the performance of each trust
#' ae_attendances %>%
#'   group_by(org_code) %>%
#'   # select organisations that have a type 1 department
#'   filter(any(type == "1")) %>%
#'   summarise_at(vars(attendances, breaches), sum) %>%
#'   arrange(desc(attendances)) %>%
#'   mutate(performance = 1 - breaches / attendances,
#'          overall_performance = 1 - sum(breaches) / sum(attendances),
#'          rank = rank(-performance, ties.method = "first") / n()) %>%
#'   ggplot(aes(rank, performance)) +
#'   geom_vline(xintercept = c(0.25, 0.5, 0.75), linetype = "dotted") +
#'   geom_hline(yintercept = 0.95, colour = "red") +
#'   geom_hline(aes(yintercept = overall_performance), linetype = "dotted") +
#'   geom_point() +
#'   scale_y_continuous(labels = percent) +
#'   theme_minimal() +
#'   theme(panel.grid = element_blank(),
#'         axis.text.x = element_blank()) +
#'   labs(title = "4 Hour performance by trust",
#'        subtitle = "Apr-16 through Mar-19",
#'        x = "", y = "")
#'
"covid19"

