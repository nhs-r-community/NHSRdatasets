## Updates in this release

- Additional datasets in this version
- Additional documentation in vignettes to support the datasets use
- Change in maintainer - the email for the current maintainer fails as the 
account has been closed (it was chris.mainey@nhs.net and updated in DESCRIPTION 
to chris.mainey1@nhs.net). Change to zoe.turner3@nhs.net who has been a package
developer previously and will now be maintainer. 


## check results on local installation
There were no ERRORs, WARNINGS or NOTES on the following local installation:

* Windows 11 install using R 4.5.1
* Windows 11 install using R 4.6.1

## Other Test Environments

GitHub actions all passed running R-CMD-check on the following platforms:

* macOS-latest (release)
* ubuntu-latest (devel)
* ubuntu-latest (oldrel-1)
* ubuntu-latest (release)
* windows-latest (release)

devtools::check(remote = TRUE, manual = TRUE) and devtools::check_win_*
detail change in maintainer as NOTE and url service unavailable for 
https://www.aphanalysts.org/ which is currently down for maintenance (expected
back Sept 2026).

## Downstream dependencies

revdepcheck::revdep_check() shows no downstream dependencies.
