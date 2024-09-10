library(shinytest2)

# Check that a given table is present and has rendered rows of data
reactable_rendered_rows <- function(table_name){
  number_of_rendered_rows <- app$get_html(paste0("#", table_name)) |>
    rvest::read_html() |> 
    rvest::html_elements("div.rt-tr-group") |> 
    length()
  
  return(number_of_rendered_rows)
}

# Create a test app
app <- AppDriver$new()

# Wait for the table to render
app$wait_for_idle(50)

test_that("There are no errors in the whole app", {
  expect_null(app$get_html(".shiny-output-error"))
  expect_null(app$get_html(".shiny-output-error-validation"))
})

test_that("Reactable table renders without errors", {
  expect_gt(reactable_rendered_rows("clean_table"), 0)
  expect_gt(reactable_rendered_rows("error_table"), 0)
})

# TODO: test out basic renderTable
# TODO: test out ggplot2 with ggiraph
# TODO: test out leaflet maps
# TODO: test out file downloads (CSV / XLSX)
