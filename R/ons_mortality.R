#' Deaths registered weekly in England and Wales, provisional
#'
#' Provisional counts of the number of deaths registered in England and Wales,
#' by age, sex and region, from week commencing 8th January 2010 to
#' 3rd April 202.
#'
#' Source and licence acknowledgement
#'
#' This data has been made available through Office of National Statistics under
#' the Open Government Licence
#' \url{http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/}
#'
#'
#' @docType data
#'
#' @keywords datasets mortality deaths England Wales Provisional
#'
#' @format Data frame with five columns
#' \describe{
#' \item{category_1}{character, containing the names of the groups for counts,
#' for example "Total deaths", "all ages".}
#' \item{category_2}{character, subcategory of names of groups where necessary,
#' for example details of region: "East", details of age bands "15-44".}
#' \item{counts}{numeric, numbers of deaths in whole numbers and average numbers
#' with decimal points. To retain the integrity of the format this column data
#' is left as character.}
#' \item{date}{date, format is yyyy-mm-dd; all dates are a Friday.}
#' \item{week_no}{integer, each week in a year is numbered sequentially.}
#' }
#'
#' @source Collected by Zoë Turner, Apr-2020 from
#' \url{https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/weeklyprovisionalfiguresondeathsregisteredinenglandandwales}
#'
#' @usage data(ons_mortality)
#'
#' @examples
#' data(ons_mortality)
#'
#' library(dplyr)
#' library(tidyr)
#'
#' # create a dataset that is "wide" with each date as a column
#' ons_mortality |>
#'   select(-week_no) |>
#'   pivot_wider(
#'     names_from = date,
#'     values_from = counts
#'   )
#'
"ons_mortality"
