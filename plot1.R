#Download data file from the web
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/zipped_data.zip", method = "curl")
unzip("./data/zipped_data.zip")

#Read the file into dataframe
consumpt <- read.csv("household_power_consumption.txt", sep=";", na.strings = "?", stringsAsFactors = FALSE)

#Get a subset with needed dated
consumpt_20070201 <- subset(consumpt, consumpt$Date=="1/2/2007" | consumpt$Date=="2/2/2007")

#Draw the histogram
hist(consumpt_20070201$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png", width=480, height=480)  ## Copy plot to a PNG file
dev.off()  ## Close the PNG device

