
#Connecting Google MAPS API by using R. First of all you need get your API KEY to connect the API. A
#After that you could connect API with following steps.

#setting loop step. Dont forget that Google Maps API's daily request size is 2500!
r <- dim(stations)[1]


#setting variables will be used.
get_stations <- NULL
name<- NULL
district <- NULL
county <- NULL
city <- NULL
lat <- NULL
lon <- NULL
geo_info <- NULL
get_stations_final <- NULL

#setting loop connecting Google Maps API and getting data.
for (i in 1:r)
{
  #connecting Google Maps API using jsonlite and RCurl library.
  get_stations <- fromJSON(getURL(paste('https://maps.googleapis.com/maps/api/geocode/json?address=',str_replace_all(as.matrix(stations$from)[i]," ", "+"),'YOUR_KEY',sep="")))

  #getting district name of location
  if(length(which(str_detect(get_stations$results$address_components[[1]][,3], 'administrative_area_level_4')))==0)
  {
    district <- "N/A"
  }
  else
  {
  district <- get_stations$results$address_components[[1]][which(str_detect( get_stations$results$address_components[[1]][,3], 'administrative_area_level_4')),2]
  }
  
  #getting county name of location
  if(length(which(str_detect( get_stations$results$address_components[[1]][,3], 'administrative_area_level_2')))==0)
  {
    county <- "N/A"
  }
  else
  {
  county <- get_stations$results$address_components[[1]][which(str_detect( get_stations$results$address_components[[1]][,3], 'administrative_area_level_2')),2]
  }
  
  #getting city name of location
  if(length(which(str_detect( get_stations$results$address_components[[1]][,3], 'administrative_area_level_1')))==0)
  {
    city <- "N/A"
  }
  else
  {
  city <- get_stations$results$address_components[[1]][which(str_detect( get_stations$results$address_components[[1]][,3], 'administrative_area_level_1')),2]
  }
  
  #checking API response status and getting lat-long values.
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
  
  #concating all variables
  geo_info <- data.frame(district,county,city,lat,lon)
  
  #assigning each response to a variable
  get_stations_final <- rbind(get_stations_final,geo_info)
}
