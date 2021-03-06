## IF YOU HAVE ALREADY RUN PLOT1.R, FEEL FREE TO IGNORE THE SECTION OF CODE FROM HERE...
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
Data <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";", nrows = 2880, skip = 66636, header = TRUE)
unlink(temp)

colnames(Data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
                    "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
Data$Date <- as.Date(Data$Date, format = "%d/%m/%Y")
##... TO HERE.

datetime <- as.POSIXct(paste(Data$Date, Data$Time), format="%Y-%m-%d %H:%M:%S")
png("plot4.png")
plot.new()
par(mfrow = c(2,2))
with(Data, plot(datetime, Global_active_power, type="l", xlab = NULL,  ylab="Global Active Power (kilowatts)"))
with(Data, plot(datetime, Voltage, type="l", ylab="Voltage"))
with(Data, plot(datetime, Sub_metering_1, type="l", xlab = "",  ylab="Energy sub metering"))
with(Data, lines(datetime, Sub_metering_2, col="orange"))
with(Data, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", col=c("black", "orange", "blue"), lty=1, border = NULL, cex = 0.75,
       legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(Data, plot(datetime, Global_reactive_power, type="l", ylab="Global_reactive_power"))
dev.off()