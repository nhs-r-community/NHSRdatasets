#' Care Quality Commission provider directory timesries
#'
#' Care Quality Commission (CQC) directory of care providers, as published monthly.
#' Contains data on locations and providers (one provider may have multiple locations), including
#' local authority data, CQC ratings, and care provision type. All columns are encoded as strings.
#'
#' Data sourced from \href{https://www.cqc.org.uk/about-us/transparency/using-cqc-data}{CQC data services} archive,
#' which is available via the \href{https://drive.google.com/drive/folders/1Y6V6r-q2l4lJYKuZL0DXw25VDUTH6L4N}{Googledrive archive}.
#'
#' @docType data
#'
#' @keywords datasets cqc quality
#'
#' @format Tibble with 52 columns
#' \describe{
#' \item{location_id}{Location ID}
#' \item{location_hsca_start_date}{The date location became active}
#' \item{care_home}{Categorical 'Y' (yes) or 'N' (no).}
#' \item{location_name}{Location name}
#' \item{location_ods_code}{Location ODS code}
#' \item{location_telephone_number}{Telephone number of location}
#' \item{location_web_address}{Location website}
#' \item{care_homes_beds}{If a care home, how many beds are available}
#' \item{location_type_sector}{Type of care this location provides}
#' \item{location_latest_overall_rating}{Latest CQC rating for this location at the time of data publication}
#' \item{publication_date}{Date latest CQC rating for this location was published}
#' \item{location_region}{UK Region location is located in}
#' \item{location_onspd_ccg_code}{Code of CCG location is located in}
#' \item{location_onspd_ccg}{Name of CCG location is located in}
#' \item{location_commissioning_ccg_code}{Code of commissioning CCG responsible for location}
#' \item{location_commissioning_ccg}{Name of commissioning CCG responsible for location}
#' \item{location_street_address}{Location street address line 1}
#' \item{location_address_line_2}{Location street address line 2}
#' \item{location_city}{Location city}
#' \item{location_county}{Location UK county}
#' \item{location_postal_code}{Location postcode}
#' \item{location_latitude}{Location latitude coordinate}
#' \item{location_longitude}{Location longitude coordinate}
#' \item{location_parliamentary_constituency}{Location's parliamentary constituency name}
#' \item{brand_id}{ID of overarching brand}
#' \item{brand_name}{Name of overarching brand}
#' \item{provider_companies_house_number}{Companies house number of provider}
#' \item{provider_charity_number}{If provider is a charity, provider's charity number}
#' \item{provider_id}{Provider ID}
#' \item{provider_name}{Provider Name}
#' \item{provider_hsca_start_date}{The date provider became active}
#' \item{provider_type_sector}{Type of care this provider provides}
#' \item{provider_inspection_directorate}{CQC Inspection directorate responsible for provider}
#' \item{provider_primary_inspection_category}{Provider's primary category for inspections}
#' \item{provider_ownership_type}{Ownership structure of provider}
#' \item{provider_telephone_number}{Telephone number of provider}
#' \item{provider_web_address}{Provider website}
#' \item{provider_street_address}{Provider street address line 1}
#' \item{provider_address_line_2}{Provider street address line 2}
#' \item{provider_city}{Provider city}
#' \item{provider_county}{Provider UK county}
#' \item{provider_postal_code}{Provider postcode}
#' \item{provider_local_authority}{Provider local authority}
#' \item{provider_region}{UK Region provider is located in}
#' \item{provider_latitude}{Provider latitude coordinate}
#' \item{provider_longitude}{Provider longitude coordinate}
#' \item{provider_parliamentary_constituency}{Provider's parliamentary constituency name}
#' \item{pub_date}{Date dataset was published with this information}
#' }
#'
#' @source \href{https://www.cqc.org.uk/about-us/transparency/using-cqc-data}{Care Quality Commission}
#'
#' @usage data(cqc_directory)
#'
#' @examples
#' data(cqc_directory)
#' library(dplyr)
#' library(ggplot2)
#'
#' # Create a plot of the proportion of location CQC ratings over time, separated by whether it's a care home or not
#' cqc_directory %>%
#'    group_by(pub_date, care_home, location_latest_overall_rating) %>%
#'    summarise(number = n()) %>%
#'    filter(!is.na(location_latest_overall_rating)) %>%
#'    mutate(pub_date = as.Date(pub_date)) %>%
#'    ggplot(aes(x = pub_date, y = number, fill = location_latest_overall_rating))+
#'    geom_bar(stat = 'identity', position = 'fill')+
#'    facet_wrap(~care_home)
#'
#' # Proportion of care homes in each region that required improvement over time
#' cqc_directory %>%
#'    filter(care_home == 'Y' & location_region != 'Unspecified' &
#'            location_type_sector == 'Social Care Org') %>%
#'    mutate(req_improvement = ifelse(location_latest_overall_rating %in% c('Inadequate', 'Requires improvement'), 'Y', 'N'),
#'           pub_date = as.Date(pub_date)) %>%
#'    group_by(pub_date, location_region, req_improvement) %>%
#'    summarise(number = n()) %>%
#'    mutate(prop_req_improvement = number / sum(number)) %>%
#'    filter(req_improvement == 'Y') %>%
#'    ggplot(aes(x = pub_date, y = location_region, fill = prop_req_improvement))+
#'    geom_bin2d(stat = 'identity')
#'
"cqc_directory"

