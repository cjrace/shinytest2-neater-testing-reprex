library(shinytest2)

test_that("Reactable table renders without errors", {
  app <- AppDriver$new()
  
  # Wait for the table to render
  app$wait_for_idle(50)
  
  # Check for any error messages
  expect_null(app$get_html(".shiny-output-error"))
  expect_null(app$get_html(".shiny-output-error-validation"))
  
  # Check that table is present
  
  
  
})
