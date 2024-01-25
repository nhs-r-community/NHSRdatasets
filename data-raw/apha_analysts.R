## code to prepare `apha_analysts` dataset goes here


# https://www.aphanalysts.org/documents/cpd-survey-results-raw-data/

raw_data_url <- paste0(
  "https://www.aphanalysts.org/",
  "document/get/file/CPD-Survey-Results-RAW-Data.xlsx"
  )

raw_data <- openxlsx2::read_xlsx(raw_data_url)

usethis::use_data(apha_analysts, overwrite = TRUE)
