test_that("dataset is as expectes", {
  expect_type(LOS_model, "list")
  expect_s3_class(LOS_model$Organisation, "factor")
  expect_s3_class(LOS_model, "data.frame")
  expect_length(LOS_model$ID, 300)
})
