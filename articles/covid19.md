# Dataset: Covid19

``` r

library(NHSRdatasets)

covid19 <- NHSRdatasets::covid19
```

This vignette details why the `covid19` dataset was created, how to load
it and an example of how to use the `stringr` package to search for
countries and territories.

The dataset contains:

- **date_reported:** Date in the universal format yyyy-mm-dd
- **continent:** Factor
- **countries_and_territories:** factor
- **country_territory_code:** factor
- **population_2019:** integer
- **cases:** integer
- **deaths:** integer

## Covid19 data

This data was included in the package in August 2021.

The information was collected at the time from [European Centre for
Disease Prevention and
Control](https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide)
and the page is still available but archived (as of August 2026). The
data was made available under the open licence, compatible with the CC
BY 4.0 license, further details available at
[ECDC](https://www.ecdc.europa.eu/en/copyright).

Data were collated and published up to 14th December 2020, and was
tidied before submission (no script for that work is available).

## Using the data

Using the `stringr` package to find parts of a word we’ll look for
countries and territories which have the word “and” in them

``` r

covid19 |>
  dplyr::filter(stringr::str_detect(countries_and_territories, "and")) |>
  dplyr::distinct(countries_and_territories) |>
  head(5)
#> # A tibble: 5 × 1
#>   countries_and_territories        
#>   <fct>                            
#> 1 Antigua_and_Barbuda              
#> 2 Bonaire, Saint Eustatius and Saba
#> 3 Bosnia_and_Herzegovina           
#> 4 British_Virgin_Islands           
#> 5 Cayman_Islands
```

Luckily, in this top 5 we can see that “and” appears with underscores
either side, with spaces either side and also appears as part of the
name, for example Isl**and**s.

Knowing that “and” can be surrounded by spaces or underscores we could
search for those two formats

``` r

covid19 |>
  # rather than having two separate filters which is "AND" and returns nothing the code uses | for "OR"
  dplyr::filter(stringr::str_detect(countries_and_territories, "_and_") |
    stringr::str_detect(countries_and_territories, " and ")) |>
  dplyr::distinct(countries_and_territories)
#> # A tibble: 9 × 1
#>   countries_and_territories        
#>   <fct>                            
#> 1 Antigua_and_Barbuda              
#> 2 Bonaire, Saint Eustatius and Saba
#> 3 Bosnia_and_Herzegovina           
#> 4 Saint_Kitts_and_Nevis            
#> 5 Saint_Vincent_and_the_Grenadines 
#> 6 Sao_Tome_and_Principe            
#> 7 Trinidad_and_Tobago              
#> 8 Turks_and_Caicos_islands         
#> 9 Wallis_and_Futuna
```

Just to check that “and” never occurs as “And” which R would see as
distinct to “and” we could look for that but we can also make all text
lowercase before searching

``` r

covid19 |>
  dplyr::mutate(countries_and_territories = tolower(countries_and_territories)) |>
  dplyr::filter(stringr::str_detect(countries_and_territories, "_and_") |
    stringr::str_detect(countries_and_territories, " and ")) |>
  dplyr::distinct(countries_and_territories)
#> # A tibble: 9 × 1
#>   countries_and_territories        
#>   <chr>                            
#> 1 antigua_and_barbuda              
#> 2 bonaire, saint eustatius and saba
#> 3 bosnia_and_herzegovina           
#> 4 saint_kitts_and_nevis            
#> 5 saint_vincent_and_the_grenadines 
#> 6 sao_tome_and_principe            
#> 7 trinidad_and_tobago              
#> 8 turks_and_caicos_islands         
#> 9 wallis_and_futuna
```

That brings back the same number of countries and territories but given
that the text is likely to be printed and read we don’t want to keep the
text as lower case but are more likely to want to remove the underscore

``` r

covid19 |>
  dplyr::filter(stringr::str_detect(countries_and_territories, "_and_") |
    stringr::str_detect(countries_and_territories, " and ")) |>
  dplyr::distinct(countries_and_territories) |>
  dplyr::mutate(countries_and_territories = stringr::str_replace(countries_and_territories, "_", ""))
#> # A tibble: 9 × 1
#>   countries_and_territories        
#>   <chr>                            
#> 1 Antiguaand_Barbuda               
#> 2 Bonaire, Saint Eustatius and Saba
#> 3 Bosniaand_Herzegovina            
#> 4 SaintKitts_and_Nevis             
#> 5 SaintVincent_and_the_Grenadines  
#> 6 SaoTome_and_Principe             
#> 7 Trinidadand_Tobago               
#> 8 Turksand_Caicos_islands          
#> 9 Wallisand_Futuna
```

`str_replace` removes the first underscore in the text because it
replaces only the first match. To replace all instances of `_` which is
what we’d want in this case we need to use `str_replace_all`

``` r

covid19 |>
  dplyr::filter(stringr::str_detect(countries_and_territories, "_and_") |
    stringr::str_detect(countries_and_territories, " and ")) |>
  dplyr::distinct(countries_and_territories) |>
  dplyr::mutate(countries_and_territories = stringr::str_replace_all(countries_and_territories, "_", " "))
#> # A tibble: 9 × 1
#>   countries_and_territories        
#>   <chr>                            
#> 1 Antigua and Barbuda              
#> 2 Bonaire, Saint Eustatius and Saba
#> 3 Bosnia and Herzegovina           
#> 4 Saint Kitts and Nevis            
#> 5 Saint Vincent and the Grenadines 
#> 6 Sao Tome and Principe            
#> 7 Trinidad and Tobago              
#> 8 Turks and Caicos islands         
#> 9 Wallis and Futuna
```

## Other places to see this data used

The NHS-R Community [Introduction to
Quarto](https://intro-quarto.nhsrcommunity.com/) course uses this
dataset to show how to use parameters in Quarto for reports. Simple code
is available in a [data
repository](https://github.com/nhs-r-community/intro_quarto_data/blob/main/covid-analysis.qmd)
and the course works through the steps to produce Covid19 reports for
different countries and territories.
