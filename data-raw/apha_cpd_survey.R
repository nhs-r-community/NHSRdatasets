# Source: https://www.aphanalysts.org/documents/cpd-survey-results-raw-data/
# (Accessed 25 January 2024)
# 
# The .xlsx file cannot be directly downloaded in `R` from its URL as there is
# protection on the file: it must be downloaded by submitting the form on the
# web page, either manually by clicking the button on the page, or by
# simulating the form submission using form headers within an {httr2} pipeline.

# HTML form code, copied from above URL, and used as source for form headers:
# 
# <form method="post" class="CMDM-downloadForm" action="https://www.aphanalysts.org/document/get/file/CPD-Survey-Results-RAW-Data.xlsx">
# 	<input type="hidden" name="cmdm_nonce" value="c133038289">
# 	<input type="hidden" name="id" value="14354">
# 	<input type="hidden" name="shortcodeId" value="31fae3b9363d47608d9038cffc3fa471">
# 	<input type="hidden" name="backurl" value="/documents/cpd-survey-results-raw-data/#cmdm-shortcode-31fae3b9363d47608d9038cffc3fa471">
# 	<div class="field">
# 	  <a href="#" class="downloadBut cmdm-download-button cmdm-button cmdm-button-primary cmdm-button-large">Download</a>
# 	  <input type="submit" value="Download" style="display:none">
# 	</div>
# </form>

raw_data_url <- paste0(
  "https://www.aphanalysts.org/",
  "document/get/file/CPD-Survey-Results-RAW-Data.xlsx"
  )

dl_tmp <- tempfile("apha_raw_data", fileext = ".xlsx")

httr2::request(raw_data_url) |>
  httr2::req_body_form(
    # These three headers are all required; the 4th one above isn't needed
    cmdm_nonce = "c133038289",
    id = "14354",
    shortcodeId = "31fae3b9363d47608d9038cffc3fa471"
    ) |>
  httr2::req_perform() |>
  # The lines below could be omitted and the `path` argument to req_perform()
  # used instead; but the more verbose/explicit method seems clearer.
  httr2::resp_body_raw() |>
  readr::write_file(dl_tmp)


raw_data <- dl_tmp |>
  openxlsx2::read_xlsx(
    start_row = 3,
    col_names = FALSE,
    skip_empty_rows = TRUE,
    skip_empty_cols = TRUE
  ) |>
  tibble::as_tibble() |>
  dplyr::mutate(across("A", as.integer)) |>
  dplyr::select(!"B") # respondent number not necessary

# informed by https://emilyriederer.netlify.app/post/column-name-contracts/
clean_col_names <- c(
  "respondent_id",
  "form_started_dttm",
  "form_ended_dttm",
  "q00a_age_bracket_cat",
  "q01a_gender_cat",
  "q02a_max_education_level_cat",
  "q03a_analyst_years_n",
  "q04a_role_description_cat",
  "q05a_afc_band_cat",
  "q06a_current_org_years_cat",
  "q07a_future_health_work_cat",
  "q08a_apha_aware_ind",
  "q09a_apha_registered_cat",
  "q10a_other_org_member_txt",
  "q11a_nhs_cpd_aware_cat",
  "q12a_cpd_time_at_work_cat",
  "q13a_cpd_outside_work_ind",
  "q13b_cpd_outside_work_days_txt",
  "q14a_mgr_cpd_supportive_cat",
  "q15a_mgr_cpd_more_support_ind",
  "q16a_org_cpd_supportive_cat",
  "q17a_org_cpd_budget_cat",
  "q17b_org_cpd_budget_txt",
  "q18a_org_study_leave_ind",
  "q18b_org_study_leave_days_txt",
  "q19a_mgr_cpd_discuss_freq_cat",
  "q20a_cpd_opps_nhs_intranet_ind",
  "q20b_cpd_opps_org_website_ind",
  "q20c_cpd_opps_blogs_ind",
  "q20d_cpd_opps_twitter_ind",
  "q20e_cpd_opps_linkedin_ind",
  "q20f_cpd_opps_word_of_mouth_ind",
  "q20g_cpd_opps_apha_website_ind",
  "q20h_cpd_opps_other_txt",
  "q21a_cpd_opps_sources_txt",
  "q22a_org_nhs_type_cat",
  "q23a_org_analyst_team_size_cat",
  "q24a_org_analytics_influence_cat"
)

# Provide explanatory labels for columns; use original name/question as default
var_labels <- c(
  "UserID",
  "Started",
  "Ended",
  "What's your age?",
  "What's your gender?",
  "What's your highest level of education?",
  "How long have you been a healthcare analyst? (years)",
  "Which of the following best describes your current role?",
  "Which of the following Agenda for Change bands best describe your role?",
  "How many years have you been working in the NHS/your organisation?",
  "What is the likelihood you’ll be working in the NHS/your organisation in 3 years time?",
  "Have you heard of the Association of Professional Healthcare Analysts (AphA)?",
  "Are you professionally registered with the AphA? If so, at what level?",
  "Are you a member of an alternative association?",
  "As an analyst, are you aware of professional development opportunities in the NHS?",
  "As an analyst, are you provided with opportunities/time to upskill during work hours, i.e. you have time to do this at work?",
  "Do you undertake CPD out of work hours?",
  "If yes, on how many days per year?",
  "Do you feel your manager is supportive of your professional development?",
  "Would you like more support on CPD from your line manager?",
  "Do you feel your organisation is supportive of your professional development?",
  "Does your organisation have a budget for CPD?",
  "Please state budget per year:",
  "Does your organisation offer study leave?",
  "Please state number of days study leave allowed per year",
  "How often do you discuss your professional development plan, career progression or potential training with your line manager(s)?",
  "Where do you learn from professional development opportunities? - NHS intranet",
  "Where do you learn from professional development opportunities? - Organisation websites",
  "Where do you learn from professional development opportunities? - Blogs",
  "Where do you learn from professional development opportunities? - Twitter",
  "Where do you learn from professional development opportunities? - LinkedIn",
  "Where do you learn from professional development opportunities? - Word of mouth recommendations",
  "Where do you learn from professional development opportunities? - AphA website",
  "Where do you learn from professional development opportunities? - Other (please specify):",
  "Are there any professional development opportunities (e.g. AphA website, websites, blogs, or twitter accounts you follow) that you would recommend to your fellow colleagues? Please specify:",
  "What sort of NHS organisation do you work for?",
  "What’s the size of your analytics team (including both full-time and part-time staff)?",
  "Do you feel that analytics influences important decisions in your organisation?"
) |>
  rlang::set_names(clean_col_names)


# usethis::use_data(apha_cpd_survey, overwrite = TRUE)