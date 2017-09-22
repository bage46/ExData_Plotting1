# Load the file into a data frame
ds <- read.table("household_power_consumption.txt",sep=";",header=FALSE, stringsAsFactors=FALSE,na.strings ="?",
                 col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Select only the rows with values recorded on either 01/02/2007 or 02/02/2007
ds2 <- subset(ds,Date=="1/2/2007" | Date=="2/2/2007")

# Define the data types for each variable in the data frame
ds2$Date <- as.Date(ds2$Date, format="%d/%m/%Y")
ds2$Time <- strptime(ds2$Time, format = "%H:%M:%S")
ds2[, c(3:9)] <- sapply(ds2[, c(3:9)], as.numeric)

# Plot a histogram for the Global Active Power
hist(ds2$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)", ylab = "Frequency",col="red",xlim=c(0,6),ylim = c(0,1200),breaks=12,axes = FALSE)
axis(side=1,at=c(0,2,4,6))
axis(side=2,at=seq(0,1200,200))

# Copy the plot to a png file
dev.copy(png,'plot1.png',width=480,height=480)
dev.off()