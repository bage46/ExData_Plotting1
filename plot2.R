# Load the file into a data frame
ds <- read.table("household_power_consumption.txt",sep=";",header=FALSE, stringsAsFactors=FALSE,na.strings ="?",
                 col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Select only the rows with values recorded on either 01/02/2007 or 02/02/2007
ds2 <- subset(ds,Date=="1/2/2007" | Date=="2/2/2007")

# Define the data types for each variable in the data frame
ds2$Date <- as.Date(ds2$Date, format="%d/%m/%Y")
#ds2$Time <- strptime(ds2$Time, format = "%H:%M:%S")
ds2[, c(3:9)] <- sapply(ds2[, c(3:9)], as.numeric)

# Add a DateTime variable
ds2 <- mutate(ds2,DateTime = as.POSIXct(paste(ds2$Date, ds2$Time), format="%Y-%m-%d %H:%M:%S"))

# Plot a line type graph
plot(ds2$DateTime,ds2$Global_active_power,type="l", xlab="",ylab="Global Active Power (kilowatts)")

# Copy the plot to a png file
dev.copy(png,'plot2.png',width=480,height=480)
dev.off()