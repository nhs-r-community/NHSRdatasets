# Deaths registered weekly in England and Wales, provisional

Provisional counts of the number of deaths registered in England and
Wales, by age, sex and region, from week commencing 8th January 2010 to
3rd April 2020.

## Usage

``` r
data(ons_mortality)
```

## Format

Data frame with five columns

- category_1:

  character, containing the names of the groups for counts, for example
  "Total deaths", "all ages".

- category_2:

  character, subcategory of names of groups where necessary, for example
  details of region: "East", details of age bands "15-44".

- counts:

  numeric, numbers of deaths in whole numbers and average numbers with
  decimal points. To retain the integrity of the format this column data
  is left as character.

- date:

  date, format is yyyy-mm-dd; all dates are a Friday.

- week_no:

  integer, each week in a year is numbered sequentially.

## Source

Collected by Zoë Turner, Apr-2020 from
<https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/weeklyprovisionalfiguresondeathsregisteredinenglandandwales>

## Details

Source and licence acknowledgement

This data has been made available through Office of National Statistics
under the Open Government Licence
<https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/>

## Examples

``` r
data(ons_mortality)

library(dplyr)
library(tidyr)

# create a dataset that is "wide" with each date as a column
ons_mortality |>
  select(-week_no) |>
  pivot_wider(
    names_from = date,
    values_from = counts
  )
#> # A tibble: 97 × 537
#>    category_1     category_2 `2010-01-08` `2010-01-15` `2010-01-22` `2010-01-29`
#>    <chr>          <chr>             <dbl>        <dbl>        <dbl>        <dbl>
#>  1 Total deaths   all ages          12968        12541       11762        11056 
#>  2 Total deaths   average o…        12050        12600       11692.       11069.
#>  3 All respirato… v 2001             2345         2293        1955         1698 
#>  4 Persons        Under 1 y…           61           69          66           68 
#>  5 Persons        01-14                24           29          18           21 
#>  6 Persons        15-44               299          331         347          336 
#>  7 Persons        45-64              1570         1465        1392         1300 
#>  8 Persons        65-74              2049         1860        1781         1666 
#>  9 Persons        75-84              3952         3883        3501         3359 
#> 10 Persons        85+                5012         4902        4654         4305 
#> # ℹ 87 more rows
#> # ℹ 531 more variables: `2010-02-05` <dbl>, `2010-02-12` <dbl>,
#> #   `2010-02-19` <dbl>, `2010-02-26` <dbl>, `2010-03-05` <dbl>,
#> #   `2010-03-12` <dbl>, `2010-03-19` <dbl>, `2010-03-26` <dbl>,
#> #   `2010-04-02` <dbl>, `2010-04-09` <dbl>, `2010-04-16` <dbl>,
#> #   `2010-04-23` <dbl>, `2010-04-30` <dbl>, `2010-05-07` <dbl>,
#> #   `2010-05-14` <dbl>, `2010-05-21` <dbl>, `2010-05-28` <dbl>, …
```
