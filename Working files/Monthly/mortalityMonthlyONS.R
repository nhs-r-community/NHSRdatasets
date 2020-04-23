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

# 2020
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2020/publishedoutputfebruary20202.xls",
  destfile = "Monthly2020Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2019
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2019/publishedoutputdecember2019.xls",
  destfile = "Monthly2019Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2018
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2018/publishedannual2018.xls",
  destfile = "Monthly2018Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2017
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2017/publishedoutputannual2017final.xls",
  destfile = "Monthly2017Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2016
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2016/publishedoutput2016final.xls",
  destfile = "Monthly2016Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2015
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2015/publishedoutput2015final.xls",
  destfile = "Monthly2015Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2014
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2014/publishedoutput2014finaltcm774115982.xls",
  destfile = "Monthly2014Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2013
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2013/publishedoutput2013finaltcm773717241.xls",
  destfile = "Monthly2013Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2012
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2012/publishedoutput2012finaltcm773197501.xls",
  destfile = "Monthly2012Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2011
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2011/publishedoutput2011finaltcm772738151.xls",
  destfile = "Monthly2011Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2010
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2010/publishedoutputfeb021tcm772274383.xls",
  destfile = "Monthly2010Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2009
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2009/publishedoutput200tcm772274362.xls",
  destfile = "Monthly2009Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2008
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2008/publishedoutput200tcm772274292.xls",
  destfile = "Monthly2008Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2007
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2007/publishedoutput200tcm772274233.xls",
  destfile = "Monthly2007Mortality.xls",
  method = "wininet",
  mode = "wb")

# 2006
download.file(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fbirthsdeathsandmarriages%2fdeaths%2fdatasets%2fmonthlyfiguresondeathsregisteredbyareaofusualresidence%2f2006/publishedoutput200tcm772274163.xls",
  destfile = "Monthly2006Mortality.xls",
  method = "wininet",
  mode = "wb")


# Extract all worksheets to individual csv 2010-2019 -------------------------------------------------------------

files_list <- list.files(path = "Working files",
                         pattern = "Monthly",
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


# Reload just figure worksheet -------------------------------------

# From

files_list_sheets <- list.files(path = "Working files",
                         pattern = "Figures",
                         full.names = TRUE
                         )

for(i in files_list_sheets) {

  x <- read_csv((i), col_types = cols(.default = col_character()))

  assign(i, x)
}

# Format data 2006 -----------------------------------------------------------

formatFunction <- function(file){

ONS <- `Working files/Monthly2006Mortality-Figures for 2006.csv` %>%
  clean_names %>%
  remove_empty(c("rows","cols")) %>%
  mutate(Category = coalesce(x2,x3,x4)) %>%
  rename_at(vars(starts_with("Monthly")), ~("codes")) %>%
  filter(!codes %in% c('Footnotes:',
                          '1')
         ) %>%
  select(-x2, -x3, -x4) %>%
  select(codes,
         Category,
         everything())


  # mutate(Category = case_when(is.na(x2) & str_detect(contents, " 4") ~ str_replace(contents, " 4", ""),
  #                             is.na(x2) & str_detect(contents, " 5") ~ "Region")
  # ) %>%
  # select(contents, Category, everything()) %>%
  # fill(Category) %>%
  # filter(!contents %in% c('Persons 4',
  #                         'Males 4',
  #                         'Females 4')) %>%
  # unite("Categories", Category, contents) %>%
  # filter(Categories != 'Region_Deaths by Region of usual residence 5') %>%
  # mutate(Categories = case_when(str_detect(Categories, "NA_") ~ str_replace(Categories, "NA_", ""),
  #                               TRUE ~ Categories))

# Push date row to column names

onsFormattedJanitor <- row_to_names(ONS, 1)

x <- onsFormattedJanitor %>%
  pivot_longer(cols = -``,
               names_to = "allDates",
               values_to = "Counts") %>%
  mutate(realDate = dmy(allDates),
         ExcelSerialDate = case_when(stri_length(allDates) == 5 ~ excel_numeric_to_date(as.numeric(allDates), date_system = "modern")),
         Date = case_when(is.na(realDate) ~ ExcelSerialDate,
                          TRUE ~ realDate)) %>%
  group_by(`Week ended`) %>%
  mutate(WeekNo = row_number()) %>%
  ungroup() %>%
  rename(Category = `Week ended`)

return(x)

}

Mortality2010 <- formatFunction(`Working files/2010Mortality-Weekly Figures 2010.csv`)
Mortality2011 <- formatFunction(`Working files/2011Mortality-Weekly Figures 2011.csv`)
Mortality2012 <- formatFunction(`Working files/2012Mortality-Weekly Figures 2012.csv`)
Mortality2013 <- formatFunction(`Working files/2013Mortality-Weekly Figures 2013.csv`)
Mortality2014 <- formatFunction(`Working files/2014Mortality-Weekly Figures 2014.csv`)
Mortality2015 <- formatFunction(`Working files/2015Mortality-Weekly Figures 2015.csv`)


# Format data 2016 - 2019 -------------------------------------------------
# Format data 2020 - (added skip line)

formatFunction2016 <- function(file, skip){

  ONS <- file %>%
    clean_names %>%
    mutate(x2 = case_when(is.na(x2) ~ contents,
                              TRUE ~ x2)) %>%
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
    mutate(Category = case_when(is.na(x3) & str_detect(x2, " 4") ~ str_replace(x2, " 4", ""),
                                is.na(x3) & str_detect(x2, " 5") ~ "Region")
    ) %>%
    select(x2, Category, everything()) %>%
    fill(Category) %>%
    filter(!x2 %in% c('Persons 4',
                            'Males 4',
                            'Females 4')) %>%
    unite("Categories", Category, x2) %>%
    filter(Categories != 'Region_Deaths by Region of usual residence 5') %>%
    mutate(Categories = case_when(str_detect(Categories, "NA_") ~ str_replace(Categories, "NA_", ""),
                                  TRUE ~ Categories))

  # Push date row to column names

  onsFormattedJanitor <- row_to_names(ONS, skip)

  x <- onsFormattedJanitor %>%
    pivot_longer(cols = -`Week ended`,
                 names_to = "allDates",
                 values_to = "Counts") %>%
    mutate(realDate = dmy(allDates),
           ExcelSerialDate = case_when(stri_length(allDates) == 5 ~ excel_numeric_to_date(as.numeric(allDates), date_system = "modern")),
           Date = case_when(is.na(realDate) ~ ExcelSerialDate,
                            TRUE ~ realDate)) %>%
    group_by(`Week ended`) %>%
    mutate(WeekNo = row_number()) %>%
    ungroup() %>%
    rename(Category = `Week ended`)

  return(x)

}


Mortality2016 <- formatFunction2016(`Working files/2016Mortality-Weekly figures 2016.csv`, 3)
Mortality2017 <- formatFunction2016(`Working files/2017Mortality-Weekly figures 2017.csv`, 3)
Mortality2018 <- formatFunction2016(`Working files/2018Mortality-Weekly figures 2018.csv`, 3)
Mortality2019 <- formatFunction2016(`Working files/2019Mortality-Weekly figures 2019.csv`, 3)




Mortality2020 <- formatFunction2016(`Working files/2020Mortality-Weekly figures 2020.csv`, 4)


# Bind together -----------------------------------------------------------

Mortality <- do.call("rbind", list(Mortality2010,
                      Mortality2011,
                      Mortality2012,
                      Mortality2013,
                      Mortality2014,
                      Mortality2015,
                      Mortality2016,
                      Mortality2017,
                      Mortality2018,
                      Mortality2019)) %>%
  select(-allDates,
         -realDate,
         -ExcelSerialDate)


  # Save as RData file

  save(Mortality, file = "data/ons_mortality.rda")
