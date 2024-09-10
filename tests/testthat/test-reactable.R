# Create a test app
app <- AppDriver$new()

# Wait for the table to render
app$wait_for_idle(50)

# Check that a given table is present and has rendered rows of data
check_reactable_rows <- function(object_name) {
  table_html <- app$get_html(paste0("#", object_name))

  if (is.null(table_html)) {
    stop(paste("The", object_name, "object could not be found."))
  }

  number_of_rendered_rows <- table_html |>
    rvest::read_html() |>
    rvest::html_elements("div.rt-tr-group") |>
    length()

  return(number_of_rendered_rows)
}

test_that("Reactable table renders and has rows", {
  app$set_inputs(panel_selector = "reactable_clean")
  app$wait_for_idle(50)
  expect_gt(check_reactable_rows("clean_reactable"), 0)

  app$set_inputs(panel_selector = "reactable_error")
  app$wait_for_idle(50)
  expect_gt(check_reactable_rows("error_reactable"), 0)
})
