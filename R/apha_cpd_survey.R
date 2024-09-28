#' AphA (Association of Professional Healthcare Analysts) CPD Survey Responses
#'
#' Full raw data from the AphA CPD Survey
#'
#' @source \url{https://www.aphanalysts.org/documents/cpd-survey-results-raw-data/}
#'
#' The survey of NHS and other healthcare data analysts was conducted in July
#'  2022. The results data is made available in this package with the permission
#'  of AphA.
#'
#' @format This tidied raw data is available here as a tibble with 38 columns
#'  (blank or superfluous columns from the raw data were removed) and 237 rows
#'  (1 per respondent ID).
#'
#' Variables have been named using a "controlled language" approach informed
#'  by Emily Riederer's "Column Names as Contracts"
#'  \url{https://emilyriederer.netlify.app/post/column-name-contracts/}.
#'
#' \describe{
#' \item{*_id}{Columns ending in \code{"_id"} are numeric and represent a
#'   unique ID for that response.}
#' \item{*_dttm}{Columns ending in \code{"_dttm"} are in datetime format.}
#' \item{*_cat}{Columns ending in \code{"_cat"} contain categorical data,
#'   though in some cases this is mixed with free text responses and may
#'   require tidying if you need it to be strictly categorical/factor data.}
#' \item{*_n}{Columns ending in \code{"_n"} are theoretically counts, but in
#'   this tibble they may be mixed with non-numeric values and so the columns
#'   are in character format.}
#' \item{*_ind}{Columns ending in \code{"_ind"} are theoretically indicator
#'   values with 2 main value options (Yes/No). These are in character format,
#'   but should be convertible to 1/0 or TRUE/FALSE values, if desired, with
#'   minimal wrangling.}
#' \item{*_txt}{Columns ending in \code{"_txt"} contain free text responses and
#'   are in character format.}
#' }
#'
#' Multi-part questions have column name stubs with sequential letters. For
#'  example, \code{"q20a_"}, \code{"q20b_"} and so on.
#'  For formatting consistency, questions with a single part still have a
#'  column name stub with the letter a, for example \code{"q01a_"}.
#'
#' Original survey questions (lightly edited) are provided as variable labels
#'  using the \code{{labelled}} package
#'  \url{https://larmarange.github.io/labelled/}.
#'  These labels provide more descriptive context for the "clean" column names.
#'  Variable labels can be viewed using \code{labelled::get_variable_labels
#'  (apha_cpd_survey)}.
#'
#'
#' Survey press release web page: \url{https://www.aphanalysts.org/ltnws/nhs-at-risk-of-losing-a-generation-of-data-analysts/}
#'
"apha_cpd_survey"
