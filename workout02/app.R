#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application 
ui <- fluidPage(
   
   # Application title
   titlePanel("Shiny App for Saving-investing Modalities"),
   fluidRow(
     
     column(4,
            
            # Slider input for Initial Amount
            sliderInput("initial_amount", label = h3("Initial Amount"), min = 0, 
                        step = 500,  max = 100000, value = 1000, pre = '$')
     ),
     column(4,
            
            # Slider input for Return Rate in percentage
            sliderInput("return_rate", label = h3("Return Rate(in %)"), min = 0, 
                        step = 0.1, max = 20, value = 5)
     ),
     column(4,
            
            # Slider input for Years
            sliderInput("years", label = h3("Years"), min = 0, 
                        step = 1, max = 50, value = 20)
     )
   ),
   fluidRow(
     column(4,
            
            # Slider input for Annual Contribution
            sliderInput("annual_contrib", label = h3("Annual Contribution"), min = 0, 
                        step = 500,  max = 50000, value = 2000, pre = '$')
     ),
     column(4,
            
            # Slider input for Growth Rate in percentage
            sliderInput("growth_rate", label = h3("Growth Rate(in %)"), min = 0, 
                        step = 0.1, max = 20, value = 2)
     ),
     column(4,
            
            # Select input for Facet?
            selectInput("facet", label = h3("Facet?"), 
                        choices = list("No" = "No", "Yes" = "Yes"))
                        
     )
   ),
   #tags$hr(style="border-color: #cbd0d8;"),
   hr(),
   mainPanel(
     titlePanel(h3("Tmelines")),
     plotOutput('Plot', width = 1200, height = 500),
     titlePanel(h3("Balances")),
     verbatimTextOutput("Balances")
     
   )
)

# define server for our application
server <- function(input, output) {
  # first define three basic functions 
  
  #' @title Future Value Function
  #' @description compute the future money returned by investing a financial which has an annual return rate
  #' @param amount initial invested amount (numeric)
  #' @param rate annual rate of return (decimal)
  #' @param years number of years you invest money for (integer)
  #' @return total money you will get at the end of the specified time period
  future_value <- function(amount = 100, rate = 0.01, years = 1) {
    money <- amount*(1 + rate)^(years)
    return(money)
  }
  
  #' @title Function of Future Value of Annuity
  #' @description compute the future value of annuity
  #' @param contrib contributed amount, how much you deposit at the end of each year (numeric)
  #' @param rate annual rate of return (decimal)
  #' @param years number of years (integer)
  #' @return future money of annuity you will get at the end of the specified time period
  annuity <- function(contrib = 100, rate = 0.01, years = 1) {
    money <- contrib*(((1 + rate)^(years)-1)/rate)
    return(money)
  }
  
  #' @title Function of Future Value of Growing Annuity
  #' @description compute the future value of growing annuity
  #' @param contrib contributed amount, how much you deposit at the end of each year 1 (numeric)
  #' @param rate annual rate of return (decimal)
  #' @param growth annual growth rate (decimal)
  #' @param years number of years (integer)
  #' @return future money of growing annuity you will get at the end of the specified time period
  growing_annuity <- function(contrib = 100, rate = 0.05, growth = 0.03, years = 1) {
    money <- contrib*((1+rate)^years - (1+growth)^years)/(rate - growth)
    return(money)
  }
  
   modalities <- reactive({
     # get inputs
     initial_investment <- input$initial_amount
     annual_contrib <- input$annual_contrib
     return_rate <- input$return_rate
     growth_rate <- input$growth_rate
     years <- input$years
     
     # initialize data frame
     modalities <- data.frame(year = seq(0,years), no_contrib = rep(0,years+1),
                              fixed_contrib = rep(0,years+1), growing_contrib = rep(0,years+1)
     )
     
     
     # write for() loops
     # we use logical indicator to judge which mode we are calculating for
     for (pos in 2:4) {
       for (year in 0:years) {
         modalities[[pos]][year+1] <- future_value(amount = initial_investment, rate = return_rate/100, years = year) +
           annuity(contrib = annual_contrib, rate = return_rate/100, years = year)*(pos == 3) +
           growing_annuity(contrib = annual_contrib, rate = return_rate/100, growth = growth_rate/100, years = year)*(pos == 4)
       }
     }
     modalities
   }
   )
   
   # plot output
   output$Plot <- renderPlot({
     # get data frame
     modalities <- modalities()
     
     if (input$facet == "No"){
       # use ggplot() to draw plot
       gg <- ggplot(data = modalities) +
         geom_point(aes(x = year, y = no_contrib, color = "1"), size = 1.5) +
         geom_point(aes(x = year, y = fixed_contrib, color = "2"), size = 1.5) +
         geom_point(aes(x = year, y = growing_contrib, color = "3"), size = 1.5) +
         geom_line(aes(x = year, y = no_contrib, color = "1"), size = 0.8) +
         geom_line(aes(x = year, y = fixed_contrib, color = "2"), size = 0.8) +
         geom_line(aes(x = year, y = growing_contrib, color = "3"), size = 0.8) +
         xlab("Year") +
         ylab("Value") +
         #theme_bw() +
         scale_colour_discrete("variable", breaks = c("1","2","3"), 
                               labels = c("no_contrib", "fixed_contrib", "growing_contrib")) +
         theme(plot.title = element_text(hjust = 0.5, size = 28),
               legend.text.align = 0) +
         ggtitle(label = "Three modes of investing")
       
     }
     
     
     # whether display a facetted graph
     if (input$facet == "Yes") {
       years <- input$years
       df <- data.frame( year = rep(seq(0, years), 3), value = c(modalities$no_contrib,
                                                                 modalities$fixed_contrib,
                                                                 modalities$growing_contrib),
                         #mod = c(rep("no_contrib", years+1), rep("fixed_contrib", years+1),
                                 #rep("growing_contrib", years+1))
                         mod = gl(3,years+1, labels = c("no_contrib", "fixed_contrib", "growing_contrib")))
       
       with(df, levels(mod)) 
       gg <- ggplot(data = df) +
         facet_wrap(~mod) +
         geom_point(aes(x = year, y = value, col = mod), size = 1.5) +
         geom_line(aes(x = year, y = value, col = mod), size = 0.8) +
         geom_area(aes(x = year, y = value, fill = mod),alpha = 0.5) +
         xlab("Year") +
         ylab("Value") +
         theme_bw() +
         #scale_fill_discrete("variable", breaks = c("no_contrib", "fixed_contrib", "growing_contrib"), 
                               #labels = c("no_contrib", "fixed_contrib", "growing_contrib")) +
         #scale_colour_discrete("variable", breaks = c("no_contrib","fixed_contrib","growing_contrib"), 
                             #labels = c("no_contrib", "fixed_contrib", "growing_contrib")) +
         theme(plot.title = element_text(hjust = 0.5, size = 28),
               legend.text.align = 0) +
         ggtitle(label = "Three modes of investing")
     }
      gg
      
   })
   
   # table output
   output$Balances <- renderPrint({
    modalities <- modalities()
    modalities
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

