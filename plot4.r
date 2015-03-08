## Coursera Exploratory Data Analysis
## Course Project #1
## Plot 4

## Create a variable that contains the URL for the assignment files
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Download the files needed for the assignment
checkfile<- file.exists("household_power_consumption.txt") 
if (checkfile == FALSE) {
  checkzip<- file.exists("Electric_Power_Consumption.zip")
  if (checkzip == FALSE) {
    download.file(url, destfile= "Electric_Power_Consumption.zip")
  }
  ##Unzip the files
  zfile<- "Electric_Power_Consumption.zip" 
  unzip (zfile)
}
dfile<- "household_power_consumption.txt"

## "preread" the data, in order to make loading the whole data a lot faster
firstrows<- read.table(dfile, header= TRUE, nrows= 100, sep = ";")
classes <- sapply(firstrows, class)
x<-"?"
## Read the data
## first check if the variable already exists
kierkegaard<- exists("pwr_consump")
if (kierkegaard == FALSE){
  pwr_consump<- read.table(dfile, header = TRUE, sep = ";", na.strings = x , nrows =  2075259, colClasses = classes)
}
pwr_consump$Date <- as.Date(pwr_consump$Date, "%d/%m/%Y")
pwr_consump_clean<- subset(pwr_consump, Date == as.Date ("2007-02-01")|Date== as.Date("2007-02-02") )

##Create a variable containing the date-time values combined
pwr_consump_datetime <- paste(pwr_consump_clean$Date, pwr_consump_clean$Time)
pwr_consump_datetime<- strptime(pwr_consump_datetime, "%Y-%m-%d %H:%M:%S" )

## Plot and create a png file named "Plot2.png, meassures: 480 x 480 pixels"

png("plot4.png", width =480, height=480, units= "px")
par(mfrow = c(2,2))

plot(pwr_consump_datetime,pwr_consump_clean$Global_active_power,xlab="", ylab="Global Active Power", "l")

plot(pwr_consump_datetime, pwr_consump_clean$Voltage, ylab= "Voltage", xlab="datetime", "l")

plot(pwr_consump_datetime, pwr_consump_clean$Sub_metering_1, "l", xlab="", ylab="Energy sub metering")
lines(pwr_consump_datetime,pwr_consump_clean$Sub_metering_2, "l", col="red")
lines(pwr_consump_datetime,pwr_consump_clean$Sub_metering_3, "l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),bty="n", lty=1, lwd=2.0, col=c("black", "red", "blue"))

plot(pwr_consump_datetime, pwr_consump_clean$Global_reactive_power, ylab= "Global_reactive_power", xlab="datetime", "l")

dev.off()
## the created file will be moved to the folder"myfigures" which would be created in the current folder
a<-file.exists("myfigures")
if (a == FALSE) {
  dir.create("myfigures")
}
b<- getwd()
b2<- paste(b,"/plot4.png", sep="")
b3<- paste(b,"/myfigures/plot4.png", sep="")
file.rename(b2,b3)
