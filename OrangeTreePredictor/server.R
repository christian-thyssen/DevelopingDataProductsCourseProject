library(shiny)
library(splines)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
    thematic::thematic_shiny()
    
    model <- reactive({
        knots <- input$knots
        degree <- input$degree
        lm(
            circumference ~ bs(age, df = knots + degree, degree = degree),
            data = Orange
        )
    })
    
    prediction <- reactive({
        age <- input$age
        newdata <- data.frame(age = age)
        predict(model(), newdata = newdata)
    })
    
    output$plot <- renderPlot({
        p <- Orange %>%
            ggplot(aes(x = age, y = circumference, colour = Tree))
        
        if(input$show.title) {
            p <- p +
                labs(title = "Growth of Orange Trees")
        }
        
        if(input$show.model) {
            fun <- function(x) {
                newdata <- data.frame(
                    age = x
                )
                predict(model(), newdata = newdata)
            }
            p <- p +
                geom_function(fun = fun, colour = "red")
        }
        
        p <- p +
            geom_point(size = 3)
        
        if(input$show.prediction) {
            p <- p +
                geom_point(
                    aes(x = input$age, y = prediction()),
                    colour = "red",
                    size = 3
                )
        }
        
        p
    })
    
    output$error <- renderText({
        paste(
            "Residual standard error:",
            round(sqrt(deviance(model()) / df.residual(model())), 2),
            "mm"
        )
    })
    
    output$prediction <- renderText({
        paste(
            "Predicted circumference:",
            round(prediction(), 2),
            "mm"
        )
    })
})
