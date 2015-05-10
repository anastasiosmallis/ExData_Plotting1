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
png(file = "plot2.png", width = 480, height = 480)
# Take the data I am to plot and turn them from factor to numeric
plot2Data<-as.numeric(levels(data$Global_active_power))[data$Global_active_power]

# Create Plot
plot(plot2Data, type = "l", ylab = "Global Active Power (killowatts)", xlab = "", xaxt = "n")

# Set the axis values (I convert the first column into date format and then into day of the week)
Days <- unique(as.Date(data$Date, "%d/%m/%Y"))
Days <- format(c(Days,Days[length(Days)]+1), "%a")

axis(1, at = c(1, length(plot2Data)/2, length(plot2Data)), labels = Days)

# Copy plot to a png file
dev.off()

#### Create Plot for Screen ####

# Create Plot
plot(plot2Data, type = "l", ylab = "Global Active Power (killowatts)", xlab = "", xaxt = "n")

# Set the axis values (I convert the first column into date format and then into day of the week)
Days <- unique(as.Date(data$Date, "%d/%m/%Y"))
Days <- format(c(Days,Days[length(Days)]+1), "%a")

axis(1, at = c(1, length(plot2Data)/2, length(plot2Data)), labels = Days)
