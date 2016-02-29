LongLatString <- function(mydata){
  
  myCoords <- select(mydata, long, lat)

  myCoords <- as.matrix(myCoords)

  myLine <- Line(myCoords)

  myList <- list(myLine)

  myLines <- Lines(myList, ID = "lineZero")
  myNewList <- list(myLines)
  crs <- CRS("+proj=longlat")
  myLine.sl <- SpatialLines(myNewList, proj4string = crs)
  dummyData <- filter(mydata, row_number() == 1)

  myLine.sldf <- SpatialLinesDataFrame(myLine.sl, dummyData, match.ID = FALSE)

  spToGeoJSON <- function(x){
                tf<-tempfile()
                writeOGR(x, tf,layer = "geojson", driver = "GeoJSON")
                js <- paste(readLines(tf), collapse=" ")
                file.remove(tf)
                return(js)
              }

  myString <- spToGeoJSON(myLine.sldf)
  longLatString <- as.character(myString)

  
  return(longLatString)
  
  

}