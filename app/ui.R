library(shiny)

shinyUI(fluidPage(
    theme = bslib::bs_theme(bootswatch = "sandstone"),
    titlePanel("Orange Tree Predictor"),
    sidebarLayout(
        sidebarPanel(
            h4("Configuration"),
            h5("Plot"),
            checkboxInput(
                "show.title",
                "Show/Hide title",
                TRUE
            ),
            checkboxInput(
                "show.model",
                "Show/Hide model",
                TRUE
            ),
            checkboxInput(
                "show.prediction",
                "Show/Hide prediction",
                TRUE
            ),
            h5("Spline Regression Model"),
            sliderInput(
                "knots",
                "Number of knots:",
                min = 0,
                max = 5,
                value = 0
            ),
            sliderInput(
                "degree",
                "Degree of piecewise polynomials:",
                min = 1,
                max = 5,
                value = 1
            ),
            h5("Prediction"),
            numericInput(
                "age",
                "Age of orange tree:",
                (min(Orange$age) + max(Orange$age)) / 2,
                min = min(Orange$age),
                max = max(Orange$age),
                step = 100
            ),
        ),
        mainPanel(
            tabsetPanel(
                tabPanel(
                    "Results",
                    h5("Plot"),
                    plotOutput("plot"),
                    h5("Spline Regression Model"),
                    textOutput("error"),
                    h5("Prediction"),
                    textOutput("prediction"),
                ),
                tabPanel(
                    "Help",
                    h5("Data"),
                    "This application is based on the data frame 'Orange' from the package 'datasets'.",
                    "It contains 35 rows and 3 columns of records of the growth of orange trees.",
                    "The columns are 'Tree', 'age' and 'circumference'.",
                    "The column 'Tree' is an ordered factor indicating the tree on which the measurement is made.",
                    "The ordering is according to increasing maximum diameter.",
                    "The column 'age' is a numeric vector giving the age of the tree (days since 1968-12-31).",
                    "The column 'circumference' is a numeric vector of trunk circumferences (mm).",
                    "This is probably 'circumference at breast height', a standard measurement in forestry.",
                    h5("Plot"),
                    "The scatter plot shows the data.",
                    "The x-axis shows the age, the y-axis the circumference, and the colour the tree.",
                    "Using the controls on the lefthand side you can show or hide the title, the model, and the prediction.",
                    h5("Spline Regression Model"),
                    "We fit a basis spline to explain the data.",
                    "The spline can be shown in the plot.",
                    "The residual standard error is shown below the plot.",
                    "On the lefthand side you can choose the number of (internal) knots and the degree of the piecewise polynomials.",
                    "Strange things happen if you increase both, the number of knots and the degree.",
                    h5("Prediction"),
                    "You can choose the age of an orange tree.",
                    "The currrent model is used to predict the circumference of the orange tree.",
                    "It can be shown in the plot.",
                    "The predicted circumference is shown below the plot."
                )
            )
        )
    )
))
