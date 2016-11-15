olddir <- getwd()
if (!file.exists("./data")) {
        dir.create("./data")
}
setwd("./data")
fileurl = "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
destfile <- "stormdata.bz2"
if (!exists("stormdata")) {
        download.file(fileurl, destfile)
        stormdata <- read.csv(destfile)
}

stormdata$TOTFATINJ <- stormdata$FATALITIES + stormdata$INJURIES
stormdata.pop.mean <-
        aggregate(TOTFATINJ ~ EVTYPE, data = stormdata, mean)
stormdata.pop.mean[stormdata.pop.mean$TOTFATINJ == max(stormdata.pop.mean$TOTFATINJ), ]
stormdata.pop.mean <-
        head(stormdata.pop.mean[order(-stormdata.pop.mean$TOTFATINJ), ], 4)
stormdata.pop.mean$EVTYPE <- factor(stormdata.pop.mean$EVTYPE, levels =stormdata.pop.mean$EVTYPE[order(-stormdata.pop.mean$TOTFATINJ)])
g <- ggplot(stormdata.pop.mean, aes(EVTYPE, TOTFATINJ))
g <- g + geom_col()
g <- g + ggtitle("Four most harmful storm types for personal health")
g <- g + labs(x = "Storm type", y = "Average of Fatalities and Injuries")
g <- g + theme(title = element_text(size = 14))
g <- g + theme(plot.title = element_text(hjust = 0.5))
g

stormdata$TOTDMG <- stormdata$PROPDMG + stormdata$CROPDMG
stormdata.econ.mean <-
        aggregate(TOTDMG ~ EVTYPE, data = stormdata, mean)
stormdata.econ.mean[stormdata.econ.mean$TOTDMG == max(stormdata.econ.mean$TOTDMG), ]
stormdata.econ.mean <- head(stormdata.econ.mean[order(-stormdata.econ.mean$TOTDMG), ], 4)
stormdata.econ.mean$EVTYPE <- factor(stormdata.econ.mean$EVTYPE, levels =stormdata.econ.mean$EVTYPE[order(-stormdata.econ.mean$TOTDMG)])

g <- ggplot(stormdata.econ.mean, aes(EVTYPE, TOTDMG))
g <- g + geom_col()
g <- g + ggtitle("Four most harmful storm types financially (property and crops)")
g <- g + labs(x="Storm type",y="Total Damage (in $)")
g <- g + theme(title = element_text(size = 14))
g <- g + theme(plot.title = element_text(hjust = 0.5))
g
setwd(olddir)
