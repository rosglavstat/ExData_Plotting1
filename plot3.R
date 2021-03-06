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

png(file="plot3.png", width=480, height=480) #Open png device to write to png file

#Draw a plot with one line first (black line for Sub_metering_1)
#add 2 more lines (blue and red) using lines() function
#add legend using legend() function. Position - topright, lty parameter for lines 
plot(as.POSIXct(paste(consumpt_20070201$Date, consumpt_20070201$Time), "%d/%m/%Y %H:%M:%S", tz="UCT"), consumpt_20070201$Sub_metering_1, type="l", ylab = "Energy sub metering ", xlab=NA)
lines(as.POSIXct(paste(consumpt_20070201$Date, consumpt_20070201$Time), "%d/%m/%Y %H:%M:%S", tz="UCT"), consumpt_20070201$Sub_metering_2, col="red")
lines(as.POSIXct(paste(consumpt_20070201$Date, consumpt_20070201$Time), "%d/%m/%Y %H:%M:%S", tz="UCT"), consumpt_20070201$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()  ## Close the PNG device