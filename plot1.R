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

#Draw the histogram. All parameters included in hist function. 
#Col parameter for color, xlab for x axis label, main for the title
hist(consumpt_20070201$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png", width=480, height=480)  ## Copy plot to a PNG file
dev.off()  ## Close the PNG device

