## First we download the zipped file to a temporary file.
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
## Then we read the correct section of the data from within temp and remove the temp connection.
Data <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";", nrows = 2880, skip = 66636, header = TRUE)
unlink(temp)
## We fix Data by assigning column names and making the objects in the Date column into date objects.
colnames(Data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
                    "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
Data$Date <- as.Date(Data$Date, format = "%d/%m/%Y")

## Finally we make the plot
png("plot1.png")
plot.new()
with(Data, hist(Global_active_power, col="red",
                main = "Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()