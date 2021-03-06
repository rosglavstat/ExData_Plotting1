#Download data file from the web
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/zipped_data.zip", method = "curl")

#Unzip the downloaded file to the working directory
unzip("./data/zipped_data.zip")

#Read the file into dataframe
#As dataset missing values are coded as "?" set na.strings to "?"
#Set stringsAsFactors parameter to False to prevent ambiguation
consumpt <- read.csv("household_power_consumption.txt", sep=";", na.strings = "?", stringsAsFactors = FALSE)

#Get a subset with needed data - dated 1/2/2007 and 2/2/2007 
consumpt_20070201 <- subset(consumpt, consumpt$Date=="1/2/2007" | consumpt$Date=="2/2/2007")

#Draw multiple charts
png(file="plot4.png", width=480, height=480) #Open png device to write to png file
par(mfrow=c(2,2), cex=0.75) #Prepare "workspace" for 4 charts (2 by 2 matrix)
#First chart (same as in plot2.R)
plot(as.POSIXct(paste(consumpt_20070201$Date, consumpt_20070201$Time), "%d/%m/%Y %H:%M:%S", tz="UTС"), consumpt_20070201$Global_active_power, type="l", ylab = "Global Active Power", xlab=NA)
#Second chart 
plot(as.POSIXct(paste(consumpt_20070201$Date, consumpt_20070201$Time), "%d/%m/%Y %H:%M:%S", tz="UTС"), consumpt_20070201$Voltage, type="l", ylab = "Voltage", xlab="datetime")
#Third chart (same as in plot3.R)
plot(as.POSIXct(paste(consumpt_20070201$Date, consumpt_20070201$Time), "%d/%m/%Y %H:%M:%S", tz="UTС"), consumpt_20070201$Sub_metering_1, type="l", ylab = "Energy sub metering ", xlab=NA)
lines(as.POSIXct(paste(consumpt_20070201$Date, consumpt_20070201$Time), "%d/%m/%Y %H:%M:%S", tz="UTС"), consumpt_20070201$Sub_metering_2, col="red")
lines(as.POSIXct(paste(consumpt_20070201$Date, consumpt_20070201$Time), "%d/%m/%Y %H:%M:%S", tz="UTС"), consumpt_20070201$Sub_metering_3, col="blue")
legend("topright", lty=1, xjust=0, col=c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#Fourth chart
plot(as.POSIXct(paste(consumpt_20070201$Date, consumpt_20070201$Time), "%d/%m/%Y %H:%M:%S", tz="UCT"), consumpt_20070201$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab="datetime")
dev.off()  ## Close the PNG device