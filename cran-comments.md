## Release summary
This is the first release of a collaborative dataset packaged for British National Health Services NHS-R community. It contains datasets and vignettes to teach R.  It is likely to see periodic releases as we receive contributions.

## Test environments
* local windows 7, R 3.6.1
* local windows 10, R 3.6.1
* ubuntu 16.04.6 LTS (on travis-ci), R 3.6.1
* win-builder(devel)
* r-hub:
  * Ubuntu Linux 16.04 LTS, R-release, GCC, fedora-clang-devel
  * Fedora Linux, R-devel, clang, gfortran
  
Currently error on Solaris via R-hub, but nowhere else as 'Modelmetric' package, used in a vignette, is not available on their Solaris R build. Builds correctly with no errors on all other platforms.

## R CMD check results
There were no ERRORs, WARNINGs OR NOTES.

## Downstream dependencies
There are currently no downstream dependencies for this package.
