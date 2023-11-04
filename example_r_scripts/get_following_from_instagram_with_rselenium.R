#load libraries
library(rvest)
library(stringr)
library(RSelenium)

#create null dataframes
uname_bio_df <- NULL
username_df<- NULL

#connect selenium drivers 
rD <- rsDriver()
remDr <- rD[["client"]]

#navigate your instagram profile
remDr$navigate("https://www.instagram.com/yourusername")

#detecting followin section
webElem <- remDr$findElement(using = "xpath", "//*[@id='react-root']/section/main/article/header/div[2]/ul/li[3]/a")

#click following to get list of users you are following
webElem$clickElement()

#detecting a user you are following
  webElem2 <- remDr$findElement(using = "xpath", paste("/html/body/div[4]/div/div[2]/div/div[2]/div/div[2]/ul/li[1]/div/div[1]/div/div[1]/a",sep=""))

#send scroll down event to update userlist
  for(i in 1:50)
  {
  webElem2$sendKeysToElement(list(key = 'end'))
  Sys.sleep(3)  
  }
 
 #get usernames from the list
  for (j in 1:486)
  {
  webElem3 <- remDr$findElement(using = "xpath", paste("/html/body/div[4]/div/div[2]/div/div[2]/div/div[2]/ul/li[",j,"]/div/div[1]/div/div[1]/a",sep=""))
  username <- webElem3$getElementText()[[1]][1]
  username_df <- rbind(username_df,username)
  }
  
 #navigate the users' profile and get bio information
  for(t in 1:length(username_df))
  {
  remDr$navigate(paste("https://www.instagram.com/",username_df[t],sep=""))
  Sys.sleep(3)
  webElem4 <- remDr$findElement(using = "xpath", "//div[@class='_tb97a']")
  bio <- webElem4$getElementText()[[1]][1]

  uname_bio <- data.frame(username_df[t], bio)
  uname_bio_df <- rbind(uname_bio_df,uname_bio)
  }


#stop selenium driver
rD[["server"]]$stop() 



