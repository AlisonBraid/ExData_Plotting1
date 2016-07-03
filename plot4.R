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
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~Dateandtime, type="l", 
       xlab="", ylab="Global Active Power")
  plot(Voltage~Dateandtime, type="l", 
       xlab="datetime", ylab="Voltage")
  plot(Sub_metering_1~Dateandtime, type="l", 
       xlab="", ylab="Energy sub metering")
  lines(Sub_metering_2~Dateandtime,col="red")
  lines(Sub_metering_3~Dateandtime,col="blue")
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, box.lwd = 0,
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Dateandtime, type="l", 
       xlab="datetime", ylab="Global_reactive_power")
})

## Saving to file,
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()