get_fs <- function(lat,lon,date,radius)
{
library(rjson)
library(RCurl)

lt <- toString(lat)  
ln <- toString(lon)
dt <- toString(date)
rds <- toString(radius)
#return(c(lt,ln,dt,rds))
#}

dd <- fromJSON(getURL(paste('https://api.foursquare.com/v2/venues/trending?ll=',lt,',',ln,'&radius=',rds,'&client_id=YOUR-CLIENT-ID&limit=50&client_secret=YOUR-CLIENT-SECRET&v=',date,sep="")))


d <- length(dd$response$venues)

no_venues = length(dd$response$venues)

df = data.frame(no = 1:no_venues)


for (i in 1:nrow(df)){
  
  #Add Name and the location of the Venue
  df$venue_name[i] <- dd$response$venues[[i]]$name
  df$venue_lat[i] <- dd$response$venues[[i]]$location$lat
  df$venue_lng[i] <- dd$response$venues[[i]]$location$lat

##########################
#Add the address of the location 
if(length(dd$response$venues[[i]]$location$address)>0)
{
  df$venue_address[i] <- dd$response$venues[[i]]$location$address
}
else{
  df$venue_address[i] <- "No Address Available"
  
}


##########################
#Add the citiy of the location
if(length(dd$response$venues[[i]]$location$city)>0)
{
  df$venue_city[i] <- dd$response$venues[[i]]$location$city
}
else{
  df$venue_city[i] <- "No City Available"
}

##########################
#Add the number of check-ins of the venue
df$venue_checkinsCount[i] <- dd$response$venues[[i]]$stats$checkinsCount
df$venue_usersCount[i] <- dd$response$venues[[i]]$stats$usersCount
}
return(df)
}
