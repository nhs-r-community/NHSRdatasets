# Source: https://www.aphanalysts.org/documents/cpd-survey-results-raw-data/
# (Accessed 25 January 2024)
# 
# The .xlsx file cannot be directly downloaded from its URI as there is
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
