library(shiny)
library(reactable)

ui <- fluidPage(
  reactableOutput("table"),
  reactableOutput("table2")
)

server <- function(input, output, session) {
  output$table <- renderReactable({
    reactable(iris)
  })
  
  output$table2 <- renderReactable({
    reactable(iris[0])
  })
}

shinyApp(ui, server)