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

png(filename="plot3.png", width=480, height=480)
with(data, {
  plot(DateTime, Sub_metering_1, type="l", xlab="",
       ylab="Energy sub metering")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
  legend("topright", lty="solid", col=c("black", "red", "blue"),
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
})
dev.off()