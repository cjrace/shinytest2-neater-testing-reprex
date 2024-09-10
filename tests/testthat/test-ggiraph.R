# Create a test app
app <- AppDriver$new()

# Wait for the table to render
app$wait_for_idle(50)

check_ggiraph_rendered <- function(object_name) {
  # Save 1 if image exits, 0 if not
  plot_img_length <- app$get_html(paste0("#", object_name)) |> 
    rvest::read_html() |> 
    rvest::html_elements("svg") |> # ggiraph creates svg layers
    length()
  
  # Give a true if the image exists, a false if not
  return(as.logical(plot_img_length))
}

test_that("ggiraph renders, and has data", {
  app$set_inputs(panel_selector = "ggiraph_clean")
  app$wait_for_idle(50)
  expect_true(check_ggiraph_rendered("clean_ggiraph"))
  
  app$set_inputs(panel_selector = "ggiraph_error")
  app$wait_for_idle(50)
  expect_true(check_ggiraph_rendered("error_ggiraph"))
})
