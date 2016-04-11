library(sp)
library(dplyr)
library(rgdal)

source("DataFrame.R")
source("LongLatString.R")
source("TimeStampString.R")

shinyServer(
  function(input, output) {
     
     output$table <- renderTable({
      
      startDate <- input$dates[1]
      endDate <- input$dates[2]
      animalID <- input$animalID
      
      mydata <- DataFrame(animalID, startDate, endDate)

      mydata2 <- mydata

      mydata2$LMT_Date <- as.character(mydata2$LMT_Date)

      longLatString <- LongLatString(mydata)

      timeStampString <- TimeStampString(mydata)

      writeChar(longLatString, "longlat.txt")

      writeChar(timeStampString, "timeStamps.txt")

      return(mydata2)
  })
 }
)
