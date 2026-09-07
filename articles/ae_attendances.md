# Dataset: Accident and Emergency attendances

*Edited by Zoë Turner 28 August 2026*

This vignette explains how to use the `ae_attendances` dataset in R, and
also details where it comes from and how it is generated.

The data is sourced from [NHS England Statistical Work
Areas](https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/)
and is available under the [Open Government Licence
v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).

The data contains all reported A&E attendances for the period April 2016
through March 2019

The dataset contains:

- **period:** date the month that this activity relates to, stored as a
  date (1st of each month) in the universal format of yyyy-mm-dd
- **org_code:** factor of
  [ODS](https://digital.nhs.uk/services/organisation-data-service) code
  for the organisation that this activity relates to
- **type:** factor the [Department
  Type](https://web.archive.org/web/20200128111444/https://www.datadictionary.nhs.uk/data_dictionary/attributes/a/acc/accident_and_emergency_department_type_de.asp)
  for this activity, either 1, 2, or other
- **attendances:** number of the number of attendances for this
  department type at this organisation for this month
- **breaches:** number of the number of attendances that breached the 4
  hour target
- **admissions:** number of the number of attendances that resulted in
  an admission to the hospital

## First, load the data and inspect it

``` r

library(scales)
library(ggrepel)
#> Loading required package: ggplot2
library(lubridate)
#> 
#> Attaching package: 'lubridate'
#> The following objects are masked from 'package:base':
#> 
#>     date, intersect, setdiff, union
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(forcats)
library(tidyr)
library(kableExtra)
#> 
#> Attaching package: 'kableExtra'
#> The following object is masked from 'package:dplyr':
#> 
#>     group_rows
library(NHSRdatasets)

ae_attendances <- NHSRdatasets::ae_attendances

ae_attendances |>
  dplyr::mutate(
    # set the period column to show in Month-Year as a character format
    period = format(period, "%b-%y"),
    # set the numeric columns to have a comma at the 1000's place
    dplyr::across(
      c(attendances, breaches, admissions),
      scales::comma
    )
  ) |>
  # show the first 10 rows
  head(10) |>
  # format for display
  kableExtra::kable()
```

| period | org_code | type  | attendances | breaches | admissions |
|:-------|:---------|:------|:------------|:---------|:-----------|
| Mar-17 | RF4      | 1     | 21,289      | 2,879    | 5,060      |
| Mar-17 | RF4      | 2     | 813         | 22       | 0          |
| Mar-17 | RF4      | other | 2,850       | 6        | 0          |
| Mar-17 | R1H      | 1     | 30,210      | 5,902    | 6,943      |
| Mar-17 | R1H      | 2     | 807         | 11       | 0          |
| Mar-17 | R1H      | other | 11,352      | 136      | 0          |
| Mar-17 | AD913    | other | 4,381       | 2        | 0          |
| Mar-17 | RYX      | other | 19,562      | 258      | 0          |
| Mar-17 | RQM      | 1     | 17,414      | 2,030    | 3,597      |
| Mar-17 | RQM      | other | 7,817       | 86       | 0          |

We can calculate the 4 hours performance for England as a whole like so:

``` r

england_performance <- ae_attendances |>
  dplyr::group_by(period) |>
  dplyr::summarise(
    dplyr::across(c(attendances, breaches), sum),
    .groups = "drop"
  ) |>
  dplyr::mutate(
    performance = 1 - breaches / attendances
  )

# format for display
england_performance |>
  dplyr::mutate(
    # same format options as above
    period = format(period, "%b-%y"),
    dplyr::across(c(attendances, breaches), scales::comma),
    # this time show the performance column as a percentage
    performance = scales::percent(performance)
  ) |>
  # show the first 10 rows and format as a table
  head(10) |>
  kableExtra::kable()
```

| period | attendances | breaches | performance |
|:-------|:------------|:---------|:------------|
| Apr-16 | 1,867,781   | 186,122  | 90.0351%    |
| May-16 | 2,070,340   | 201,329  | 90.2756%    |
| Jun-16 | 1,958,802   | 184,912  | 90.5599%    |
| Jul-16 | 2,079,034   | 201,973  | 90.2852%    |
| Aug-16 | 1,932,901   | 174,419  | 90.9763%    |
| Sep-16 | 1,952,464   | 182,597  | 90.6479%    |
| Oct-16 | 2,001,816   | 219,137  | 89.0531%    |
| Nov-16 | 1,907,871   | 221,713  | 88.3790%    |
| Dec-16 | 1,944,567   | 268,818  | 86.1759%    |
| Jan-17 | 1,895,272   | 281,612  | 85.1413%    |

We can now plot the monthly performance

``` r

ggplot2::ggplot(england_performance, ggplot2::aes(period, performance)) +
  ggplot2::geom_line() +
  ggplot2::geom_point() +
  ggplot2::scale_y_continuous(labels = scales::percent) +
  ggplot2::labs(
    x = "Month of attendance",
    y = "% of attendances that met the 4 hour standard",
    title = "NHS England A&E 4 Hour Performance",
    caption = "Source: NHS England Statistical Work Areas (OGL v3.0)"
  )
```

![](ae_attendances_files/figure-html/england%20performance%20plot-1.png)

We can clearly see the “Winter Pressures” where performance drops.

We can also inspect performance for the [different types of
department](https://web.archive.org/web/20200128111444/https://www.datadictionary.nhs.uk/data_dictionary/attributes/a/acc/accident_and_emergency_department_type_de.asp):

``` r

ae_attendances |>
  dplyr::group_by(period, type) |>
  dplyr::summarise_if(is.numeric, sum) |>
  dplyr::mutate(performance = 1 - breaches / attendances) |>
  ggplot2::ggplot(ggplot2::aes(period, performance, colour = type)) +
  ggplot2::geom_line() +
  ggplot2::geom_point() +
  ggplot2::scale_y_continuous(labels = scales::percent) +
  # facet_wrap(vars(type), nrow = 1) +
  ggplot2::theme(legend.position = "bottom") +
  ggplot2::labs(
    x = "Month of attendance",
    y = "% of attendances that met the 4 hour standard",
    title = "NHS England A&E 4 Hour Performance",
    subtitle = "By Department Type",
    caption = "Source: NHS England Statistical Work Areas (OGL v3.0)"
  )
```

![](ae_attendances_files/figure-html/england%20performance%20by%20type-1.png)

From this it appears as if only the type 1 departments have the seasonal
drops, type 2 and “other” departments remain pretty consistent.

## What are the best and worst trusts for performance?

We could create a similar table of data for performance by each
individual trust, but it would be useful to only look at trusts that
have a type 1 department as it appears from the chart above that these
departments have the largest variation.

``` r

performance_by_trust <- ae_attendances |>
  dplyr::group_by(org_code, period) |>
  # make sure that this trust has a type 1 department
  dplyr::filter(any(type == 1)) |>
  dplyr::summarise(
    dplyr::across(
      c(attendances, breaches),
      ~ sum(.x, na.rm = TRUE)
    ),
    .groups = "drop"
  ) |>
  dplyr::mutate(
    performance = 1 - breaches / attendances
  )

# format for display
performance_by_trust |>
  dplyr::mutate(
    period = format(period, "%b-%y"),
    dplyr::across(c(attendances, breaches), scales::comma),
    performance = scales::percent(performance)
  ) |>
  head(10) |>
  kableExtra::kable()
```

| org_code | period | attendances | breaches | performance |
|:---------|:-------|:------------|:---------|:------------|
| R0A      | Oct-17 | 35,744      | 3,663    | 89.7521262% |
| R0A      | Nov-17 | 34,314      | 3,982    | 88.3954071% |
| R0A      | Dec-17 | 34,082      | 5,430    | 84.0678364% |
| R0A      | Jan-18 | 33,758      | 4,906    | 85.4671485% |
| R0A      | Feb-18 | 30,520      | 4,111    | 86.5301442% |
| R0A      | Mar-18 | 35,233      | 5,496    | 84.4009877% |
| R0A      | Apr-18 | 33,127      | 3,809    | 88.5018263% |
| R0A      | May-18 | 35,797      | 4,792    | 86.6134034% |
| R0A      | Jun-18 | 34,070      | 3,616    | 89.3865571% |
| R0A      | Jul-18 | 35,081      | 4,723    | 86.5368718% |

From this table we can calculate the overall performance by each trust
and then organise the trusts by their overall performance.

``` r

performance_by_trust_ranking <- performance_by_trust |>
  dplyr::summarise(performance = 1 - sum(breaches) / sum(attendances), .by = org_code) |>
  dplyr::arrange(performance) |>
  dplyr::pull(org_code) |>
  as.character()

print("Bottom 5")
#> [1] "Bottom 5"
head(performance_by_trust_ranking, 5)
#> [1] "RQW" "RWD" "RXW" "RX1" "RHU"

print("Top 5")
#> [1] "Top 5"
tail(performance_by_trust_ranking, 5)
#> [1] "RA4" "RBD" "RVW" "RCU" "RC9"
```

``` r

performance_by_trust |>
  dplyr::mutate(
    org_code = forcats::fct_relevel(
      org_code,
      performance_by_trust_ranking
    )
  ) |>
  dplyr::filter(org_code %in% c(
    head(performance_by_trust_ranking, 5),
    tail(performance_by_trust_ranking, 5)
  )) |>
  ggplot2::ggplot(ggplot2::aes(period, performance)) +
  ggplot2::geom_line() +
  ggplot2::geom_point() +
  ggplot2::scale_y_continuous(labels = scales::percent) +
  ggplot2::facet_wrap(ggplot2::vars(org_code), nrow = 2) +
  ggplot2::theme(legend.position = "bottom") +
  ggplot2::labs(
    x = "Month of attendance",
    y = "% of attendances that met the 4 hour standard",
    title = "NHS England A&E 4 Hour Performance",
    subtitle = "Bottom 5/Top 5 over the whole 3 years",
    caption = "Source: NHS England Statistical Work Areas (OGL v3.0)"
  )
```

![](ae_attendances_files/figure-html/performance_by_trust%20top%205%20bottom%205%20plot-1.png)

## Benchmarking

It is sometimes useful to see how an organisation stacks up against all
of the other organisations. Below we create a chart where each
organisation is shown as a point, ordered by performance from left
(highest performance) to right (lowest) performance.

It’s useful to indicate certain organisations on the chart, below I am
showing the 3 organisations that are at the lower quartile, median and
upper quartile, however you could change this to instead pick out
specific organisations (using a reference table and `left_join` or hard
coding with `case_when`).

``` r

ae_attendances |>
  dplyr::filter(period == last(period)) |>
  dplyr::group_by(org_code) |>
  dplyr::filter(any(type == 1)) |>
  dplyr::summarise_at(vars(attendances, breaches), sum) |>
  dplyr::mutate(
    performance = 1 - breaches / attendances,
    overall_performance = 1 - sum(breaches) / sum(attendances),
    org_code = forcats::fct_reorder(org_code, -performance)
  ) |>
  #
  dplyr::arrange(performance) |>
  # lets highlight the organsiations that are at the lower and upper quartile
  # and at the median. First "tile" the data into 4 groups, then we use the
  # lag function to check to see if the value changes between rows. We will get
  # NA for the first row, so replace this with FALSE
  dplyr::mutate(
    highlight = ntile(n = 4),
    highlight = tidyr::replace_na(highlight != lag(highlight), FALSE)
  ) |>
  ggplot2::ggplot(ggplot2::aes(org_code, performance)) +
  ggplot2::geom_hline(ggplot2::aes(yintercept = overall_performance)) +
  ggplot2::geom_point(ggplot2::aes(fill = highlight), show.legend = FALSE, pch = 21) +
  ggrepel::geom_text_repel(ggplot2::aes(label = ifelse(highlight, as.character(org_code), NA)),
    na.rm = TRUE
  ) +
  ggplot2::scale_fill_manual(values = c(
    "TRUE" = "black",
    "FALSE" = NA
  )) +
  ggplot2::scale_y_continuous(labels = scales::percent) +
  ggplot2::theme_minimal() +
  ggplot2::theme(
    panel.grid = ggplot2::element_blank(),
    axis.text.x = ggplot2::element_blank(),
    axis.line = ggplot2::element_line(),
    axis.ticks.y = ggplot2::element_line()
  )
```

![](ae_attendances_files/figure-html/bencmarking%20plot-1.png)
