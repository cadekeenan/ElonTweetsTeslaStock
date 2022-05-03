rm(list=ls())

Sys.setenv(BEARER_TOKEN= 'AAAAAAAAAAAAAAAAAAAAAP%2FybAEAAAAAgTaXRyY2%2Fgdmxk4o%2BLOcr4ba7TI%3DgAeYLwqGaq3Z39Yz2o4Bk1wqF1LOHHJWzMkpdZO4VzdFQFfQTk')
library(httr)
library(jsonlite)
library(dplyr)
library(twitteR)

tesla<-read.csv('TSLA.csv')
View(tesla)

tesla$created <- as.Date(tesla$Date,
                       format = "%m/%d/%Y")

appname<-"Elon v3"
key<-'1I6DdpphjUlAEDT3B4RN3qmYQ'
secret<-'ri127qTOCggRdWuEEOYgiF1qb2toDt5pglCIStz8q3yhSYShqW'
access_token<-'1169664618639319041-vcyxyLZRaxntq5CngKreGVE6rWOh1m'
access_secret<-'bsWqdKFm1n7IFVP33TB9lD3irdfIFWuX07ukTLKfJQTPY'
setup_twitter_oauth(key, secret, access_token, access_secret)


?userTimeline # Return timeline of user's tweets, retweets, and replies
musk_tweets<-userTimeline('elonmusk', # User
                          n=3200, # Max number to return
                          includeRts=TRUE, # Include retweets?
                          excludeReplies=FALSE) # Exclude replies?
musk_df<-twListToDF(musk_tweets)

musk_df$created<-as.Date(musk_df$created) # need to make sure this column is in the same form 
                                          # as the stock data

tweets_summary<-musk_df %>% group_by(created) %>% tally() #total tweets on each day (including retweets)
tweets_summary

retweets_summary<-musk_df %>% group_by(created) %>% tally(retweetCount) #total retweets from those tweets above
retweets_summary

favorites_summary<-musk_df %>% group_by(created) %>% tally(favoriteCount) #Total favorites from those tweets above
favorites_summary
View(musk_df)

elontesla<-merge(musk_df,tesla,all.x=T,by='created')

View(elontesla)

elonteslafiltered<-subset(elontesla,is.na(elontesla$Adj.Close)==F)
View(x)
