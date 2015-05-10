library(data.table)
library(lubridate)
## Read the file from the current working directory.
dt <- fread("household_power_consumption.txt",na.strings = c("?"))

## Subset to get the dates we care about
newDT <- dt[dt$Date %in% c("1/2/2007","2/2/2007"),]

## Add DateTime column and convert individual date/time strings.
newDT$DateTime <- dmy_hms(paste(newDT$Date,newDT$Time), tz="CST")

## Convert the following to numeric before plotting
newDT$Global_active_power<-as.numeric(newDT$Global_active_power)
newDT$Global_reactive_power<-as.numeric(newDT$Global_reactive_power)
newDT$Voltage<-as.numeric(newDT$Voltage)
newDT$Sub_metering_1<-as.numeric(newDT$Sub_metering_1)
newDT$Sub_metering_2<-as.numeric(newDT$Sub_metering_2)
newDT$Sub_metering_3<-as.numeric(newDT$Sub_metering_3)

## Create plot

with(newDT, plot(newDT$DateTime, newDT$Sub_metering_1, ylab="Energy sub metering",xlab="",type="n"))
points(newDT$DateTime, newDT$Sub_metering_1, type="l")
points(newDT$DateTime, newDT$Sub_metering_2, type="l",col="red")
points(newDT$DateTime, newDT$Sub_metering_3, type="l",col="blue")
legend("topright",lwd=1, lty=1, cex=.7 ,col=c("black","red","blue"),legend=c("Sub_metering_1    ","Sub_metering_2     ","Sub_metering_3      "))

dev.copy(png,file="plot3.png")
dev.off()




