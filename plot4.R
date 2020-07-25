#Coursera Exploratory Data Analysis
#Course Project 1

#Plot4
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

#Plot4
#EnergySubmetering
y1 <- as.numeric(as.character(subdatahouseholdpower$Sub_metering_1))
y2 <- as.numeric(as.character(subdatahouseholdpower$Sub_metering_2))
y3 <- as.numeric(as.character(subdatahouseholdpower$Sub_metering_3))

#Adequate the graphics device
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

gy1 <- as.numeric(as.character(subdatahouseholdpower$Global_active_power))
plot(subdatahouseholdpower$Time, gy1, type = "l", xlab ="", ylab = "Global Active Power")

gy2 <- as.numeric(as.character(subdatahouseholdpower$Voltage))
plot(subdatahouseholdpower$Time,gy2,type = "l", xlab = "datetime", ylab = "Voltage")

plot(subdatahouseholdpower$Time, y1, type = "l", xlab ="", ylab = "Energy Sub metering")
points(subdatahouseholdpower$Time, y2, type = "l", col = "red")
points(subdatahouseholdpower$Time, y3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red", "blue"), lty = 1, lwd = 1, bty = "n", x.intersp = 0.3, y.intersp = 0.8)

gy4 <- as.numeric(as.character(subdatahouseholdpower$Global_reactive_power))
plot(subdatahouseholdpower$Time, gy4, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()