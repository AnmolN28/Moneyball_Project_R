setwd("/Users/anmolnahariya/Desktop/Spring21/Udemy R/Moneyball")

#Import moneyball csv file
df <- read.csv("batting.csv",)
head(df)
str(df)

head(df$AB)
head(df$X2B)

#New column Batting Average
df$BA <- df$H / df$AB
tail(df$BA,5)

#New Column On Base Percentage
df$OBP <- (df$H + df$BB + df$HBP)/(df$AB + df$BB + df$HBP + df$SF)
head(df$OBP)

# New Column X1B (Singles)
df$X1B <- df$H - df$X2B - df$X3B - df$HR

#New Column Slugging Percentage
df$SLG <- ((df$H - df$X2B -df$X3B - df$HR) + (2*df$X2B) + (3*df$X3B) + (4*df$HR))/df$AB
head(df$SLG)

str(df)

sal <- read.csv("Salaries.csv")

min(df$yearID)

#Subset with players after 1985

df <- subset(df,yearID>=1985)
summary(df)

#Merge both dataframes
newdf <- merge(df,sal,by=c('playerID','yearID'))

summary(newdf)

#Getting the lost players
lost_players <- subset(df,playerID %in% c('giambja01','damonjo01','saenzol01') )
head(lost_players)

lost_players <- subset(lost_players,yearID>=2001)
head(lost_players)

lost_players <- lost_players[,c('playerID','H','X2B','X3B','HR','OBP','SLG','BA','AB')]
head(lost_players)

library(dplyr)
avail.players <- filter(newdf,yearID==2001)

library(ggplot2)
ggplot(avail.players,aes(x=OBP,y=salary)) + geom_point()

avail.players <- filter(avail.players,salary<8000000,OBP>0)

avail.players <- filter(avail.players,AB >= 500)

possible <- head(arrange(avail.players,desc(OBP)),10)

possible <- possible[,c('playerID','OBP','AB','salary')]

possible

possible[2:4,]

