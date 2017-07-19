shinyServer(function(input, output, session) {

  myData <- reactive({
    df <- createFrame(D = input$Demand,h=input$holdCost,A=input$setUpCost,c = input$prodCost )
  })


  diff_from_opt <- reactive({
    paste0(100*round(as.numeric( ((as.numeric(input$Demand)*(as.numeric(input$setUpCost)/as.numeric(input$bestGuess)))+(as.numeric(input$Demand)*((as.numeric(input$holdCost)*as.numeric(input$bestGuess))/(2*as.numeric(input$Demand))))) -
                  ((as.numeric(input$Demand)*(as.numeric(input$setUpCost)/(sqrt((2*as.numeric(input$setUpCost)*as.numeric(input$Demand))/as.numeric(input$holdCost))))) + (as.numeric(input$Demand)*(as.numeric(input$holdCost)*(sqrt((2*as.numeric(input$setUpCost)*as.numeric(input$Demand))/as.numeric(input$holdCost)))/(2*as.numeric(input$Demand))))))/((as.numeric(input$Demand)*(as.numeric(input$setUpCost)/as.numeric(input$bestGuess)))+(as.numeric(input$Demand)*((as.numeric(input$holdCost)*as.numeric(input$bestGuess))/(2*as.numeric(input$Demand))))),2),"%")
  })

  output$optDiff <- renderUI({
    div(

       h3("VS", align = "center")
      ,hr()
      ,br()
      ,h4("Estimate", align = "center")
      ,h2(diff_from_opt(), align = "center")
      ,h4("off", align = "center")
      # valueBox(value = diff_from_opt(), subtitle = "Differece from EOQ")
    )
  })

  output$datT <- renderDataTable({
    myData()
  })

  output$mychart <- renderLineChart({
    # Return a data frame. Each column will be a series in the line chart.
    df <- myData()
    xxy <- df[,2:ncol(df)]
    names(xxy)[1:4] <- c("Holding Cost","Setup Cost","Production Cost","Total Cost")
    xxy
  })


  output$yourOutputVals <- renderDataTable({
    sub <- data.frame(
      Expression = c("Order Quantity","Total Cost","Total Annual Hold","Total Annual Setup","Total Less c"),
      Formula =c("Q"," "," "," "," ") ,
      Result =c(as.numeric(input$bestGuess),
                as.numeric( ((as.numeric(input$holdCost)*as.numeric(input$bestGuess))/(2*as.numeric(input$Demand)) + (as.numeric(input$setUpCost)/as.numeric(input$bestGuess)) + (as.numeric(input$prodCost)))*as.numeric(input$Demand) ),
                as.numeric(as.numeric(input$Demand)*((as.numeric(input$holdCost)*as.numeric(input$bestGuess))/(2*as.numeric(input$Demand)))),
                as.numeric(as.numeric(input$Demand)*(as.numeric(input$setUpCost)/as.numeric(input$bestGuess))),
                as.numeric((as.numeric(input$Demand)*(as.numeric(input$setUpCost)/as.numeric(input$bestGuess)))+(as.numeric(input$Demand)*((as.numeric(input$holdCost)*as.numeric(input$bestGuess))/(2*as.numeric(input$Demand)))))
      )
    )
    colnames(sub)[1] <- "Metrics"
    sub[,-2]
  }, options = list(dom = 't'))




  output$eoqResults <- renderDataTable({
    sub2 <- data.frame(
      Expression = c("Order Quantity","Total Cost","Total Annual Hold","Total Annual Setup","Total Less c") ,
      Formula = c("sqrt(2AD/h)"," "," "," "," "),
      Result = c(as.numeric(sqrt((2*as.numeric(input$setUpCost)*as.numeric(input$Demand))/as.numeric(input$holdCost))),
                 as.numeric(as.numeric(input$Demand)*(as.numeric(input$holdCost)*(sqrt((2*as.numeric(input$setUpCost)*as.numeric(input$Demand))/as.numeric(input$holdCost)))/(2*as.numeric(input$Demand))
                                                      + (as.numeric(input$setUpCost)/(sqrt((2*as.numeric(input$setUpCost)*as.numeric(input$Demand))/as.numeric(input$holdCost)))) + as.numeric(input$prodCost))),
                 as.numeric(as.numeric(input$Demand)*(as.numeric(input$holdCost)*(sqrt((2*as.numeric(input$setUpCost)*as.numeric(input$Demand))/as.numeric(input$holdCost)))/(2*as.numeric(input$Demand)))),
                 as.numeric(as.numeric(input$Demand)*(as.numeric(input$setUpCost)/(sqrt((2*as.numeric(input$setUpCost)*as.numeric(input$Demand))/as.numeric(input$holdCost))))),
                 as.numeric((as.numeric(input$Demand)*(as.numeric(input$setUpCost)/(sqrt((2*as.numeric(input$setUpCost)*as.numeric(input$Demand))/as.numeric(input$holdCost)))))
                            + (as.numeric(input$Demand)*(as.numeric(input$holdCost)*(sqrt((2*as.numeric(input$setUpCost)*as.numeric(input$Demand))/as.numeric(input$holdCost)))/(2*as.numeric(input$Demand)))))

      )
    )
    colnames(sub2)[1] <- "Metrics"
    sub2[, -2]
  }, options = list(dom = 't'))

  output$eoq_res <- renderUI({
    div(
        h3("Optimal Q*", align = "center")
        ,dataTableOutput('eoqResults')
      )
  })

  output$est_res <- renderUI({
    div(
      h3("Estimated Q", align = "center")
      ,dataTableOutput('yourOutputVals')
    )
  })

})
