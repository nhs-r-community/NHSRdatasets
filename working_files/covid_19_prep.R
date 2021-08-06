#these libraries need to be loaded
library(utils)
library(tidyverse)

#read the Dataset sheet into “R”. The dataset will be called "data".
data <- read.csv("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", na.strings = "", fileEncoding = "UTF-8-BOM")


# library
data2 <- as_tibble(data)

# There's a no Ascii character somewhere starting: Cura according to CRAN checks

data2 %>%
  filter(str_detect(countriesAndTerritories, "Cura"))

data2$countriesAndTerritories[data2$countriesAndTerritories=="Curaçao"] <- "Curacao"


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


data(covid)

library(dplyr)
library(ggplot2)
library(scales)

# Create a plot of the performance for England over time
covid %>%
  filter(countries_and_territories == c( "United_Kingdom", "Italy", "France", "Germany", "Spain")) %>%
  ggplot(aes(x=date_reported, y= cases, col=countries_and_territories)) +
  geom_line()+
  scale_color_discrete("Country") +
  scale_y_continuous(labels=comma)+
  labs(y="Cases", x="Date", title="Coivd-19 cases for selected countries"
       , alt="A plot of covid-19 cases in France, Germany, Italy, Spain & the UK")+
  theme_minimal()





rm(covid19)
data("covid19")
