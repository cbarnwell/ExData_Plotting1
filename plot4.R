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

## Create plots 
par(mfrow = c(2,2))

plot(newDT$DateTime,newDT$Global_active_power,ylab="Global Active Power", xlab="", type="l")

plot(newDT$DateTime,newDT$Voltage,ylab="Voltage", xlab="datetime", type="l")

with(newDT, plot(newDT$DateTime, newDT$Sub_metering_1, ylab="Energy sub metering",xlab="",type="n"))
points(newDT$DateTime, newDT$Sub_metering_1, type="l")
points(newDT$DateTime, newDT$Sub_metering_2, type="l",col="red")
points(newDT$DateTime, newDT$Sub_metering_3, type="l",col="blue")
legend("topright",lwd=1, lty=1, bty="n", cex=.7 ,col=c("black","red","blue"),legend=c("Sub_metering_1   ","Sub_metering_2    ","Sub_metering_3     "))

plot(newDT$DateTime,newDT$Global_reactive_power,ylab="Global_reactive_power", xlab="datetime", type="l")


dev.copy(png,file="plot4.png")
dev.off()




