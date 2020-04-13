library(readxl)
library(janitor)
library(tidyverse)


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


# Extract all worksheets to individual csv -------------------------------------------------------------

files_list <- list.files(path = "Working files",
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


# Reload just weekly figure worksheet -------------------------------------

files_list_sheets <- list.files(path = "Working files",
                         pattern = "Weekly Figures",
                         full.names = TRUE)

filesCsv = lapply(files_list_sheets, read_csv)

#xlist <- list.files(pattern = "*.csv")

for(i in files_list_sheets) {

  x <- read.csv((i))

  assign(i, x)
}


# Format data -----------------------------------------------------------

ONS <- x %>%
  # mutate(`...2` = as.numeric(as.character(`...2`))) %>%
  clean_names %>%
  #  mutate(`...2` = as.numeric(as.character(`...2`))) %>%
  remove_empty(c("rows","cols")) %>%
  filter(!contents %in% c('week over the previous five years1',
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
  mutate(Category = case_when(is.na(`...2`) & str_detect(contents, " 4") ~ str_replace(contents, " 4", ""),
                              is.na(`...2`) & str_detect(contents, " 5") ~ "Region")
  ) %>%
  select(contents, Category, everything()) %>%
  fill(Category) %>%
  filter(!contents %in% c('Persons 4',
                          'Males 4',
                          'Females 4')) %>%
  unite("Categories", Category, contents) %>%
  filter(Categories != 'Region_Deaths by Region of usual residence 5') %>%
  mutate(Categories = case_when(str_detect(Categories, "NA_") ~ str_replace(Categories, "NA_", ""),
                                TRUE ~ Categories))

# Push date row to column names

ons2010formattedJanitor <- row_to_names(ONS, 3)

x <- ons2010formattedJanitor %>%
  pivot_longer(cols = -`Week ended`,
               names_to = "ExcelSerialDate",
               values_to = "Counts") %>%
  mutate(Date = excel_numeric_to_date(as.numeric(ExcelSerialDate), date_system = "modern")) %>%
  group_by(`Week ended`) %>%
  mutate(WeekNo = row_number()) %>%
  ungroup() %>%
  rename(Category = `Week ended`)


# Save as RData file

  save(ons2010df, file = "data/ONSMortality.RData")

# Resave

  library(cgwtools)

  resave(ons2010df,file = 'data/ONSMortality.RData')
