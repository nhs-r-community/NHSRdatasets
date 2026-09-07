# ONS Mid-2023 Population Estimate for UK

ONS Population Estimates for Mid-year 2023 National and subnational
mid-year population estimates for the UK and its constituent countries
by administrative area, age and sex (including components of population
change, median age and population density).

## Usage

``` r
data(ons_uk_population_2023)
```

## Format

Tibble with six columns

- sex:

  male or female

- code:

  country/geography code

- name:

  country of the UK

- geography:

  Country

- age:

  year of age

- count:

  the number of people in this group

## Source

<https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationestimatesforukenglandandwalesscotlandandnorthernireland>

## Details

ONS Estimates of the population for the UK, England, Wales, Scotland,
and Northern Ireland

## Examples

``` r
data(ons_uk_population_2023)


library(dplyr)
library(tidyr)

# create a dataset that has total population by age groups for England
ons_uk_population_2023 |>
  filter(name == "ENGLAND") |>
  mutate(age_group = case_when(
    as.numeric(age) <= 17 ~ "0-17",
    as.numeric(age) >= 18 & as.numeric(age) <= 64 ~ "18-64",
    as.numeric(age) >= 65 ~ "65+",
    age == "90+" ~ "65+"
  )) |>
  group_by(age_group) |>
  summarise(count = sum(count))
#> Warning: There were 4 warnings in `mutate()`.
#> The first warning was:
#> ℹ In argument: `age_group = case_when(...)`.
#> Caused by warning:
#> ! NAs introduced by coercion
#> ℹ Run `dplyr::last_dplyr_warnings()` to see the 3 remaining warnings.
#> # A tibble: 3 × 2
#>   age_group    count
#>   <chr>        <dbl>
#> 1 0-17      11998646
#> 2 18-64     34908590
#> 3 65+       10783087
```
