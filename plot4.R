# Set the working directory, modify this line to specify your own
setwd("/home/wshao/school/coursera/ExData/ExData_Plotting1")

# Read the dataframe in
df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE)

# Add a column to convert the d/m/Y format to Y-m-d
df$RealDate <- as.Date(df$Date, "%d/%m/%Y")

# Use that newly created column to subset just the rows with the dates of interest
sdf <- df[(df$RealDate == as.Date('2007-02-01')) | (df$RealDate == as.Date('2007-02-02')),]

# Create a character string representation of the date and time by concatenating the two
sdf$DateTime <- paste(sdf$Date, sdf$Time, sep = ' ') 

# Create a date/time object from the character string
sdf$RealDateTime <- strptime(sdf$DateTime, "%d/%m/%Y %H:%M:%S")

# Make the column "Global_active_power" numeric
sdf$Global_active_power <- as.numeric(sdf$Global_active_power)

# Create the PNG file
png(file = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

# Subplot 1
plot(sdf$RealDateTime, sdf$Global_active_power,
     type="l", main="", ylab="Global Active Power", xlab="")

# Subplot 2
plot(sdf$RealDateTime, sdf$Voltage,
     type="l", main="", ylab="Voltage", xlab="datetime")

# Subplot 3
plot(sdf$RealDateTime, sdf$Sub_metering_1,
     type="s", main="", ylab="Energy sub metering", xlab="")
lines(sdf$RealDateTime, sdf$Sub_metering_2, type="s", col="red")
lines(sdf$RealDateTime, sdf$Sub_metering_3, type="s", col="blue")
# Add legend, no border
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),
       bty="n",
       col=c("black","red","blue"))

# Subplot 4
#   It is really hard to tell if this small subplot on the project writeup has 
#   a point symbol plot overlaying the lines, if there is, my best guess is that
#   it is pch = ".", the tiniest round point available
plot(sdf$RealDateTime, sdf$Global_reactive_power, pch=".",
     type="o", main="", ylab="Global_reactive_power", xlab="datetime")

# Close the PNG file device
dev.off()
