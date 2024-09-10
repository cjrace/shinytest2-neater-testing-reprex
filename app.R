library(shiny)
library(reactable)
library(ggplot2)
library(leaflet)

ui <- fluidPage(
  titlePanel("Testing out shinytest2 approaches"),
  tabsetPanel(
    tabPanel("Reactable", reactableOutput("clean_reactable"), reactableOutput("error_reactable")),
    tabPanel("ggplot2", plotOutput("clean_ggplot"), plotOutput("error_ggplot")),
    tabPanel("renderTable", tableOutput("clean_data_table"), tableOutput("error_data_table")),
    tabPanel("Leaflet", leafletOutput("clean_map"), leafletOutput("error_map"))
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
    ggplot(iris[0], aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
      geom_point() +
      theme_minimal()
  })
  
  # renderTable output
  output$clean_data_table <- renderTable(head(iris))
  output$error_data_table <- renderTable(head(iris[0]))
  
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
