ODS_API_ENDPOINT <- "https://directory.spineservices.nhs.uk/ORD/2-0-0/"

#' ODS Roles
#'
#' This function queries the \href{https://digital.nhs.uk/services/organisation-data-service/guidance-for-developers/roles-endpoint}{ODS Roles API}.
#'
#' @return A tibble containing the roles that can be used to query the ODS
#'         organisations api (with get_ods_organisations())
#'
#' @export
#'
#' @importFrom dplyr bind_rows
#' @importFrom httr GET status_code content
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

  dplyr::bind_rows(httr::content(res)[["Roles"]])
}
