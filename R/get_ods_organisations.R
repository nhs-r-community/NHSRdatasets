#' ODS Organisations
#'
#' This function queries the \href{https://digital.nhs.uk/services/organisation-data-service/guidance-for-developers/search-endpoint}{ODS Search API}.
#'
#' One or more arguments should be specified, if not it will default (with a
#' warning to using the primary role of "NHS Trust")
#'
#' @param name a character: queries organisations that contain that word in the
#'   name of the organisation
#' @param post_code a character: queries organisations based on their postcode.
#'   You can search by either the full postcode, or a partial postcode. If you
#'   use a partial postcode then it must be at least the Outcode portion of the
#'   postcode (e.g. B1, WV10).
#' @param last_change_date a date: queries all organisations that have been
#'   changed after that date
#' @param status a character (either active or inactive): searches for
#'   organisations based on their status
#' @param primary_role_id a character: queries all organisations that have the
#'   specified primary role (see \code{\link{get_ods_roles}})
#' @param non_primary_role_id a character: queries all organisations that have
#'   the role as a secondary role (see \code{\link{get_ods_roles}})
#' @param org_record_class a character: queries all organisations based on their
#'   record class TODO: implement a function that queries this API
#'
#' @return a tibble of organisations
#' @export
#'
#' @importFrom dplyr bind_rows
#' @importFrom lubridate is.Date
#' @importFrom janitor clean_names
#' @importFrom httr GET status_code headers content
#' @importFrom utils URLencode
#'
#' @examples
#' \dontrun{
#' # this will default to getting organisations with a primary role of "NHS
#' # TRUST", but it will throw a warning:
#' get_ods_organisations()
#'
#' # you could be more specific and specify that you want to use a primary role
#' # of "NHS TRUST" using the code from get_ods_roles()
#' primary_role_id <- get_ods_roles() %>%
#'   filter(displayName == "NHS TRUST") %>%
#'   pull(id)
#' get_ods_organisations(primary_role_id = primary_role_id)
#'
#' # or, you could use the specific functions for the primary role id's
#' get_ods_trusts()
#' get_ods_trust_sites()
#' get_ods_ccgs()
#'
#' # you can use as many of the arguments as you like
#' # get current active CCG's
#' get_ods_ccgs(status = "active")
#'
#' # get NHS Trust Sites with "Royal" in their name
#' get_ods_trust_sites(name = "Royal")
#' }
get_ods_organisations <- function(name = as.character(NA),
                                  post_code = as.character(NA),
                                  last_change_date = as.Date(NA),
                                  status = c(NA, "active", "inactive"),
                                  primary_role_id = as.character(NA),
                                  non_primary_role_id = as.character(NA),
                                  org_record_class = as.character(NA)) {
  # limit of number of rows we can get at any time, current maximum is 1000
  LIMIT <- 1000

  # url is built up of api and the parameters. We need to keep a copy of the
  # initial url to compare to later: the api will fail to run if no parameters
  # are passed
  url <- init_url <- paste0(ODS_API_ENDPOINT, "organisations?Limit=", LIMIT)

  # argument checking ==========================================================
  if (!is.na(name)) {
    if (!is.character(name)) {
      stop ("name argument must be of type character")
    }
    url <- paste0(url, "&Name=", utils::URLencode(name))
  }

  if (!is.na(post_code)) {
    if (!is.character(post_code)) {
      stop ("post_code argument must be of type character")
    }
    url <- paste0(url, "&PostCode=", utils::URLencode(post_code))
  }

  if (!is.na(last_change_date)) {
    if (!lubridate::is.Date(last_change_date)) {
      stop ("date argument must be of type date")
    }
    url <- paste0(url, "&LastChangeDate=", format(last_change_date, "%Y-%m-%d"))
  }

  status <- match.arg(status)
  if (!is.na(status)) {
    url <- paste0(url, "&Status=", status)
  }

  if (!is.na(primary_role_id)) {
    if (!is.character(primary_role_id)) {
      stop ("primary_role_id argument must be of type character")
    }
    url <- paste0(url, "&PrimaryRoleId=", utils::URLencode(primary_role_id))
  }

  if (!is.na(non_primary_role_id)) {
    if (!is.character(non_primary_role_id)) {
      stop ("non_primary_role_id argument must be of type character")
    }
    url <- paste0(url, "&NonPrimaryRoleId=", utils::URLencode(non_primary_role_id))
  }

  if (!is.na(org_record_class)) {
    if (!is.character(org_record_class)) {
      stop ("org_record_class argument must be of type character")
    }
    # url <- paste0(url, "&OrgRecordClass=", utils::URLencode(org_record_class))
  }
  # checked all arguments ======================================================
  # no arguments were passed, let's use NHS TRUST as primary role
  if (url == init_url) {
    warning("No arguments specified: defaulting to Primary Role == NHS TRUST")
    url <- paste0(url, "&PrimaryRoleId=RO197")
  }

  # get the initial page of data
  res <- httr::GET(url)

  # make sure the api call was successful
  if (httr::status_code(res) != 200) {
    stop("unable to load data from API")
  }

  # find out how many records there are in total to load
  total_count <- httr::headers(res)[["x-total-count"]]

  # convert the results into a tibble
  organisations <- dplyr::bind_rows(httr::content(res)[["Organisations"]])

  # if we have more results than we can load in one go
  offset <- 0
  while (total_count > nrow(organisations)) {
    # load the next page of results
    offset <- offset + LIMIT
    res <- httr::GET(paste0(url, "&Offset=", offset))

    # again, make sure call was successful
    if (httr::status_code(res) != 200) {
      stop("unable to load data from API")
    }

    # update the organisations data to include next page of data
    organisations <- dplyr::bind_rows(
      organisations,
      httr::content(res)[["Organisations"]]
    )
  }
  # return the organisations data
  janitor::clean_names(organisations)
}

#' @rdname get_ods_organisations
#' @export
get_ods_trusts <- function(name = as.character(NA),
                           post_code = as.character(NA),
                           last_change_date = as.Date(NA),
                           status = c(NA, "active", "inactive"),
                           non_primary_role_id = as.character(NA),
                           org_record_class = as.character(NA)) {
  get_ods_organisations(name,
                        post_code,
                        last_change_date,
                        status,
                        primary_role_id = "RO197",
                        non_primary_role_id,
                        org_record_class)
}

#' @rdname get_ods_organisations
#' @export
get_ods_trust_sites <- function(name = as.character(NA),
                                post_code = as.character(NA),
                                last_change_date = as.Date(NA),
                                status = c(NA, "active", "inactive"),
                                non_primary_role_id = as.character(NA),
                                org_record_class = as.character(NA)) {
  get_ods_organisations(name,
                        post_code,
                        last_change_date,
                        status,
                        primary_role_id = "RO198",
                        non_primary_role_id,
                        org_record_class)
}

#' @rdname get_ods_organisations
#' @export
get_ods_ccgs <- function(name = as.character(NA),
                         post_code = as.character(NA),
                         last_change_date = as.Date(NA),
                         status = c(NA, "active", "inactive"),
                         non_primary_role_id = as.character(NA),
                         org_record_class = as.character(NA)) {
  get_ods_organisations(name,
                        post_code,
                        last_change_date,
                        status,
                        primary_role_id = "RO98",
                        non_primary_role_id,
                        org_record_class)
}
