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

par(mfrow=c(2,2))

# Build the topleft plot
plot(ds2$DateTime,ds2$Global_active_power,type="l", xlab="",ylab="Global Active Power")

# Build the topright plot
plot(ds2$DateTime,ds2$Voltage,type="l", xlab="datetime",ylab="Voltage",ylim=c(234,246),yaxt="n")
axis(side=2,at=c(234,238,242,246))

# Build the bottomleft plot
plot(ds2$DateTime,ds2$Sub_metering_1,type="l", xlab="",ylab="Energy sub metering")
lines(ds2$DateTime,ds2$Sub_metering_2,col="red")
lines(ds2$DateTime,ds2$Sub_metering_3,col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,bty = "n")

# Build the bottomright plot
plot(ds2$DateTime,ds2$Global_reactive_power,type="l", xlab="datetime",ylab="Global_reactive_power")

# Copy the plot to a png file
dev.copy(png,'plot4.png',width=480,height=480)
dev.off()