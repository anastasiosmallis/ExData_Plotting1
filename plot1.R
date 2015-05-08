#### Reading the data ####
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)

# Reading the data from the file
data <- read.table(unz(temp, "household_power_consumption.txt"), header = T, sep = ";")
unlink(temp)

# Create column that has both date and time
DateTime <-paste(data$Date,data$Time)

# Convert into datetime
DateTime <- strptime(DateTime, "%Y-%m-%d %H:%M:%S")

# Replace first two columns with the new column
data <- data[,-c(1,2)]
data <- cbind(DateTime, data)

#### Create Plot ####
# Take the data I am to plot and turn them from factor to numeric
plot1Data<-as.numeric(levels(data$Global_active_power))[data$Global_active_power]

# Clean from empty Values
plot1Data <- plot1Data[!plot1Data=="?"]

# Create histogram
hist(plot1Data,main = "Global Active Power", xlab = "Global Active Power (killowatts)", col = "red")

# Copy plot to a png file
dev.copy(png, file = "plot1.png")
dev.off()
