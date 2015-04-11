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

sub2<- as.numeric(as.character(Sub_metering_2)) # Prepare Data
sub1<- as.numeric(as.character(Sub_metering_1)) # Prepare Data
sub3<- as.numeric(as.character(Sub_metering_3)) # Prepare Data

png(filename = "plot3.png",
    width = 480, height = 480, units = "px",
    pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png")) #printing data in right size
plot(DateTime, sub1, type="n", ylim =c(-1,38), xlab ="", ylab = "Energy sub metering") # create empty plot
lines(DateTime, sub1 , type="l", col="black") #add lines
lines(DateTime, sub2, type="l", col="red")
lines(DateTime, sub3, type="l", col="blue")
legend("topright", expression(Sub_metering_1, Sub_metering_2,Sub_metering_3), 
       lty=1, col=c("black", "red", "blue")) ##add legend
dev.off() ##close the PNG device
