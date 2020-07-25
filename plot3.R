#Coursera Exploratory Data Analysis
#Course Project 1

#Plot3
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
head(subdatahouseholdpower)

#Convert time and date to Posixlt and time
subdatahouseholdpower$Time <- strptime(subdatahouseholdpower$Time, format = "%H:%M:%S")
subdatahouseholdpower$Date <- as.Date(subdatahouseholdpower$Date, format = "%d/%m/%Y")
#fix date
grep("2007-02-02",subdatahouseholdpower$Date)
sum(grepl("2007-02-02",subdatahouseholdpower$Date))

subdatahouseholdpower[1:1440,"Time"] <- format(subdatahouseholdpower[1:1440,"Time"], "2007-02-01 %H:%M:%S")
subdatahouseholdpower[1441:2880,"Time"] <- format(subdatahouseholdpower[1441:2880,"Time"], "2007-02-02 %H:%M:%S")

#Plot3
#EnergySubmetering
y1 <- as.numeric(as.character(subdatahouseholdpower$Sub_metering_1))
y2 <- as.numeric(as.character(subdatahouseholdpower$Sub_metering_2))
y3 <- as.numeric(as.character(subdatahouseholdpower$Sub_metering_3))

png(filename = "plot3.png", width = 480, height = 480)
plot(subdatahouseholdpower$Time, y1, type = "l", xlab ="", ylab = "Energy Sub metering")
points(subdatahouseholdpower$Time, y2, type = "l", col = "red")
points(subdatahouseholdpower$Time, y3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col = c("black","red", "blue"), lty = 1 )
dev.off()