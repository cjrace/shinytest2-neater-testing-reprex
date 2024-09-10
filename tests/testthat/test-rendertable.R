# Create a test app
app <- AppDriver$new()

# Wait for the table to render
app$wait_for_idle(50)

check_rendertable_rows <- function(object_name) {
  table_html <- app$get_values(output = object_name)[[1]]

  # Return 0 as number of rows if there's an error
  # Table html has a length 1 if no error, will be a list of stuff if error is present
  if (length(table_html[[object_name]]) != 1) {
    return(0)
  }

  number_of_rendered_rows <- table_html |>
    unlist() |>
    rvest::read_html() |>
    rvest::html_elements("tr") |>
    length()

  return(number_of_rendered_rows)
}

test_that("renderTable renders, and has rows", {
  app$set_inputs(panel_selector = "renderTable_clean")
  app$wait_for_idle(50)
  expect_gt(check_rendertable_rows("clean_rendertable"), 0)

  app$set_inputs(panel_selector = "renderTable_error")
  app$wait_for_idle(50)
  expect_gt(check_rendertable_rows("error_rendertable"), 0)
})
