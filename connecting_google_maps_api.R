
r <- dim(stations)[1]

get_stations <- NULL
name<- NULL
district <- NULL
county <- NULL
city <- NULL
lat <- NULL
lon <- NULL
geo_info <- NULL
get_stations_final <- NULL

for (i in 1:1000)
{
  get_stations <- fromJSON(getURL(paste('https://maps.googleapis.com/maps/api/geocode/json?address=',str_replace_all(as.matrix(stations$DURAK)[i]," ", "+"),'&key=AIzaSyCXgoUvFzFBDmW0eeLjXLrOEvqa8uMsFtQ',sep="")))
  #name<- get_stations$results$address_components[[1]][str_detect( get_stations$results$address_components[[1]][,3], 'route'),2]
  if(length(which(str_detect( get_stations$results$address_components[[1]][,3], 'administrative_area_level_4')))==0)
  {
    district <- "N/A"
  }
  else
  {
  district <- get_stations$results$address_components[[1]][which(str_detect( get_stations$results$address_components[[1]][,3], 'administrative_area_level_4')),2]
  }
  
  if(length(which(str_detect( get_stations$results$address_components[[1]][,3], 'administrative_area_level_2')))==0)
  {
    county <- "N/A"
  }
  else
  {
  county <- get_stations$results$address_components[[1]][which(str_detect( get_stations$results$address_components[[1]][,3], 'administrative_area_level_2')),2]
  }
  if(length(which(str_detect( get_stations$results$address_components[[1]][,3], 'administrative_area_level_1')))==0)
  {
    city <- "N/A"
  }
  else
  {
  city <- get_stations$results$address_components[[1]][which(str_detect( get_stations$results$address_components[[1]][,3], 'administrative_area_level_1')),2]
  }
  
  if(get_stations$status=='ZERO_RESULTS')
  {
  lat <- "N/A"
  lon <- "N/A"
  }
  else
  {
  lat <- get_stations$results$geometry$location$lat
  lon <- get_stations$results$geometry$location$lng
  }
  
  geo_info <- data.frame(district,county,city,lat,lon)
  get_stations_final <- rbind(get_stations_final,geo_info)
}
