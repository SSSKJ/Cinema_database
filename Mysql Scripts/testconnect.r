install.packages("RMySQL")
library(RMySQL)
#
mydb <- dbConnect(MySQL(), user = 'studentuser', password = 'DBMS_class19',
                  dbname = 'Final', host = 'localhost:3306')
#
dbListTables(mydb)
#
dbListFields(mydb, 'city')
#
rs <- dbSendQuery(mydb, "select c1.Name 
                  from country c1, countrylanguage c2 where c1.code = c2.countrycode
                 and c2.language = 'english'")
#
dbFetch(rs)
#
dbClearResult(rs)
#
dbDisconnect(mydb)
#