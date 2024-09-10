library(shiny)
library(reactable)
library(ggplot2)
library(ggiraph)
library(leaflet)

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
    girafeOutput("clean_ggiraph")
  ),
  conditionalPanel(
    condition = "input.panel_selector == 'ggiraph_error'",
    girafeOutput("error_ggiraph")
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
  # Reactable outputs =========================================================
  output$clean_reactable <- renderReactable(reactable(iris))
  output$error_reactable <- renderReactable(reactable(iris[0]))

  # renderTable output ========================================================
  output$clean_rendertable <- renderTable(head(iris))
  output$error_rendertable <- renderTable(head(iris[0]))
  
  # ggplot2 output ============================================================
  output$clean_ggplot <- renderPlot({
    ggplot(iris, aes(x = Sepal.Length, color = Species)) +
      geom_bar() +
      theme_minimal()
  })

  output$error_ggplot <- renderPlot({
    ggplot(iris, aes(x = NOT_REAL_COL, color = Species)) +
      geom_bar() +
      theme_minimal()
  })

  # ggiraph output ============================================================
  output$clean_ggiraph <- renderGirafe({
    gg <- ggplot(iris, aes(x = Species, fill = Species)) +
      geom_bar_interactive(aes(tooltip = Species)) +
      theme_minimal()
    girafe(ggobj = gg)
  })
  
  output$error_ggiraph <- renderGirafe({
    gg <- ggplot(iris, aes(x = NOT_REAL_COL, fill = Species)) +
      geom_bar_interactive(aes(tooltip = Species)) +
      theme_minimal()
    girafe(ggobj = gg)
  })

  # Leaflet output ============================================================
  output$clean_map <-  renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -1.5536, lat = 54.5245, zoom = 6) %>%
      addPolygons(
        lng = c(-1.6, -1, -1.4),
        lat = c(54.6, 56, 54.8),
        fillColor = "blue",       
        fillOpacity = 0.4,          
        popup = "Darlington Area"
      )
  })

  output$error_map <-  renderLeaflet({
    leaflet() %>%
      addTiles(error = TRUE) %>%
      setView(lng = -1.5536, lat = 54.5245, zoom = 6) %>%
      addPolygons(
        lng = c(-1.6, -1, -1.4),
        lat = c(54.6, 56, 54.8),
        fillColor = "blue",       
        fillOpacity = 0.4,          
        popup = "Darlington Area"
      )
  })
}

shinyApp(ui, server)
