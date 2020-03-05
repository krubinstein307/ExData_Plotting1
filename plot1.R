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
png(filename="plot1.png", width=480, height=480)
hist(pwr_small$Global_active_power, 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency")
dev.off()
