###########################################################
#######   CLASS PROJECT DDP COURSERA - CONJOINT SIMULATOR
###########################################################
library(shiny)


shinyUI(fluidPage(
  titlePanel("Internet Products Utility"),
  h5("Conjoint Market Simulator"),
  sidebarLayout(
    sidebarPanel(width=3,
      h4("Filter"),
      h5("Company size"),
      checkboxInput("small", "Small"),
      checkboxInput("med", "Medium"),
      h5("City"),
      checkboxInput("seattle", "Seattle"),
      checkboxInput("portland","Portland"),
      hr(),
      h5("Number of records"),
      h6("Companies"),
      verbatimTextOutput("companies_marked"),
      h6("Cities"),
      verbatimTextOutput("cities_marked"),
      h6("Total of records"),
      verbatimTextOutput("total")
      ),
    mainPanel(
        h4("Choose 3 products:"),       
                fluidRow(
  column(3, offset = 1,
               h5("Product 1"),
               selectInput('prod1_at1', 'Carrier', c('T-mobile','Sprint',"Verizon")),
               selectInput('prod1_at2', 'Price', c('Up to $30','$30 - $50',"$50 - $80")),
               selectInput('prod1_at3', 'Velocity', c('2MB',"5MB","8MB")),
               selectInput("prod1_at4", "Wi-Fi service", c('No Wi-Fi',"Customized"))
        ),
  column(3, offset = 1,
         h5("Product 2"),
         selectInput('prod2_at1', 'Carrier', c('T-mobile','Sprint',"Verizon")),
         selectInput('prod2_at2', 'Price', c('Up to $30','$30 - $50',"$50 - $80")),
         selectInput('prod2_at3', 'Velocity', c('2MB',"5MB","8MB")),
         selectInput("prod2_at4", "Wi-Fi service", c('No Wi-Fi',"Customized"))
  ),
  column(3, offset = 1,
         h5("Product 3"),
         selectInput('prod3_at1', 'Carrier', c('T-mobile','Sprint',"Verizon")),
         selectInput('prod3_at2', 'Price', c('Up to $30','$30 - $50',"$50 - $80")),
         selectInput('prod3_at3', 'Velocity', c('2MB',"5MB","8MB")),
         selectInput("prod3_at4", "Wi-Fi service", c('No Wi-Fi',"Customized"))
  )
),
fluidRow(
  h4("Estimated utility"),
  column(3,
        h5("Product 1"),
        verbatimTextOutput("utility1")
        ),
  column(3,
         h5("Product 2"),
         verbatimTextOutput("utility2")
         ),
  column(3,
         h5("Product 3"),
         verbatimTextOutput("utility3")
         )
),
htmlOutput("columnchart")
)
)
)
)
