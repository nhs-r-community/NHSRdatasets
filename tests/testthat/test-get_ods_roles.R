context("get_ods_roles")
library(mockery)

test_that("it returns the data from the API call", {
  stub(get_ods_roles, "httr::GET", "data")
  stub(get_ods_roles, "httr::status_code", 200)
  stub(get_ods_roles, "httr::content", list(Roles = "data"))
  stub(get_ods_roles, "dplyr::bind_rows", identity)
  stub(get_ods_roles, "janitor::clean_names", identity)

  expected <- "data"
  actual <- get_ods_roles()

  expect_equal(expected, actual)
})

test_that("it calls dplyr::bind_rows", {
  m <- mock()
  stub(get_ods_roles, "httr::GET", "data")
  stub(get_ods_roles, "httr::status_code", 200)
  stub(get_ods_roles, "httr::content", list(Roles = "data"))
  stub(get_ods_roles, "janitor::clean_names", identity)

  with_mock("bind_rows" = m, get_ods_roles(), .env = "dplyr")

  expect_called(m, 1)
  expect_call(m, 1, dplyr::bind_rows(httr::content(res)[["Roles"]]))
  expect_args(m, 1, "data")
})

test_that("it calls janitor::clean_names", {
  m <- mock()
  stub(get_ods_roles, "httr::GET", "data")
  stub(get_ods_roles, "httr::status_code", 200)
  stub(get_ods_roles, "httr::content", list(Roles = "data"))
  stub(get_ods_roles, "dplyr::bind_rows", identity)

  with_mock("clean_names" = m, get_ods_roles(), .env = "janitor")

  expect_called(m, 1)
  expect_call(m, 1, janitor::clean_names(roles))
})

test_that("it calls httr::GET and queries the correct API", {
  m <- mock()
  expected_url <- paste0(NHSRdatasets:::ODS_API_ENDPOINT, "roles")

  stub(get_ods_roles, "httr::status_code", 200)
  stub(get_ods_roles, "httr::content", list(Roles = "data"))
  stub(get_ods_roles, "dplyr::bind_rows", identity)
  stub(get_ods_roles, "janitor::clean_names", identity)

  with_mock("GET" = m, get_ods_roles(), .env = "httr")

  expect_called(m, 1)
  expect_call(m, 1, httr::GET(url))
  expect_args(m, 1, expected_url)
})

test_that("it calls httr::content", {
  m <- mock()

  stub(get_ods_roles, "httr::GET", "data")
  stub(get_ods_roles, "httr::status_code", 200)
  stub(get_ods_roles, "dplyr::bind_rows", identity)
  stub(get_ods_roles, "janitor::clean_names", identity)

  with_mock("content" = m, get_ods_roles(), .env = "httr")

  expect_called(m, 1)
  expect_call(m, 1, httr::content(res))
  expect_args(m, 1, "data")
})

test_that("it calls htrr:status_code and it stops if the API call fails", {
  m <- mock(200, 201, 400)
  stub(get_ods_roles, "httr::GET", "data")
  stub(get_ods_roles, "httr::content", list(Roles = "data"))
  stub(get_ods_roles, "dplyr::bind_rows", identity)
  stub(get_ods_roles, "janitor::clean_names", identity)

  with_mock("status_code" = m, {
    get_ods_roles()
    expect_error(get_ods_roles())
    expect_error(get_ods_roles())
  }, .env = "httr")

  expect_called(m, 3)
  for(i in 1:3) {
    expect_call(m, i, httr::status_code(res))
    expect_args(m, i, "data")
  }
})
