# NHSRdatasets 0.3.3

- Moved the vignette for how ONS provisionally recorded deaths to an R script
available in the data-raw folder. 
This is also available on the Quarto NHS-R Community website and 
[GitHub](https://github.com/nhs-r-community/nhs-r-community/blob/main/blog/building-the-ons-mortality-dataset.qmd)
- Noted in this version the previous addition of the dataset from AphA (with kind 
permission) from their CPD Survey, thanks to Fran Barton. Code detailing how the
data was extracted using the httr2 package and tidied can be found in the 
[data-raw folder](https://github.com/nhs-r-community/NHSRdatasets/blob/main/data-raw/apha_cpd_survey.R).
- Noted in this version the previous addition of the dataset from European 
Centre for Disease Prevention and Control for reported COVID19 infections and 
deaths by day and country collected on the 14th December 2020, thanks to Chris
Mainey.

# NHSRdatasets 0.3.0

- Added two new datasets for 'stranded patients' and synthetic early warning 
scores (NEWS), including vignettes, thanks to Gary Hutson.
- Removed Travis and added GitHub actions

# NHSRdatasets 0.2.0

- Added a new ONS Mortality data set, and vignette showing its construction, 
thanks to Zoë Turner.
- Resaved .Rdata files as rda, using "gzip" compression.
- Other minor documentation tweaks.

# NHSRdatasets 0.1.2

- Added a new NHS Accident and Emergency (A&E) dataset with vignette, thanks to 
Tom Jemmett.
- Typos resolved and cleaned some files.
- Added pkgdown site.

# NHSRdatasets 0.1.1

- This is the first release of this collaborative package for NHS and healthcare 
analysts to learn or teach R.
It will evolve over time as new contributions are released.
