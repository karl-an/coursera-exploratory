datalocation <- "C:\\Users\\Karl\\Box Sync\\R lernen\\Eigener Code\\Exploratory Data\\exdata-data-household_power_consumption\\household_power_consumption.txt"
dataset <- read.table(file = datalocation, header = TRUE, sep = ";")

attach(dataset) #some data prep
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")
relevant <- subset(x = dataset,subset = Date >= "2007-02-01"& Date <= "2007-02-02")   ##select 2007-02-01 and 2007-02-02
DateTime <- as.character(paste(relevant$Date, relevant$Time, sep=", "))
DateTime <- strptime(DateTime, format="%Y-%m-%d,  %H:%M:%S")
detach(dataset)

attach(relevant)

Sys.setlocale("LC_TIME", "English")

plot(DateTime, Global_active_power1, type="l",ylab="Global Active Power (kilowatts)", xlab="") #plot
dev.copy(png, file = "plot2.png", width=480, height=480) ## Copy my plot to a PNG file
dev.off() ##close the PNG device!