#these libraries need to be loaded
library(utils)
library(tidyverse)

#read the Dataset sheet into “R”. The dataset will be called "data".
data <- read.csv("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", na.strings = "", fileEncoding = "UTF-8-BOM")


# library
data2 <- as_tibble(data)

data2$countries_and_territories <- factor(data2$countriesAndTerritories)
data2$geo_id <- factor(data2$geoId)
data2$country_territory_code <- factor(data2$countryterritoryCode)
data2$date_reported <- as.Date(data2$dateRep, format = "%d/%m/%Y" )
data2$continent <- as.factor(data2$continentExp)
data2$population_2019 <- data2$popData2019


covid19 <-
  data2 %>%
  select(date_reported, continent, countries_and_territories,
         country_territory_code, population_2019, cases, deaths)

usethis::use_data(covid19, compress="xz", overwrite = TRUE)


# ideas:
# 4-day population rate;
# timeseries plots
# forecasting
# mapping
