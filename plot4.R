datalocation <- "C:\\Users\\Karl\\Box Sync\\R lernen\\Eigener Code\\Exploratory Data\\exdata-data-household_power_consumption\\household_power_consumption.txt"
dataset <- read.table(file = datalocation, header = TRUE, sep = ";")

attach(dataset)#some data prep
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")
relevant <- subset(x = dataset,subset = Date >= "2007-02-01"& Date <= "2007-02-02")   ##select 2007-02-01 and 2007-02-02
DateTime <- as.character(paste(relevant$Date, relevant$Time, sep=", "))
DateTime <- strptime(DateTime, format="%Y-%m-%d,  %H:%M:%S")
Sys.setlocale("LC_TIME", "English")
detach(dataset)

attach(relevant)

##plot 1 data
Global_active_power1 <- as.character(relevant$Global_active_power)
Global_active_power1 <- as.numeric(Global_active_power1)

##plot 3 data
sub2<- as.numeric(as.character(Sub_metering_2)) # Prepare Data
sub1<- as.numeric(as.character(Sub_metering_1)) # Prepare Data
sub3<- as.numeric(as.character(Sub_metering_3)) # Prepare Data

#plot 4 data
Voltage1<- as.numeric(as.character(Voltage))
grp <- as.numeric(as.character(Global_reactive_power))


png(filename = "plot4.png",
    width = 480, height = 480, units = "px",
    pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png")) #create the plot as png

par(mfrow = c(2,2)) #4x4 matrix
  plot(DateTime, Global_active_power1, type="l",ylab="Global Active Power", xlab="") #plot 1
  plot(DateTime, Voltage1, type="l", xlab = "datetime", ylab = "Voltage") #plot 2
  plot(DateTime, sub1, type="n", ylim =c(-1,38), xlab ="", ylab = "Energy sub metering" )#plot 3
    lines(DateTime, sub1 , type="l", col="black")#plot 3
    lines(DateTime, sub2, type="l", col="red")#plot 3
    lines(DateTime, sub3, type="l", col="blue")#plot 3
    legend("topright", expression(Sub_metering_1, Sub_metering_2,Sub_metering_3), 
           lty=1, col=c("black", "red", "blue"), bty="n",cex=.6)#plot 3
  plot(DateTime, grp, type="n",
      xlab = "datetime", ylab = "Global_reactive_power")
    lines(DateTime, grp, lwd = 1, type = "l")#create 4th plot
dev.off() ##close the PNG device!

par(mfrow = c(1,1)) #set back to standard one matrix