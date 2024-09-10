# Create a test app
app <- AppDriver$new()

# Wait for the table to render
app$wait_for_idle(50)

test_that("There are no errors in the whole app", {
  expect_null(app$get_html(".shiny-output-error"))
  expect_null(app$get_html(".shiny-output-error-validation"))
})

# TODO: test out ggplot2 with ggiraph
# TODO: test out leaflet maps
# TODO: test out file downloads (CSV / XLSX)
