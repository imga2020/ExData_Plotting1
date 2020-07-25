#Coursera Exploratory Data Analysis
#Course Project 1

#Plot1
#Load the dataset into R
#Download from zip file
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "DataHouseholdpower.zip"
download.file(fileUrl1, filename, method = "curl")
unzip(filename)

#Path to read files
path1 <- "C:/Users/Economics05/Documents/Coursera"

#Read the file and see the data
datahouseholdpower <- read.table(file.path(path1,"household_power_consumption.txt"), header = TRUE, sep = ";")
head(datahouseholdpower)
str(datahouseholdpower)
summary(datahouseholdpower)
names(datahouseholdpower)

#Subset the data from 2007-02-01 and 2007-02-02
subdatahouseholdpower <- subset(datahouseholdpower,datahouseholdpower$Date == "1/2/2007" | datahouseholdpower$Date == "2/2/2007")

#Plot histogram in the selected device png
png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(as.character(subdatahouseholdpower$Global_active_power)), col= "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
