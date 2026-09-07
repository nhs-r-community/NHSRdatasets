# Dataset: AphA CPD Survey

``` r

library(NHSRdatasets)
library(tibble)
library(purrr)

apha_cpd_survey <- NHSRdatasets::apha_cpd_survey
```

This vignette details why the `apha_cpd_survey` dataset was created and
how to load it with some details on how to view some of the data. For
code used to extract and clean the data can be found in
[`vignette("create_apha_cpd_survey")`](https://nhs-r-community.github.io/NHSRdatasets/articles/create_apha_cpd_survey.md).

The dataset contains:

- **respondent_id:** integer unique id for each respondent
- **form_started_dttm:** date time
- **form_ended_dttm:** date time
- **q00a_age_bracket_cat:** character of age brackets
- **q01a_gender_cat:** character for Male, Female and Prefer not to say
- **q02a_max_education_level_cat:** character
- **q03a_analyst_years_n:** character
- **q04a_role_description_cat:** character freetext
- **q05a_afc_band_cat:** character
- **q06a_current_org_years_cat:** character
- **q07a_future_health_work_cat:** character
- **q08a_apha_aware_ind:** character
- **q09a_apha_registered_cat:** character
- **q10a_other_org_member_txt:** character
- **q11a_nhs_cpd_aware_cat:** character
- **q12a_cpd_time_at_work_cat:** character
- **q13a_cpd_outside_work_ind:** character
- **q13b_cpd_outside_work_days_txt:** character freetext
- **q14a_mgr_cpd_supportive_cat:** character
- **q15a_mgr_cpd_more_support_ind:** character
- **q16a_org_cpd_supportive_cat:** character
- **q17a_org_cpd_budget_cat:** character
- **q17b_org_cpd_budget_txt:** character freetext
- **q18a_org_study_leave_ind:** character
- **q18b_org_study_leave_days_txt:** character freetext
- **q19a_mgr_cpd_discuss_freq_cat:** character
- **q20a_cpd_opps_nhs_intranet_ind:** character
- **q20b_cpd_opps_org_website_ind:** character
- **q20c_cpd_opps_blogs_ind:** character
- **q20d_cpd_opps_twitter_ind:** character
- **q20e_cpd_opps_linkedin_ind:** character
- **q20f_cpd_opps_word_of_mouth_ind:** character
- **q20g_cpd_opps_apha_website_ind:** character
- **q20h_cpd_opps_other_txt:** character freetext
- **q21a_cpd_opps_sources_txt:** character freetext
- **q22a_org_nhs_type_cat:** character
- **q23a_org_analyst_team_size_cat:** character
- **q24a_org_analytics_influence_cat:** character

## Association of Healthcare Analysts Continuous Professional Development survey data

Data was provided with permission from Rony Arafin in 2024, the then
president of AphA, to include this dataset as part of training.

The data had been collected through a survey of analysts which was
analysed and published by AphA on [their
website](https://www.aphanalysts.org/ltnws/nhs-at-risk-of-losing-a-generation-of-data-analysts/).
This is a good example of real survey collected data as it includes some
standardised text and some freetext with missing values and combinations
of numbers and text in some fields.

There are also 38 columns of data with partial questions which are
related, for example, Q20 has parts a, b, c, d, e, f, g and h.

This data has a lot of structure to it for text based analysis but is a
good dataset for practising data cleaning.

## Labels

The data has labels as well as column headers which can be seen in the
RStudio environment panel as `attr(*, "label")= chr`

To view the attribute/label for one column

``` r

attributes(apha_cpd_survey$q00a_age_bracket_cat)
#> $label
#> [1] "What's your age?"
```

To view all labels with the headers

``` r

df <- tibble(
  variable = names(apha_cpd_survey),
  variable_label = map_chr(
    apha_cpd_survey,
    ~ attr(.x, "label") %||% NA_character_
  ),
  value_labels = map(
    apha_cpd_survey,
    ~ attr(.x, "labels")
  )
)
```

To view just the data a bit more cleanly

``` r

tibble::glimpse(apha_cpd_survey)
#> Rows: 237
#> Columns: 38
#> $ respondent_id                    <int> 195676290, 195698438, 195698479, 1956…
#> $ form_started_dttm                <dttm> 2022-07-15 09:44:04, 2022-07-15 13:4…
#> $ form_ended_dttm                  <dttm> 2022-07-15 09:47:53, 2022-07-15 13:4…
#> $ q00a_age_bracket_cat             <chr> "40~44", "50~54", "25~29", "40~44", "…
#> $ q01a_gender_cat                  <chr> "Male", "Female", "Male", "Male", "Ma…
#> $ q02a_max_education_level_cat     <chr> "Postgraduate degree", "Postgraduate …
#> $ q03a_analyst_years_n             <chr> "5", "18", "0.7", "7", "3", "23", "10…
#> $ q04a_role_description_cat        <chr> "economist", "Data analyst", "Data an…
#> $ q05a_afc_band_cat                <chr> "Band 9 or VSM", "Band 6 or 7", "Band…
#> $ q06a_current_org_years_cat       <chr> "6~10 years", "6~10 years", "Less tha…
#> $ q07a_future_health_work_cat      <chr> "Very likely", "Undecided", "Somewhat…
#> $ q08a_apha_aware_ind              <chr> "Yes", "Yes", "Yes", "Yes", "Yes", "Y…
#> $ q09a_apha_registered_cat         <chr> "Yes, I am a leading practitioner", "…
#> $ q10a_other_org_member_txt        <chr> "No", "No", "No", "No", "No", "No", "…
#> $ q11a_nhs_cpd_aware_cat           <chr> "Yes – would like to know more", "Yes…
#> $ q12a_cpd_time_at_work_cat        <chr> "Often — very few occasions where tra…
#> $ q13a_cpd_outside_work_ind        <chr> "Yes", "Yes", "No", "No", "No", "No",…
#> $ q13b_cpd_outside_work_days_txt   <chr> "-", "10", "-", "-", "-", "-", "-", "…
#> $ q14a_mgr_cpd_supportive_cat      <chr> "Not at all – no discussion on develo…
#> $ q15a_mgr_cpd_more_support_ind    <chr> "Yes", "Yes", "Yes", "No", "Yes", "Ye…
#> $ q16a_org_cpd_supportive_cat      <chr> "Very supportive – e.g., shares train…
#> $ q17a_org_cpd_budget_cat          <chr> "No", "Don't know", "Don't know", "No…
#> $ q17b_org_cpd_budget_txt          <chr> "-", "-", "-", "-", "-", "-", "-", "-…
#> $ q18a_org_study_leave_ind         <chr> "Yes", "Yes", "No", "No", "No", "No",…
#> $ q18b_org_study_leave_days_txt    <chr> "-", "Don't know", "-", "-", "-", "-"…
#> $ q19a_mgr_cpd_discuss_freq_cat    <chr> "Only when I request", "Only when app…
#> $ q20a_cpd_opps_nhs_intranet_ind   <chr> "No", "No", "Yes", "No", "Yes", "Yes"…
#> $ q20b_cpd_opps_org_website_ind    <chr> "No", "No", "No", "No", "No", "Yes", …
#> $ q20c_cpd_opps_blogs_ind          <chr> "Yes", "No", "No", "No", "No", "No", …
#> $ q20d_cpd_opps_twitter_ind        <chr> "Yes", "No", "No", "No", "No", "Yes",…
#> $ q20e_cpd_opps_linkedin_ind       <chr> "No", "No", "No", "No", "No", "No", "…
#> $ q20f_cpd_opps_word_of_mouth_ind  <chr> "Yes", "Yes", "Yes", "No", "No", "No"…
#> $ q20g_cpd_opps_apha_website_ind   <chr> "No", "Yes", "No", "Yes", "No", "Yes"…
#> $ q20h_cpd_opps_other_txt          <chr> "No", "No", "No", "No", "No", "Skills…
#> $ q21a_cpd_opps_sources_txt        <chr> "-", "https://www.aphanalysts.org/", …
#> $ q22a_org_nhs_type_cat            <chr> "CSU", "Trust (hospitals, mental heal…
#> $ q23a_org_analyst_team_size_cat   <chr> "3 ~ 5 (FTEs)", "Below 3 (Full Time E…
#> $ q24a_org_analytics_influence_cat <chr> "Yes – somewhat", "Yes – somewhat", "…
```

## Categories for columns

As there are so many columns finding the categories or unique data is
possible with using a function and a `purrr` loop:

``` r

# Simple function that uses base R unique() to return the unique data from a column
unique_data <- function(data, column) {
  unique(data$column)
}

# maps across all the columns and gives unique data
purrr::imap(
  apha_cpd_survey,
  ~ unique(.x)
)
```

As some columns have freetext or lots of unique data (as for date time
columns) not all of this will be useful so restricting to only those
that are known to have a few categories will be more helpful

``` r

data <- apha_cpd_survey |>
  # unselect the columns with dttm in the name
  dplyr::select(!dplyr::ends_with("dttm")) |>
  # unselect respondent_id as that is a unique number
  dplyr::select(-respondent_id) |>
  # freetext columns
  dplyr::select(-c(
    q04a_role_description_cat,
    q13b_cpd_outside_work_days_txt,
    q17b_org_cpd_budget_txt,
    q18b_org_study_leave_days_txt,
    q20h_cpd_opps_other_txt,
    q21a_cpd_opps_sources_txt
  ))

# Rerun the purrr loop to see the data
purrr::imap(
  data,
  ~ unique(.x)
)
#> $q00a_age_bracket_cat
#>  [1] "40~44"        "50~54"        "25~29"        "45~49"        "30~34"       
#>  [6] "35~39"        "18~24"        "65 and above" "55~59"        "60~64"       
#> 
#> $q01a_gender_cat
#> [1] "Male"              "Female"            "Prefer not to say"
#> 
#> $q02a_max_education_level_cat
#> [1] "Postgraduate degree"                        
#> [2] "Bachelor's degree"                          
#> [3] "A and AS level or equivalent qualifications"
#> [4] "Other qualifications"                       
#> [5] "GCSE or equivalent qualifications"          
#> [6] "Apprenticeships"                            
#> 
#> $q03a_analyst_years_n
#>  [1] "5"        "18"       "0.7"      "7"        "3"        "23"      
#>  [7] "10"       "4"        "1"        "9"        "8"        "20"      
#> [13] "35"       "6"        "14"       "15"       "2"        "22"      
#> [19] "19"       "17"       "30"       "13"       "16"       "1.5"     
#> [25] "12"       "25"       "5.5"      "0.5"      "-"        "21"      
#> [31] "2.5"      "6.5"      "36"       "27"       "11"       "34"      
#> [37] "24"       "32"       "1 ~2"     "28"       "41"       "0"       
#> [43] "4.5"      "6 years"  "29"       "7+ years"
#> 
#> $q05a_afc_band_cat
#>  [1] "Band 9 or VSM"                                                
#>  [2] "Band 6 or 7"                                                  
#>  [3] "Band 5 and below"                                             
#>  [4] "Band 8a or 8b"                                                
#>  [5] "Band 8c or 8d"                                                
#>  [6] "We are not graded in the US"                                  
#>  [7] "Band B Senior analyst, approx gd7"                            
#>  [8] "Prefer not to say"                                            
#>  [9] "-"                                                            
#> [10] "Local authority public health"                                
#> [11] "Local Authority Hay Band C (37k-43k)"                         
#> [12] "Independent Provider so no grade - Senior Performance Analyst"
#> [13] "Public Health Intelligence Manager"                           
#> [14] "GRADE E LOCAL GOVERNMENT"                                     
#> 
#> $q06a_current_org_years_cat
#> [1] "6~10 years"         "Less than 1 year"   "More than 10 years"
#> [4] "3~5 years"          "1~2 years"         
#> 
#> $q07a_future_health_work_cat
#> [1] "Very likely"       "Undecided"         "Somewhat likely"  
#> [4] "Very unlikely"     "Somewhat unlikely"
#> 
#> $q08a_apha_aware_ind
#> [1] "Yes" "No" 
#> 
#> $q09a_apha_registered_cat
#> [1] "Yes, I am a leading practitioner"                            
#> [2] "Yes, I am a practitioner"                                    
#> [3] "Yes, I’m an associate practitioner"                          
#> [4] "Not yet, but I am planning to be professionally registered"  
#> [5] "No, and I am not planning on being professionally registered"
#> [6] "Yes, I am an advanced practitioner"                          
#> [7] "Yes, I am a senior practitioner"                             
#> 
#> $q10a_other_org_member_txt
#>  [1] "No"                                                                         
#>  [2] "Royal Statistical Society"                                                  
#>  [3] "Faculty of Clinical Informatics"                                            
#>  [4] "BCS"                                                                        
#>  [5] "FEDIP"                                                                      
#>  [6] "HIMSS, AMIA, ANIA"                                                          
#>  [7] "FCI"                                                                        
#>  [8] "ICAEW and HFMA (I'm also a qualified accountant)"                           
#>  [9] "FEDIP and BCS"                                                              
#> [10] "IET"                                                                        
#> [11] "NHSR Community "                                                            
#> [12] "ISPOR"                                                                      
#> [13] "Yes (please specify):"                                                      
#> [14] "Faculty of Public Health"                                                   
#> [15] "The OR Society"                                                             
#> [16] "RSS (Royal Statistical Society) and RSPH (Royal Society for Public Health) "
#> [17] "Institute of Mathematics and its Applications"                              
#> [18] "operational research society"                                               
#> [19] "Association of Project Management because I have a hybrid career "          
#> [20] "-"                                                                          
#> 
#> $q11a_nhs_cpd_aware_cat
#> [1] "Yes – would like to know more" "Not at all"                   
#> [3] "Fully aware"                  
#> 
#> $q12a_cpd_time_at_work_cat
#> [1] "Often — very few occasions where training has been refused due to budget, capacity, or any other reason"               
#> [2] "Rarely"                                                                                                                
#> [3] "Sometimes — depending on team capacity"                                                                                
#> [4] "Always — study leave available and not refused on application, no issues negotiating time for professional development"
#> 
#> $q13a_cpd_outside_work_ind
#> [1] "Yes" "No"  "-"  
#> 
#> $q14a_mgr_cpd_supportive_cat
#> [1] "Not at all – no discussion on development needs"                                                    
#> [2] "Somewhat – occasionally has conversations with me on my development needs"                          
#> [3] "Very supportive – actively supports through regular meetings,  facilitates training and development"
#> 
#> $q15a_mgr_cpd_more_support_ind
#> [1] "Yes" "No" 
#> 
#> $q16a_org_cpd_supportive_cat
#> [1] "Very supportive – e.g., shares training/secondment opportunities, provides funding for training, provides a mentor/study leave etc"
#> [2] "Not at all"                                                                                                                        
#> [3] "Somewhat – policy in place, occasional reminder of opportunities"                                                                  
#> 
#> $q17a_org_cpd_budget_cat
#> [1] "No"         "Don't know" "Yes"       
#> 
#> $q18a_org_study_leave_ind
#> [1] "Yes" "No"  "-"  
#> 
#> $q19a_mgr_cpd_discuss_freq_cat
#> [1] "Only when I request"                                                             
#> [2] "Only when appraisals are due"                                                    
#> [3] "Not at all"                                                                      
#> [4] "Occasionally – formal or informally"                                             
#> [5] "Regularly – formal/ agreed times throughout the year (in addition to appraisals)"
#> 
#> $q20a_cpd_opps_nhs_intranet_ind
#> [1] "No"  "Yes"
#> 
#> $q20b_cpd_opps_org_website_ind
#> [1] "No"  "Yes"
#> 
#> $q20c_cpd_opps_blogs_ind
#> [1] "Yes" "No" 
#> 
#> $q20d_cpd_opps_twitter_ind
#> [1] "Yes" "No" 
#> 
#> $q20e_cpd_opps_linkedin_ind
#> [1] "No"  "Yes"
#> 
#> $q20f_cpd_opps_word_of_mouth_ind
#> [1] "Yes" "No" 
#> 
#> $q20g_cpd_opps_apha_website_ind
#> [1] "No"  "Yes"
#> 
#> $q22a_org_nhs_type_cat
#>  [1] "CSU"                                                    
#>  [2] "Trust (hospitals, mental health, ambulance, etc..)"     
#>  [3] "ICS"                                                    
#>  [4] "Social Enterprise"                                      
#>  [5] "RPB"                                                    
#>  [6] "Welsh health board"                                     
#>  [7] "Local Authority "                                       
#>  [8] "Do not work for NHS"                                    
#>  [9] "CCG/ICB/ICP"                                            
#> [10] "regulator "                                             
#> [11] "Nhse"                                                   
#> [12] "hsn"                                                    
#> [13] "NHS England "                                           
#> [14] "NHS England"                                            
#> [15] "Community care, social care, primary care networks"     
#> [16] "NHSE"                                                   
#> [17] "Local authority public health "                         
#> [18] "Local Authority"                                        
#> [19] "local authority"                                        
#> [20] "HAS/OHID"                                               
#> [21] "HSN"                                                    
#> [22] "PCN"                                                    
#> [23] "Independent provider of acute care (outpatients + IAPT)"
#> [24] "I don't; local authority"                               
#> [25] "Public Heath at County Council"                         
#> [26] "NHSE&I"                                                 
#> [27] "GP Federation"                                          
#> [28] "WORK IN LOCAL GOVERNMENT PUBLIC HEALTH"                 
#> [29] "Other (please specify):"                                
#> [30] "Trust, moving to CSU"                                   
#> 
#> $q23a_org_analyst_team_size_cat
#> [1] "3 ~ 5 (FTEs)"                          
#> [2] "Below 3 (Full Time Equivalents (FTEs))"
#> [3] "11 or above (FTEs)"                    
#> [4] "6 ~ 10 (FTEs)"                         
#> 
#> $q24a_org_analytics_influence_cat
#> [1] "Yes – somewhat"                           
#> [2] "Yes – very often"                         
#> [3] "Not at all"                               
#> [4] "Yes –  a little"                          
#> [5] "Yes – analytics influences most decisions"
```

## Cleaning the data

This is good data to see how organisations can be listed in multiple
ways if the collection is freetext.

For example:

``` r

apha_cpd_survey |>
  dplyr::select(q22a_org_nhs_type_cat) |>
  dplyr::distinct() |>
  dplyr::filter(q22a_org_nhs_type_cat %in% c("Nhse", "NHS England", "NHS England ", "NHSE"))
#> # A tibble: 4 × 1
#>   q22a_org_nhs_type_cat
#>   <chr>                
#> 1 "Nhse"               
#> 2 "NHS England "       
#> 3 "NHS England"        
#> 4 "NHSE"
```

all refer to NHS England and whilst some are spelled correctly there may
be trailing white space.
