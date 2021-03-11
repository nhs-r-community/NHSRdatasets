## Release summary
This is the fourth release of a collaborative dataset package for British National Health Services NHS-R community. It contains datasets and vignettes to teach R in a familiar context.  It is likely to see periodic releases as we receive contributions.

## Test environments
* local windows 10, R 4.0.3
* local windows 10, R 4.0.4
* local WSL2 Ubuntu 20.04.02, R 4.0.4
* Mac OS X 10.15.7, R 4.0.4 (GitHub Actions)
* ubuntu 16.04.6 LTS (Travis-ci), R 4.0.2
* win-builder(devel)
* r-hub:
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit
  * Ubuntu Linux 16.04 LTS, R-release, GCC
  * Fedora Linux, R-devel, clang, gfortran
  

## R CMD check results
There were no ERRORs or WARNINGs, with NOTES:

New maintainer: change of email address for current maintainer

Namespace in Imports field not imported from: 'tibble'
     All declared Imports should be used.
This is a data package with serialised data from saved tibbles, so tibble requirement not detected.

No linux errors locally, on github actions or Travis, but PREPERROR on R-Hub that seems to be about how docker is functioning, rather than the package itself.
     
## Downstream dependencies
There are no known downstream dependencies for this package.
