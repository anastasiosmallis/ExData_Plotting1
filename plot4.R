#### Setting the working directory ####
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

#### Reading the data ####
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)

# Reading the data from the file
data <- read.table(unz(temp, "household_power_consumption.txt"), header = T, sep = ";")
unlink(temp)

# Keeping only the data that is needed and removing the rest of it
data <- data[data$Date =="1/2/2007" | data$Date == "2/2/2007",]

#### Create Plot ####
png(file = "plot4.png", width = 480, height = 480)
par(mfcol=c(2,2))

#### plot in 1,1 ####
# Take the data I am to plot and turn them from factor to numeric
plot2Data<-as.numeric(levels(data$Global_active_power))[data$Global_active_power]

# Create Plot
plot(plot2Data, type = "l", ylab = "Global Active Power (killowatts)", xlab = "", xaxt = "n")

# Set the axis values (I convert the first column into date format and then into day of the week)
Days <- unique(as.Date(data$Date, "%d/%m/%Y"))
Days <- format(c(Days,Days[length(Days)]+1), "%a")

axis(1, at = c(1, length(plot2Data)/2, length(plot2Data)), labels = Days)

#### plot in 2,1 ####
# Take the data I am to plot and turn them from factor to numeric
plot3Data1<-as.numeric(levels(data$Sub_metering_1))[data$Sub_metering_1]
plot3Data2<-as.numeric(levels(data$Sub_metering_2))[data$Sub_metering_2]
plot3Data3<-data$Sub_metering_3

plot(plot3Data1, type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n")
lines(plot3Data2, col ="red")
lines(plot3Data3, col ="blue")

axis(1, at = c(1, length(plot3Data1)/2, length(plot3Data1)), labels = Days)

# Add legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3") ,lty=c(1,1,1), col=c("black","red","blue"),bty = "n")

#### plot in 1,2 ####
Voltage <- as.numeric(levels(data$Voltage))[data$Voltage]
plot(Voltage, type ="l", xlab = "datetime", xaxt = "n")

axis(1, at = c(1, length(plot3Data1)/2, length(plot3Data1)), labels = Days)

#### plot in 2,2 ####
Global_reactive_power <- as.numeric(levels(data$Global_reactive_power))[data$Global_reactive_power]
plot(Global_reactive_power, type ="l", xlab = "datetime", xaxt = "n")

axis(1, at = c(1, length(plot3Data1)/2, length(plot3Data1)), labels = Days)

dev.off()

#### Create plot for screen ####
par(mfcol=c(2,2))

#### plot in 1,1 ####

# Create Plot
plot(plot2Data, type = "l", ylab = "Global Active Power (killowatts)", xlab = "", xaxt = "n")

# Set the axis values (I convert the first column into date format and then into day of the week)
Days <- unique(as.Date(data$Date, "%d/%m/%Y"))
Days <- format(c(Days,Days[length(Days)]+1), "%a")

axis(1, at = c(1, length(plot2Data)/2, length(plot2Data)), labels = Days)

#### plot in 2,1 ####

plot(plot3Data1, type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n")
lines(plot3Data2, col ="red")
lines(plot3Data3, col ="blue")

axis(1, at = c(1, length(plot3Data1)/2, length(plot3Data1)), labels = Days)

# Add legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3") ,lty=c(1,1,1), col=c("black","red","blue"),bty = "n")

#### plot in 1,2 ####

plot(Voltage, type ="l", xlab = "datetime", xaxt = "n")

axis(1, at = c(1, length(plot3Data1)/2, length(plot3Data1)), labels = Days)

#### plot in 2,2 ####

plot(Global_reactive_power, type ="l", xlab = "datetime", xaxt = "n")

axis(1, at = c(1, length(plot3Data1)/2, length(plot3Data1)), labels = Days)
