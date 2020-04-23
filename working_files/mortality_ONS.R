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

# 2019
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fweeklyprovisionalfiguresondeathsregisteredinenglandandwales%2f2019/publishedweek522019.xls",
  destfile = "2019Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2018
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fweeklyprovisionalfiguresondeathsregisteredinenglandandwales%2f2018/publishedweek522018withupdatedrespiratoryrow.xls",
  destfile = "2018Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2017
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fweeklyprovisionalfiguresondeathsregisteredinenglandandwales%2f2017/publishedweek522017.xls",
  destfile = "2017Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2016
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fweeklyprovisionalfiguresondeathsregisteredinenglandandwales%2f2016/publishedweek522016.xls",
  destfile = "2016Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2015
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fweeklyprovisionalfiguresondeathsregisteredinenglandandwales%2f2015/publishedweek2015.xls",
  destfile = "2015Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2014
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fweeklyprovisionalfiguresondeathsregisteredinenglandandwales%2f2014/publishedweek2014.xls",
  destfile = "2014Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2013
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fweeklyprovisionalfiguresondeathsregisteredinenglandandwales%2f2013/publishedweek2013.xls",
  destfile = "2013Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2012
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fweeklyprovisionalfiguresondeathsregisteredinenglandandwales%2f2012/publishedweek2012.xls",
  destfile = "2012Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2011
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fweeklyprovisionalfiguresondeathsregisteredinenglandandwales%2f2011/publishedweek2011.xls",
  destfile = "2011Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2010
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fweeklyprovisionalfiguresondeathsregisteredinenglandandwales%2f2010/publishedweek2010.xls",
  destfile = "2010Mortality.xls",
  method = "wininet",
  mode = "wb")


# Extract all worksheets to individual csv 2010-2019 -------------------------------------------------------------

files_list <- list.files(path = "working_files",
                         pattern = "*.xls",
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

# Extract all worksheets to individual csv 2020 -------------------------------------------------------------

files_list <- list.files(path = "working_files",
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

files_list_sheets <- list.files(path = "working_files",
                         pattern = "Weekly",
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

# Format data 2010 - 2015 -----------------------------------------------------------

formatFunction <- function(file){

ONS <- file %>%
  clean_names %>%
  remove_empty(c("rows","cols")) %>%
  filter(!contents %in% remove_lookup) %>%
  mutate(Category = case_when(is.na(x2) & str_detect(contents, "Region") ~ "Region",
                              is.na(x2) & str_detect(contents, "Persons") ~ "Persons",
                              is.na(x2) & str_detect(contents, "Females") ~ "Females",
                              is.na(x2) & str_detect(contents, "Males") ~ "Males")
  ) %>%
  select(contents, Category, everything()) %>%
  fill(Category) %>%
  filter(!str_detect(contents, "Persons"),
         !str_detect(contents, "Males"),
         !str_detect(contents, "Females")) %>%
  unite("Categories", Category, contents) %>%
  filter(Categories != 'Region_Deaths by Region of usual residence 5') %>%
  mutate(Categories = case_when(str_detect(Categories, "NA_") ~ str_replace(Categories, "NA_", ""),
                                TRUE ~ Categories))

# Push date row to column names

onsFormattedJanitor <- row_to_names(ONS, 3)

# Move to long form and further formatting

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
                                  "All respiratory diseases (ICD-10 J00-J99) ICD-10"),
         category_2 = case_when(str_detect(Category, ",") ~
                                  substr(Category,str_locate(Category, ", ") +2, str_length(Category)),
                                str_detect(Category, ":") ~
                                  substr(Category,str_locate(Category, ": ") +2, str_length(Category)),
                                str_detect(Category, "_") ~
                                  substr(Category,str_locate(Category, "_") +1, str_length(Category)),
                                str_detect(Category, "respiratory")  ~
                                  substr(Category,str_locate(Category, "v"), str_length(Category)) ),
         category_2 = recode(category_2,
                             "average of corresponding" = "average of same week over 5 years")) %>%
  select(category_1,
         category_2,
         counts,
         date,
         week_no
         ) %>%
  filter(!is.na(counts),
                  counts != ":") %>%
  fill(category_1)


return(x)

}

Mortality2010 <- formatFunction(`Working files/Weekly/2010Mortality-Weekly Figures 2010.csv`)
Mortality2011 <- formatFunction(`Working files/Weekly/2011Mortality-Weekly Figures 2011.csv`) %>%
  mutate(category_2 = case_when(is.na(category_2) & category_1 == "All respiratory diseases (ICD-10 J00-J99) ICD-10" ~ "v 2010",
                                TRUE ~ category_2))

Mortality2012 <- formatFunction(`Working files/Weekly/2012Mortality-Weekly Figures 2012.csv`)
Mortality2013 <- formatFunction(`Working files/Weekly/2013Mortality-Weekly Figures 2013.csv`)
Mortality2014 <- formatFunction(`Working files/Weekly/2014Mortality-Weekly Figures 2014.csv`)
Mortality2015 <- formatFunction(`Working files/Weekly/2015Mortality-Weekly Figures 2015.csv`)


# Format data 2016 - 2019 -------------------------------------------------

formatFunction2016 <- function(file){

  ONS <- file %>%
    clean_names %>%
    mutate(x2 = case_when(is.na(x2) ~ contents,
                              TRUE ~ x2)) %>%
    remove_empty(c("rows","cols")) %>%
    select(-contents) %>%
    filter(!x2 %in% remove_lookup) %>%
    mutate(Category = case_when(is.na(x3) & str_detect(x2, "region") ~ "Region",
                                is.na(x3) & str_detect(x2, "Persons") ~ "Persons",
                                is.na(x3) & str_detect(x2, "Females") ~ "Females",
                                is.na(x3) & str_detect(x2, "Males") ~ "Males",
                                TRUE ~ NA_character_)
    ) %>%
    select(x2, Category, everything()) %>%
    fill(Category) %>%
    filter(!str_detect(x2, "Persons"),
           !str_detect(x2, "Males"),
           !str_detect(x2, "Females")) %>%
    unite("Categories", Category, x2) %>%
    filter(Categories != 'Region_Deaths by Region of usual residence 5') %>%
    mutate(Categories = case_when(str_detect(Categories, "NA_") ~ str_replace(Categories, "NA_", ""),
                                  TRUE ~ Categories))

  # Push date row to column names

  onsFormattedJanitor <- row_to_names(ONS, 3)

  # Move to long form and further formatting

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
                                  "All respiratory diseases (ICD-10 J00-J99) ICD-10"),
         category_2 = case_when(str_detect(Category, ",") ~
                                  substr(Category,str_locate(Category, ", ") +2, str_length(Category)),
                                str_detect(Category, ":") ~
                                  substr(Category,str_locate(Category, ": ") +2, str_length(Category)),
                                str_detect(Category, "_") ~
                                  substr(Category,str_locate(Category, "_") +1, str_length(Category)),
                                str_detect(Category, "respiratory")  ~
                                  substr(Category,str_locate(Category, "v"), str_length(Category)) ),
         category_2 = recode(category_2,
                             "average of corresponding" = "average of same week over 5 years")) %>%
    select(category_1,
           category_2,
           counts,
           date,
           week_no
    ) %>%
    filter(!is.na(counts))

  return(x)

}


Mortality2016 <- formatFunction2016(`Working files/Weekly/2016Mortality-Weekly figures 2016.csv`)
Mortality2017 <- formatFunction2016(`Working files/Weekly/2017Mortality-Weekly figures 2017.csv`)
Mortality2018 <- formatFunction2016(`Working files/Weekly/2018Mortality-Weekly figures 2018.csv`)
Mortality2019 <- formatFunction2016(`Working files/Weekly/2019Mortality-Weekly figures 2019.csv`)


# Bind together -----------------------------------------------------------

ons_mortality <- do.call("rbind", list(
                      Mortality2010,
                      Mortality2011,
                      Mortality2012,
                      Mortality2013,
                      Mortality2014,
                      Mortality2015,
                      Mortality2016,
                      Mortality2017,
                      Mortality2018,
                      Mortality2019)) %>%
  mutate(counts = as.numeric(counts))

  # Save as rda file

  save(ons_mortality, file = "data/ons_mortality.rda")
