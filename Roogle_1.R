install.packages("RoogleVision", repos = c(getOption("repos"), "http://cloudyr.github.io/drat"))
devtools::install_github("MarkEdmondson1234/googleAuthR")
install.packages("googleAuthR")
require(googleAuthR)
require(bitops)
require(jsonlite)
require(magrittr)
require(stringi)
require(RoogleVision)

### credentials
options("googleAuthR.client_id" = "629611377311-5lmp1oddb0g27trms7un81oavgebt5a9.apps.googleusercontent.com")
options("googleAuthR.client_secret" = "xxxx")


devtools::install_github("cloudyr/RoogleVision",force=TRUE)


#getting images urls
images_url <- read.csv(file = "images.csv", header = TRUE, sep = ",")
images_url <- images_url$source_url
images_url <- as.matrix(images_url)




## use Google Auth R package

options("googleAuthR.scopes.selected" = c("https://www.googleapis.com/auth/cloud-platform"))
googleAuthR::gar_auth()

############
#Sending image to API
o <- getGoogleVisionResponse("http://image.xxxx.jpg", feature="LABEL_DETECTION")

