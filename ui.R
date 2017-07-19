shinyUI(navbarPage("Economic Order Quantity", collapsable = TRUE,
           tabPanel("Model"
                    ,fluidPage(tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "../css/custom.css"))
                               ,theme = shinytheme("flatly"),sidebarLayout(
                      sidebarPanel(
                        h4("Input Values", align = "center")
                        ,sliderInput(inputId ="Demand" , label = "Demand (Units)", min = 100 , max = 2400, value = 800 )
                        ,sliderInput(inputId ="holdCost" , label = "Holding Cost ($ per Units per Year)", min =0 , max = 100, value =  35)
                        ,sliderInput(inputId ="setUpCost" , label = "Set-up Cost ($)", min =0 , max = 2000, value = 500 )
                        ,sliderInput(inputId ="prodCost" , label = "Prod Cost ($)", min =0 , max = 220 , value = 5)
                        ,numericInput(inputId = "bestGuess","Enter your Best Guess for Q", value = 300)
                      ),
                      mainPanel(tabsetPanel(tabPanel("Visualization"
                                                      ,fluidRow(splitLayout(cellWidths = c("10%", "80%", "10%")
                                                                            ,br()
                                                                            ,div(h3("Cost-Quantity Relationship", align = "center"),lineChartOutput("mychart", height = 380))
                                                                            ,br()
                                                                            )
                                                                )
                                                      ,fluidRow(splitLayout(cellWidths = c("40%", "20%","40%")
                                                          ,uiOutput("est_res")
                                                          ,uiOutput("optDiff")
                                                          ,uiOutput("eoq_res")
                                                      ))
                                                    )
                                            ,tabPanel("Data",dataTableOutput("datT"))

                      ))
                    ))
           )

))
