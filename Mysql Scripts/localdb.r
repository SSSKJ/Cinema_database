install.packages("RMySQL")
library(RMySQL)
library(ggplot2)

db <- dbConnect(MySQL(), user = "guest", password = "123456", dbname = "Final", host = "localhost")

dbListTables(db)

rs <- dbSendQuery(db, "select s.type, sum(sd.quantity) as 'total_sell'
                  from snack s, snack_detail sd where s.id = sd.snack_id
                 group by sd.snack_id")
#
df <- dbFetch(rs)
df
#
ggplot(data=df, mapping=aes(x=type,y=total_sell))+
  geom_bar(stat="identity",width=0.5, color='red',fill='steelblue')


dbClearResult(rs)
#
dbDisconnect(db)
