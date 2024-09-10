library(shiny)
library(reactable)
library(ggplot2)
library(leaflet)
library(bslib)

ui <- fluidPage(
  titlePanel("Testing out shinytest2 approaches"),

  # Drop down for panel selection
  selectInput("panel_selector", "Select a panel:",
    choices = c(
      "home",
      "renderTable_clean", "renderTable_error",
      "reactable_clean", "reactable_error",
      "ggplot2_clean", "ggplot2_error",
      "ggiraph_clean", "ggiraph_error",
      "leaflet_clean", "leaflet_error"
    )
  ),

  # Conditional panels based on selection
  conditionalPanel(
    condition = "input.panel_selector == 'home'",
    p("Flick through the panels to see examples")
  ),
  conditionalPanel(
    condition = "input.panel_selector == 'renderTable_clean'",
    tableOutput("clean_rendertable")
  ),
  conditionalPanel(
    condition = "input.panel_selector == 'renderTable_error'",
    tableOutput("error_rendertable")
  ),
  conditionalPanel(
    condition = "input.panel_selector == 'reactable_clean'",
    reactableOutput("clean_reactable")
  ),
  conditionalPanel(
    condition = "input.panel_selector == 'reactable_error'",
    reactableOutput("error_reactable")
  ),
  conditionalPanel(
    condition = "input.panel_selector == 'ggplot2_clean'",
    plotOutput("clean_ggplot")
  ),
  conditionalPanel(
    condition = "input.panel_selector == 'ggplot2_error'",
    plotOutput("error_ggplot")
  ),
  conditionalPanel(
    condition = "input.panel_selector == 'ggiraph_clean'",
    plotOutput("clean_ggiraph")
  ),
  conditionalPanel(
    condition = "input.panel_selector == 'ggiraph_error'",
    plotOutput("error_ggiraph")
  ),
  conditionalPanel(
    condition = "input.panel_selector == 'leaflet_clean'",
    leafletOutput("clean_map")
  ),
  conditionalPanel(
    condition = "input.panel_selector == 'leaflet_error'",
    leafletOutput("error_map")
  )
)

server <- function(input, output, session) {
  # Reactable outputs
  output$clean_reactable <- renderReactable(reactable(iris))
  output$error_reactable <- renderReactable(reactable(iris[0]))

  # ggplot2 output
  output$clean_ggplot <- renderPlot({
    ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
      geom_point() +
      theme_minimal()
  })

  output$error_ggplot <- renderPlot({
    ggplot(iris, aes(x = NOT_REAL_COL, y = Sepal.Width, color = Species)) +
      geom_point() +
      theme_minimal()
  })

  # renderTable output
  output$clean_rendertable <- renderTable(head(iris))
  output$error_rendertable <- renderTable(head(iris[0]))

  # Leaflet output
  output$clean_map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -1.5536, lat = 54.5245, zoom = 6) %>%
      addMarkers(lng = -1.5536, lat = 54.5245, popup = "Darlington")
  })

  # TODO: make an erroring leaflet map
  output$error_map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -1.5536, lat = 54.5245, zoom = "broken") %>%
      addMarkers(lng = -1.5536, lat = 54.5245, popup = "Darlington")
  })
}

shinyApp(ui, server)
