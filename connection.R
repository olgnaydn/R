
library("RPostgreSQL")

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname = "development", host = "development.clgjf7569y1t.us-west-2.rds.amazonaws.com", port = 5432,
                 user = "olgun", password = 'xxx')




#tablodan select etme
d<-dbGetQuery(con,"select * from test2")

#tabloya yazdirma
dbWriteTable(con, "test", d)
