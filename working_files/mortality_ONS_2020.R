library(readxl)
library(janitor)
library(tidyverse)
library(stringi)
library(lubridate)

# Source and licence acknowledgement

# This data has been made available through Office of National Statistics under the Open Government
# Licence http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/

#https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/weeklyprovisionalfiguresondeathsregisteredinenglandandwales


# Download data -----------------------------------------------------------

# 2020 Format changed to xlsx from xls

download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fweeklyprovisionalfiguresondeathsregisteredinenglandandwales%2f2020/publishedweek152020corrected.xlsx",
  destfile = "2020Mortality.xlsx",
  method = "wininet",
  mode = "wb")

# Extract all worksheets to individual csv 2020 -------------------------------------------------------------

files_list <- list.files(path = "Working files/Weekly",
                         pattern = "*.xlsx",
                         full.names = TRUE)


read_then_csv <- function(sheet, path) {
  pathbase <- path %>%
    basename() %>%
    tools::file_path_sans_ext()
  path %>%
    read_excel(sheet = sheet) %>%
    write_csv(paste0(pathbase, "-", sheet, ".csv"))
}


for(j in 1:length(files_list)){

  path <- paste0(files_list[j])

  path %>%
    excel_sheets() %>%
    set_names() %>%
    map(read_then_csv, path = path)
}

# Reload just weekly figure worksheet -------------------------------------

# From 2010 to 2015 the tab name was Weekly Figures then it changed capitisation to Weekly figures

files_list_sheets <- list.files(path = "Working files/Weekly",
                                pattern = "Weekly figures 2020",
                                full.names = TRUE
)

for(i in files_list_sheets) {

  x <- read_csv((i), col_types = cols(.default = col_character()))

  assign(i, x)
}

# Repeated code -----------------------------------------------------------

remove_lookup <- c('week over the previous five years1',
                   'Deaths by underlying cause2,3',
                   'Footnotes',
                   '1 This average is based on the actual number of death registrations recorded for each corresponding week over the previous five years. Moveable public holidays, when register offices are closed, affect the number of registrations made in the published weeks and in the corresponding weeks in previous years.',
                   '2 Counts of deaths by underlying cause exclude deaths at age under 28 days.',
                   '3 Coding of deaths by underlying cause for the latest week is not yet complete.',
                   "4Does not include deaths where age is either missing or not yet fully coded. For this reason counts of 'Persons', 'Males' and 'Females' may not sum to 'Total Deaths, all ages'.",
                   '5 Does not include deaths of those resident outside England and Wales or those records where the place of residence is either missing or not yet fully coded. For this reason counts for "Deaths by Region of usual residence" may not sum to "Total deaths, all ages".',
                   'Source: Office for National Statistics',
                   'Deaths by age group'
)

# Format data 2020 -------------------------------------------------

# Format data skip line is 2
# Added formatting for age bands in line with historical data

formatFunction2020 <- function(file){

  ONS <- file %>%
    clean_names %>%
    mutate(x2 = case_when(is.na(x2) ~ contents,
                          TRUE ~ x2),
           x2 = recode(x2, "<1" = "Under 1 year")) %>%
    remove_empty(c("rows","cols")) %>%
    select(-contents) %>%
    filter(!x2 %in% c('week over the previous five years1',
                      'Deaths by underlying cause2,3',
                      'Footnotes',
                      '1 This average is based on the actual number of death registrations recorded for each corresponding week over the previous five years. Moveable public holidays, when register offices are closed, affect the number of registrations made in the published weeks and in the corresponding weeks in previous years.',
                      '2 Counts of deaths by underlying cause exclude deaths at age under 28 days.',
                      '3 Coding of deaths by underlying cause for the latest week is not yet complete.',
                      "4Does not include deaths where age is either missing or not yet fully coded. For this reason counts of 'Persons', 'Males' and 'Females' may not sum to 'Total Deaths, all ages'.",
                      '5 Does not include deaths of those resident outside England and Wales or those records where the place of residence is either missing or not yet fully coded. For this reason counts for "Deaths by Region of usual residence" may not sum to "Total deaths, all ages".',
                      'Source: Office for National Statistics',
                      'Deaths by age group'
    )) %>%
    mutate(Category = case_when(#is.na(x3) & str_detect(x2, " 4") ~ str_replace(x2, " 4", ""),
      is.na(x3) & str_detect(x2, "region") ~ "Region",
      is.na(x3) & str_detect(x2, "Persons") ~ "Persons",
      is.na(x3) & str_detect(x2, "Females") ~ "Females",
      is.na(x3) & str_detect(x2, "Males") ~ "Males",
      TRUE ~ NA_character_)
    ) %>%
    select(x2, Category, everything()) %>%
    fill(Category) %>%
    filter(!str_detect(x2, 'Persons'),
           !str_detect(x2, 'Males'),
           !str_detect(x2, 'Females')) %>%
    unite("Categories", Category, x2) %>%
    filter(Categories != 'Region_Deaths by Region of usual residence 5') %>%
    mutate(Categories = case_when(str_detect(Categories, "NA_") ~ str_replace(Categories, "NA_", ""),
                                  str_detect(Categories, "Week ended") ~ "Week ended",
                                  str_detect(Categories, "Week number") ~ "Week number",
                                  TRUE ~ Categories)
    ) %>%
    filter(!is.na(x3)) %>%
    mutate(Categories = case_when(str_detect(Categories, "previous 5 years") ~ "average of same week over 5 years",
                                  TRUE ~ Categories))

  # Push date row to column names

  onsFormattedJanitor <- row_to_names(ONS, 2)

  x <- onsFormattedJanitor %>%
    pivot_longer(cols = -`Week ended`,
                 names_to = "allDates",
                 values_to = "counts") %>%
    mutate(realDate = dmy(allDates),
           ExcelSerialDate = case_when(stri_length(allDates) == 5 ~ excel_numeric_to_date(as.numeric(allDates), date_system = "modern")),
           date = case_when(is.na(realDate) ~ ExcelSerialDate,
                            TRUE ~ realDate)) %>%
    group_by(`Week ended`) %>%
    mutate(week_no = row_number()) %>%
    ungroup() %>%
    rename(Category = `Week ended`) %>%
    mutate(category_1 = case_when(str_detect(Category, ",") ~
                                    substr(Category,1,str_locate(Category, ",") -1),
                                  str_detect(Category, ":") ~
                                    substr(Category,1,str_locate(Category, ":") -1),
                                  str_detect(Category, "_") ~
                                    substr(Category,1,str_locate(Category, "_") -1),
                                  str_detect(Category, "respiratory")  ~
                                    "All respiratory diseases (ICD-10 J00-J99) ICD-10",
                                  TRUE ~ Category),
           category_2 = case_when(str_detect(Category, ",") ~
                                    substr(Category,str_locate(Category, ", ") +2, str_length(Category)),
                                  str_detect(Category, ":") ~
                                    substr(Category,str_locate(Category, ": ") +2, str_length(Category)),
                                  str_detect(Category, "_") ~
                                    substr(Category,str_locate(Category, "_") +1, str_length(Category)),
                                  str_detect(Category, "respiratory")  ~
                                    substr(Category,str_locate(Category, "v"), str_length(Category)),
                                  TRUE ~ NA_character_)
    ) %>%
    select(category_1,
           category_2,
           counts,
           date,
           week_no
    ) %>%
    filter(!is.na(counts))

  return(x)

}

Mortality2020 <- formatFunction2020(`Working files/Weekly/2020Mortality-Weekly figures 2020.csv`)


# Bind together -----------------------------------------------------------

load("data/ons_mortality.rda")

ons_mortality <- do.call("rbind", list(ons_mortality,
                                   Mortality2020))

# Save as rda file

save(ons_mortality, file = "Working files/ons_mortality.rda")

# Save as a csv file

write_csv(ons_mortality, "Working files/ons_mortality.csv")
