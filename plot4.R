## Read all data
pwr_all <- read.table("./data/household_power_consumption.txt", 
                      header=TRUE, 
                      sep=";", 
                      stringsAsFactors=FALSE, 
                      colClasses=c("character", "character", rep("numeric", 7)), 
                      na.strings="?")
## Convert Date field to date type
pwr_all$dttm <- as.POSIXct(paste(pwr_all$Date, pwr_all$Time), format="%d/%m/%Y %H:%M:%S")
pwr_all$Date <- as.Date(pwr_all$Date, format="%d/%m/%Y")

## Filter to just the two days of interest
pwr_small <- pwr_all[which(pwr_all$Date >= as.Date("2007-02-01") 
                           & pwr_all$Date <= as.Date("2007-02-02")), ]

## Plot to png
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2, 2))

## Plot 1 - Active power
plot(pwr_small$dttm, pwr_small$Global_active_power, 
     type="l", xlab="datetime", ylab="Global Active Power")

## Plot 2 - Voltage
plot(pwr_small$dttm, pwr_small$Voltage, type="l", xlab="datetime", ylab="Voltage")

## Plot 3 - Sub-metering
plot(pwr_small$dttm, pwr_small$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(pwr_small$dttm, pwr_small$Sub_metering_2, col="red")
lines(pwr_small$dttm, pwr_small$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, bty = "n")

## Plot 4 - Reactive power
plot(pwr_small$dttm, pwr_small$Global_reactive_power, 
     type="l", xlab="datetime", ylab="Global Reactive Power")
dev.off()
