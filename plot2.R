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

#1. Concatenate Date and Time fields by paste function
#2. Convert the string got in p.1 to a convinient POSIXct date format
#3. Draw a plot with the date in new format on x axis and Global_active_power on y axis
plot(as.POSIXct(paste(consumpt_20070201$Date, consumpt_20070201$Time), "%d/%m/%Y %H:%M:%S", tz="UTC"), consumpt_20070201$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab=NA)
dev.copy(png, file = "plot2.png", width=480, height=480)  ## Copy plot to a PNG file
dev.off()  ## Close the PNG device