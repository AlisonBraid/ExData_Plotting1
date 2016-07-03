## Get data
data_complete <- read.csv("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", 
                          nrows=2075259, check.names=FALSE, stringsAsFactors=FALSE, comment.char="", quote='\"')
data_complete$Date <- as.Date(data_complete$Date, format="%d/%m/%Y")


## Subset
data <- subset(data_complete, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_complete)

## Modify dates
dateandtime <- paste(as.Date(data$Date), data$Time)
data$Dateandtime <- as.POSIXct(dateandtime)

## Plot
with(data, {
  plot(Sub_metering_1~Dateandtime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Dateandtime, col="red")
  lines(Sub_metering_3~Dateandtime, col="blue")
})
legend("topright", lty=1,lwd=2, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save to file
dev.copy(png, file="plot3.png")
dev.off()