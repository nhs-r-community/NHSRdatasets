ODS_API_ENDPOINT <- "https://directory.spineservices.nhs.uk/ORD/2-0-0/"

#' ODS Roles
#'
#' This function queries the \href{https://digital.nhs.uk/services/organisation-data-service/guidance-for-developers/roles-endpoint}{ODS Roles API}.
#'
#' Each organisation that is in the ODS organisations API will have a primary
#' role (e.g. NHS TRUST) and can have secondary roles. These role ids can be
#' used to query the Organisations api.
#'
#' @return A tibble containing the roles that can be used to query the ODS
#'         organisations api (with \code{\link{get_ods_organisations}})
#'
#' @export
#'
#' @importFrom dplyr bind_rows
#' @importFrom httr GET status_code content
#' @importFrom janitor clean_names
#'
#' @examples
#' \dontrun{
#' get_ods_roles()
#' }
get_ods_roles <- function() {
  url <- paste0(ODS_API_ENDPOINT, "roles")

  res <- httr::GET(url)

  if (httr::status_code(res) != 200) {
    stop("unable to load data from API")
  }

  roles <- dplyr::bind_rows(httr::content(res)[["Roles"]])

  janitor::clean_names(roles)
}
