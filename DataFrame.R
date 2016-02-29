DataFrame <- function(myID, startDate, endDate){
  
  mydata <- read.csv("data/gpsData.csv")
  
  mydata <- filter(mydata, animalID == myID)

  mydata$LMT_Date <- as.Date.character(mydata$LMT_Date, format = "%Y%m%d")

  mydata <- filter(mydata, LMT_Date >= startDate, LMT_Date <= endDate)
  
  return(mydata)
  
  

}