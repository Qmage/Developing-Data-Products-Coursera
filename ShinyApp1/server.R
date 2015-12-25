library(shiny)

calculateBMR <- function(input){
  weightVar <- if(input$weight == 1){
    input$weightKG
  }else{
    input$weightLB * 0.453592
  }
  heightVar <- if(input$height == 1){
    input$heightCM
  }else{
    (as.numeric(input$heightFeet) * 30.48) + (as.numeric(input$heightInch) * 2.54)
  }
  
  ageVar <- input$ageSlider
  
  resultBMR <- if(input$gender == 1){
    10 * weightVar + 6.25 * heightVar - 5 * ageVar + 5
  }else{
    10 * weightVar + 6.25 * heightVar - 5 * ageVar - 161
  }
  return(resultBMR)
}


calculateBMI <- function(input){
  weightVar <- if(input$weight == 1){
    input$weightKG
  }else{
    input$weightLB * 0.453592
  }
  heightVar <- if(input$height == 1){
    input$heightCM/100
  }else{
    ((as.numeric(input$heightFeet) * 30.48) + (as.numeric(input$heightInch) * 2.54))/100
  }
  
  resultBMI <- (weightVar/heightVar^2)
  return(resultBMI)
}



shinyServer(function(input, output) {
  currentCount <- 0
  observe({
    if (input$submitButton == 0 || as.integer(input$submitButton) == currentCount) # tells action button to do nothing when not clicked ..
      return()
    currentCount <- input$submitButton
    print(currentCount)
    print(input$submitButton)
    output$results <- 
       renderUI({
        input$submitButton
        wellPanel(
          HTML("<b><u>Results:</b></u>"),
          br(),"Your BMR:",isolate(calculateBMR(input)),"calories/day",
          br(),"Your BMI:",isolate(calculateBMI(input))
          )

      })
    
    
    })

})
