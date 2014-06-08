tmp.data <- read.table(file="household_power_consumption.txt",
                       header=T, sep=";", na.strings="?", nrows=2)
header <- names(tmp.data)
tmp.data <- read.table(file="household_power_consumption.txt",
                       header=T, sep=";", na.strings="?",
                       nrows=4000, skip=66240)
names(tmp.data) <- header
data <- subset(tmp.data, Date %in% c("1/2/2007", "2/2/2007") )
data$DateTime <- paste(data$Date, data$Time, sep="-")
data$DateTime <- strptime(data$DateTime, format="%d/%m/%Y-%H:%M:%S")

data$Sub_metering_1 <- as.integer(data$Sub_metering_1)
data$Sub_metering_2 <- as.integer(data$Sub_metering_2)
data$Sub_metering_3 <- as.integer(data$Sub_metering_3)


png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4.1, 4.1, 4.1, 2.1))
with(data, {
  ## 1st plot
    plot(DateTime, Global_active_power, type="l", xlab="",
         ylab="Global Active Power")
  ## 2nd plot  
    plot(DateTime, Voltage, type="l", xlab="datetime")
  ## 3rd plot
    plot(DateTime, Sub_metering_1, type="l", xlab="",
         ylab="Energy sub metering")
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright", lty="solid", col=c("black", "red", "blue"),
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           bty="n")
  ## 4th plot
    plot(DateTime, Global_reactive_power, type="l", xlab="datatime")
  })
dev.off()