TimeStampString <- function(mydata){
  
  data2 <- mutate(mydata, dateTime = paste(LMT_Date, LMT_Time, sep = " "))
  data2$dateTime <- as.character(data2$dateTime)
  data2$dateTime <- as.POSIXct(strptime(data2$dateTime, format = "%Y-%m-%d %H:%M:%S"))
  data2$dateTime <- as.numeric(data2$dateTime)
  data3 <- select(data2, dateTime)
  timeStampString <- as.character(data3)
  
  
  return(timeStampString)
  
  

}