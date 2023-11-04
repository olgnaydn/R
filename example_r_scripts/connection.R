#calling library
library("RPostgreSQL")

#Loading PostgreSQL driver
drv <- dbDriver("PostgreSQL")

#connecting to db
con <- dbConnect(drv, dbname = "development", host = "development.clgjf7569y1t.us-west-2.rds.amazonaws.com", port = 5432,
                 user = "olgun", password = 'xxx')


#select operation from a table)
d<-dbGetQuery(con,"select * from test2")

#write operation to a table
dbWriteTable(con, "test", d)
