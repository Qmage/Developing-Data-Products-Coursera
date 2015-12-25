library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Calculate your BMR and BMI"),
  
  sidebarLayout(
    mainPanel(
      HTML(paste("This is a shiny application that allows user to automatically calculate their <b>BMI</b> and <b>BMR</b>.",
                 "<br>",
                 "<h3><u>DOCUMENTATION</u></h3>",
                 "To use the application, please enter your gender, height, weight and age into the input panel on the right.",
                 "Once completed, click the submit button, then your BMR and BMI numbers will be calculated and displayed.",
                 "",
                 "<b>BMR (basal metabolic rate)</b> is the amount of energy (in the form of calories) that the body needs to function while resting for 24 hours. This number of calories reflects how much energy your body requires to support vital body functions if, hypothetically, you were resting in bed for an entire day. In fact, your BMR is the single largest component (upwards of 60 percent) of your total energy burned each day.",
                 "",
                 "<b>BMI (body mass index)</b> is a value derived from the mass (weight) and height of an individual. The BMI is defined as the body mass divided by the square of the body height, and is universally expressed in units of kg/m2. The BMI is an attempt to quantify the amount of tissue mass (muscle, fat, and bone) in an individual, and then categorize that person as underweight, normal weight, overweight, or obese based on that value.",
                 "","",
                 sep="<br/>")),
      
      img(src = "bmi.png", height = 300, width = 600)
    ),
    sidebarPanel(
      radioButtons("gender",label = "Select your gender",
                   choices = list("male" = 1, "female" = 2), inline=TRUE),
      radioButtons("height",label = "Enter your height",
                   choices = list("cm" = 1, "feet/inches" = 2),
                   selected = 1, inline=TRUE),
      conditionalPanel(condition = "input.height == 1",
                       div(style="display:inline-block",numericInput("heightCM", NULL, 160, step=5, min = 1, max = 300, width=80)),
                       "cm"),
      conditionalPanel(condition = "input.height == 2",
                       div(style="display:inline-block",
                           selectInput("heightFeet",NULL,c(1:8), width=60, selected=5)),
                       "feet   ",
                       div(style="display:inline-block",
                           selectInput("heightInch",NULL,c(1:11), width=60, selected=8)),
                       "inches"
                       ),
      radioButtons("weight",label = "Enter your weight",
                   choices = list("kgs" = 1, "lbs" = 2),
                   selected = 1,  inline=TRUE),
      conditionalPanel(condition = "input.weight == 1",
                       div(style="display:inline-block",numericInput("weightKG", NULL, 60, step=5, min = 1, max = 500, width=80))
                       ,"kgs"),
      conditionalPanel(condition = "input.weight == 2",
                       div(style="display:inline-block",numericInput("weightLB", NULL, 150, step=5, min = 1, max = 1000, width=80))
                       ,"lbs"),
      
      sliderInput("ageSlider",
                  "Select your age:",
                  min = 1,
                  max = 120,
                  value = 30),
      actionButton("submitButton","submit"),
      
      uiOutput("results")
      
    )
    
    
  )
))
