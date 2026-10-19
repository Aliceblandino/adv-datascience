library(shiny)
library(tidyverse)

# User interface
ui <- fluidPage(
  titlePanel("Fuel Economy Explorer"),
  plotOutput("scatter")
)

# Server logic
server <- function(input, output, session) {
  
  output$scatter <- renderPlot({
    mpg |>
      ggplot(aes(x = displ, y = hwy)) +
      geom_point() +
      theme_minimal()
  })
  
}

# Launch application
shinyApp(ui, server)

ui <- fluidPage(
  titlePanel("Fuel Economy Explorer"),
  
  sliderInput(
    inputId = "min_hwy",
    label = "Minimum highway MPG",
    min = min(mpg$hwy),
    max = max(mpg$hwy),
    value = min(mpg$hwy)
  ),
  
  plotOutput("scatter")
)
server <- function(input, output, session) {
  
  output$scatter <- renderPlot({
    mpg |>
      filter(hwy >= input$min_hwy) |>
      ggplot(aes(x = displ, y = hwy)) +
      geom_point() +
      theme_minimal()
  })
  
}