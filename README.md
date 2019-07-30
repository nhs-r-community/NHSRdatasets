
# NHS R-community Datasets <a href='https://nhsrcommunity.com/'><img src='assets/logo.png' align="right" height="80" /></a>

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)]

<br><br>

## This package is a work in progress, and may change or be withdrawn

## Datasources for reuse

This package has been created to help NHS, Public Health and related
analysts/data scientists learn to use `R`. It contains several free
datasets (just one at the moment), help files explaining their
structure, and `vignette` examples of their use. We encourage
contributions to the package, both to expand the set of training
material, but also as development for newer `R`/github users as a first
contribution. Please add relevant free, open source data sets that you
think may benefit the NHS R-community.

## Installation instructions

This packages is not yet submitted to CRAN, but can be installed from
source, via this Github repository. You will need `Rtools`
(<https://cran.r-project.org/bin/windows/Rtools/>) installed to build
the package, and the `remotes`
package.

``` r
remotes::install_github("https://github.com/nhs-r-community/NHSRdatasets")
```

## Contribution

Please contribute to this repository, and please cite it when you use it
in training or publications.

**To contribute, please:**

  - Fork the repository.
  - Add your dataset in the `data` folder, in `.RData` format.
  - Please add a minimal `R` function to act as a help file. You can use
    the `LOS_model` as a guide.
  - Consider adding a `vignette` demonstrating how the data has been
    used previously.
  - Create a pull request, detailing your additions, and we will review
    it before merging.

<br> ***When contributing a dataset, the contributor certifies that:***

  - They are the data owner, or are authorised to republish the dataset
    in question.
  - The dataset does not contain real patient-level data.
  - Where based on patient data, the contributor takes full
    responsibility for sharing the data and certifies that. it is has
    been processed, anonymised, aggregated or otherwise protected in
    accordance with all legal requirements under General Data Protection
    Regulation (GDPR), or other relevant legislation.
