#' Deaths registered weekly in England and Wales, provisional
#'
#' Provisional counts of the number of deaths registered in England and Wales, by age, sex and region, in the latest weeks for which data are available.
#'
#' Source and licence acknowledgement
#' This data has been made available through Office of National Statistics under the Open Government
#' Licence \url{http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/}
#'
#'
#' @docType data
#'
#' @keywords datasets mortality deaths England Wales Provisional
#'
#' @format Data frame with five columns
#' \describe{
#' \item{category_1}{Data is released in groups and category_1 is the }
#' \item{Counts}{Counts of deaths in whole numbers}
#' \item{Date}{Provisional deaths are released on the Friday of every week.}
#' \item{WeekNo}{Following the format of the ONS spreadsheets each week is numbered sequentially within the year.}
#' }
#'
#' @source Collected by Zoë Turner \email{zoe.turner2@nottshc.nhs.uk}, Apr-2020 from \url{https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/weeklyprovisionalfiguresondeathsregisteredinenglandandwales}
#'
#' @usage data(ons_mortality)
#'
#' @examples
#' data(ons_mortality)
#'
#'library(dplyr)
#'library(tidyr)
#'
#'wideForm <- ons_mortality %>%
#'  select(-week_no) %>%
#'  pivot_wider(names_from = date,
#'              values_from = counts
#'  )
#'
"ons_mortality"
