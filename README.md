
# NHS-R Community Datasets <img alt="Package logo showing a small coloured outline of a spreadsheet table" src="https://raw.githubusercontent.com/nhs-r-community/NHSRdatasets/main/inst/images/nhsrdatasetslogo.png" width="120" align="right" />

<a href='https://nhsrcommunity.com/'><img alt="NHS-R Community logo" src='https://nhs-r-community.github.io/assets/logo/nhsr-logo.png' width="100"/></a>.

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->

[![All
Contributors](https://img.shields.io/github/all-contributors/nhs-r-community/NHSRDatasets?color=ee8449&style=flat-square)](#contributors)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![CRAN
version](https://www.r-pkg.org/badges/version/NHSRdatasets)](https://cran.r-project.org/package=NHSRdatasets)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/NHSRdatasets)](https://cran.r-project.org/package=NHSRdatasets)
[![R-CMD-check](https://github.com/nhs-r-community/NHSRdatasets/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/nhs-r-community/NHSRdatasets/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

<br><br>

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
[website](https://nhs-r-community.github.io/NHSRdatasets) (the same link
can be found on the top right of the GitHub Repository).

## Datasets available

As this R package is `static` and does not use an API or any other code
to dynamically provide information data can be accessed directly through
GitHub from the `.rda` files which are stored in the `data` folder.

The code used to produce these `.rda` files is in the folder `data-raw`.
Note that some of this may be out of date or links are unavailable so
this is included only for reference.

## Contributing

Please see our [guidance on how to
contribute](https://tools.nhsrcommunity.com/contribution.html).

This project is released with a Contributor [Code of
Conduct](./CODE_OF_CONDUCT.md). By contributing to this project, you
agree to abide by its terms.

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

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->

<!-- prettier-ignore-start -->

<!-- markdownlint-disable -->

<table>

<tbody>

<tr>

<td align="center" valign="top" width="14.28%">

<a href="https://philosopher-analyst.netlify.app/"><img src="https://avatars.githubusercontent.com/u/39963221?v=4?s=100" width="100px;" alt="Zoë Turner"/><br /><sub><b>Zoë
Turner</b></sub></a><br /><a href="https://github.com/nhs-r-community/NHSRdatasets/commits?author=Lextuga007" title="Code">💻</a>
<a href="https://github.com/nhs-r-community/NHSRdatasets/commits?author=Lextuga007" title="Documentation">📖</a>
<a href="#maintenance-Lextuga007" title="Maintenance">🚧</a>
</td>

<td align="center" valign="top" width="14.28%">

<a href="https://github.com/francisbarton"><img src="https://avatars.githubusercontent.com/u/1819920?v=4?s=100" width="100px;" alt="Fran Barton"/><br /><sub><b>Fran
Barton</b></sub></a><br /><a href="https://github.com/nhs-r-community/NHSRdatasets/commits?author=francisbarton" title="Code">💻</a>
<a href="#data-francisbarton" title="Data">🔣</a>
</td>

<td align="center" valign="top" width="14.28%">

<a href="https://rhian.rbind.io"><img src="https://avatars.githubusercontent.com/u/7017740?v=4?s=100" width="100px;" alt="Rhian Davies"/><br /><sub><b>Rhian
Davies</b></sub></a><br /><a href="#maintenance-StatsRhian" title="Maintenance">🚧</a>
</td>

<td align="center" valign="top" width="14.28%">

<a href="https://github.com/chrismainey"><img src="https://avatars.githubusercontent.com/u/39626211?v=4?s=100" width="100px;" alt="Chris Mainey"/><br /><sub><b>Chris
Mainey</b></sub></a><br /><a href="https://github.com/nhs-r-community/NHSRdatasets/commits?author=chrismainey" title="Code">💻</a>
</td>

<td align="center" valign="top" width="14.28%">

<a href="https://tjmt.uk/"><img src="https://avatars.githubusercontent.com/u/12023696?v=4?s=100" width="100px;" alt="Tom Jemmett"/><br /><sub><b>Tom
Jemmett</b></sub></a><br /><a href="https://github.com/nhs-r-community/NHSRdatasets/commits?author=tomjemmett" title="Code">💻</a>
</td>

<td align="center" valign="top" width="14.28%">

<a href="https://github.com/cathblatter"><img src="https://avatars.githubusercontent.com/u/24943957?v=4?s=100" width="100px;" alt="Cath Blatter"/><br /><sub><b>Cath
Blatter</b></sub></a><br /><a href="https://github.com/nhs-r-community/NHSRdatasets/issues?q=author%3Acathblatter" title="Bug reports">🐛</a>
</td>

<td align="center" valign="top" width="14.28%">

<a href="https://github.com/MHWauben"><img src="https://avatars.githubusercontent.com/u/38880899?v=4?s=100" width="100px;" alt="Martine Wauben"/><br /><sub><b>Martine
Wauben</b></sub></a><br /><a href="https://github.com/nhs-r-community/NHSRdatasets/commits?author=MHWauben" title="Documentation">📖</a>
</td>

</tr>

<tr>

<td align="center" valign="top" width="14.28%">

<a href="http://hutsons-hacks.info/"><img src="https://avatars.githubusercontent.com/u/44023992?v=4?s=100" width="100px;" alt="Gary Hutson"/><br /><sub><b>Gary
Hutson</b></sub></a><br /><a href="#data-StatsGary" title="Data">🔣</a>
</td>

<td align="center" valign="top" width="14.28%">

<a href="https://github.com/jasonpott"><img src="https://avatars.githubusercontent.com/u/43917006?v=4?s=100" width="100px;" alt="Jason Pott"/><br /><sub><b>Jason
Pott</b></sub></a><br /><a href="https://github.com/nhs-r-community/NHSRdatasets/commits?author=jasonpott" title="Documentation">📖</a>
</td>

<td align="center" valign="top" width="14.28%">

<a href="https://github.com/jacgrout"><img src="https://avatars.githubusercontent.com/u/103451105?v=4?s=100" width="100px;" alt="Jacqueline Grout"/><br /><sub><b>Jacqueline
Grout</b></sub></a><br /><a href="#data-jacgrout" title="Data">🔣</a>
</td>

<td align="center" valign="top" width="14.28%">

<a href="https://github.com/anyaferguson"><img src="https://avatars.githubusercontent.com/u/157487567?v=4?s=100" width="100px;" alt="Anya Ferguson"/><br /><sub><b>Anya
Ferguson</b></sub></a><br /><a href="#design-anyaferguson" title="Design">🎨</a>
</td>

</tr>

</tbody>

</table>

<!-- markdownlint-restore -->

<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
