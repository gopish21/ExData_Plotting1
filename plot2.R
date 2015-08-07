library(dplyr)

#read data from the text file, start from row 2 and only read data from 2007-02-01 to 2007-02-02
powerconsump <- read.table("household_power_consumption.txt", sep=";", skip=1, na.strings="?") %>%
        mutate(V1=as.Date(V1,"%d/%m/%Y"))  %>%
        subset(V1>="2007-02-01" & V1<="2007-02-02")
colnames(powerconsump) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#combine the date and time variable into one column as datetime
powerconsump$datetime <- paste(powerconsump$Date, powerconsump$Time)
powerconsump$datetime <- as.POSIXct(powerconsump$datetime, format="%Y-%m-%d %H:%M:%S")

#plot graph and save it in png format
png(file="plot2.png", width=480, height=480)
plot(powerconsump$Global_active_power~powerconsump$datetime, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()