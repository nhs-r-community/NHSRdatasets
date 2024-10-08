% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/synthetic_news_data.R
\docType{data}
\name{synthetic_news_data}
\alias{synthetic_news_data}
\title{Synthetic National Early Warning Scores Data}
\format{
Tibble with twelve columns
\describe{
\item{male}{character string containing gender code}
\item{age}{age of patient}
\item{NEWS}{National Early Warning Score (NEWS)}
\item{syst}{Systolic BP - Systolic BP result}
\item{dias}{Diastolic Blood Pressure - result on NEWS scale}
\item{temp}{Temperature of patient}
\item{pulse}{Pulse of the patient}
\item{resp}{Level of response from the patient}
\item{sat}{SATS(Oxygen Saturation Levels) of the patient}
\item{sup}{Suppressed Oxygen score}
\item{alert}{Level of alertness of patient}
\item{died}{Indicator to monitor patient death}
}
}
\source{
Generated by Dr. Muhammed Faisal and created by Gary Hutson, Mar-2021
}
\usage{
data(synthetic_news_data)
}
\description{
Synthetic NEWS data to show as the results of the NHSR_synpop package.
These datasets have been synthetically generated by this package to be
utilised in the NHSRDatasets package.
}
\examples{

library(dplyr)

data("synthetic_news_data")

synthetic_news_data |>
  glimpse()
}
\keyword{datasets}
\keyword{synthetic_news_data}
