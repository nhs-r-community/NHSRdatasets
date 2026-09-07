# NHS-R Community Datasets ![Package logo showing a small coloured outline of a spreadsheet table](https://raw.githubusercontent.com/nhs-r-community/NHSRdatasets/main/inst/images/nhsrdatasetslogo.png)

[![NHS-R Community
logo](https://nhs-r-community.github.io/assets/logo/nhsr-logo.png)](https://nhsrcommunity.com/).

[![All
Contributors](https://img.shields.io/github/all-contributors/nhs-r-community/NHSRDatasets?color=ee8449&style=flat-square)](#contributors)

  
  

## Data sources for reuse

This package has been created to help NHS, Public Health and related
analysts/data scientists learn to use `R`. It contains several free
datasets, with documentation and many of the examples of the use can be
found in the training materials from NHS-OA (formerly NHS-R Community).

We encourage contributions to the package, both to expand the set of
training material, and also as development for newer `R`/github users as
a first or early contribution.  
Please add relevant free, open source data sets that you think may
benefit the NHS-R Community.

## Installation instructions

You can install the package from [CRAN](https://CRAN.R-project.org) with
R code:

``` r

install.packages("NHSRdatasets")
```

To install the development version from [GitHub](https://github.com/)
with:

``` r

# install.packages("pak")
pak::pkg_install("nhs-r-community/NHSRdatasets")
```

Once installed go to the Get Started article from the
[website](https://nhs-r-community.github.io/NHSRdatasets/%60vignette(%22NHSRdatasets%22))
(the same link can be found on the top right of the GitHub Repository).

## Datasets available

As this R package is `static` and does not use an API or any other code
to dynamically provide information data can be accessed directly through
GitHub from the `.rda` files which are stored in the `data` folder.

The code used to produce some of these `.rda` files has been included as
vignettes. Note that some of this may be out of date or links are
unavailable so this is included only for reference.

## Contributing

Please see our [guidance on how to
contribute](https://tools.nhsrcommunity.com/contribution.html).

This project is released with a Contributor [Code of
Conduct](https://nhs-r-community.github.io/NHSRdatasets/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.

When contributing a dataset, the contributor certifies that:

- They are the data owner, or are authorised to republish the dataset in
  question.
- The dataset does not contain real patient-level or any other sensitive
  data.
- Where it is based on sensitive or patient data, the contributor takes
  full responsibility for sharing the data and certifies that it has
  been processed, anonymised, aggregated or otherwise protected in
  accordance with all legal requirements under General Data Protection
  Regulation (GDPR), or other relevant legislation.

# Citation

It’s great to see the NHSRdatasets package and data used as it promotes
the work of the NHS-R Community so, where it’s relevant and makes sense,
please give us a mention!

## Users of the mortality dataset:

The data used to build the mortality dataset in this package is released
under © Crown copyright and is free to use under the terms of the Open
Government Licence. Any subsequent use should include a source
accreditation to ONS to help people find the original releases and any
statistical corrections that may have occurred since this was included
in this package

> Source: Office for National Statistics licensed under the Open
> Government Licence.

## Changes to NHS-R Community

All references in this package are to NHS-R Community, however, from
2025 NHS-R Community and NHS Pycom started a merge to become NHS Open
Analytics. At the time of updating this package the current move to NHS
Open Analytics is ongoing.

## Contributors

[TABLE]
