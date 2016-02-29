
library(ggplot2) 
library(DT)
library(doBy)
library(dplyr)
jsp <- read.csv("schooloutput_v2.csv")
jsp$r <- as.factor(jsp$r)





shinyServer(function(input, output) {

  df <-  read.csv("schooloutput_v2.csv")
  df$r <- as.factor(df$r)
  makeReactiveBinding("df")
  
  newdf <- reactive({
    
    input$district
    isolate({
      
      newdf <- df

      newdf <- subset(newdf, dis %in% input$district )
      myCols <- c("r","dis", input$Race)
      colNums <- match(myCols,names(newdf))
      newdf %>% select(colNums)
      
    })
   
    
  })

  
  
  
  
  

  output$racePlot <- renderPlot({
    
    myd <- subset(jsp, dis %in% input$district  )
    mydata <- data.frame(rating = myd$r, race = myd[,input$Race] )
      p1 <- ggplot(mydata, aes(x = rating, y = race)) + geom_point(color="red") + labs(x="Great Schools Rating",y="Race Percentage") 
  print(p1)
      
      
    
    
  })
  
  


    output$prettysumm <- renderTable({
      e <- newdf()
      #names(e)
      s <- summaryBy(  . ~ r , data = e, FUN = mean)
      s <- setNames(s, c("Great Schools Rating",paste0("% " , c(input$Race))))
    })





output$view <- DT::renderDataTable( {df}, options = list(pageLength = 5), filter = 'bottom',rownames = FALSE)





  
})