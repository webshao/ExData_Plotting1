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
png(file = "plot3.png", width = 480, height = 480)

# Plot the stair step graph
plot(sdf$RealDateTime, sdf$Sub_metering_1,
     type="s", main="", ylab="Energy sub metering", xlab="")
lines(sdf$RealDateTime, sdf$Sub_metering_2, type="s", col="red")
lines(sdf$RealDateTime, sdf$Sub_metering_3, type="s", col="blue")
# Add legend
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),
       col=c("black","red","blue"))

# Close the PNG file device
dev.off()
