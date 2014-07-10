#Plot3

#read in the raw data from the file
hpc <- read.csv("data/household_power_consumption.txt", na.strings = c("?"), stringsAsFactors=FALSE, sep=";")

#remove the subset of data relating to the 1st and 2nd of February 2007
hpc_subset <- hpc[as.Date(hpc$Date,"%d/%m/%Y") %in% c(as.Date("1/2/2007","%d/%m/%Y"), as.Date("2/2/2007","%d/%m/%Y")),]

#convert the first column to a date format
hpc_subset$Date <- as.Date(hpc_subset[,1],format='%d/%m/%Y')

#create a joint date time column and add it to the subset
hpc_subset$datetime <- as.POSIXct(paste(hpc_subset[,1],hpc_subset[,2],format='%d/%m/%Y %H:%M:%S'))

#convert all the number-based columns to numeric variables
class(hpc_subset$Global_active_power) <- "numeric"
class(hpc_subset$Global_reactive_power) <- "numeric"
class(hpc_subset$Voltage) <- "numeric"
class(hpc_subset$Global_intensity) <- "numeric"
class(hpc_subset$Sub_metering_1) <- "numeric"
class(hpc_subset$Sub_metering_2) <- "numeric"
class(hpc_subset$Sub_metering_3) <- "numeric"

#create the graph
dev.off()
par(mfrow=c(1,1), cex=0.8)
with(hpc_subset, {
  plot(datetime, Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")
  lines(datetime, Sub_metering_2, col="red", type="l")
  lines(datetime, Sub_metering_3, col="blue", type="l")
  legend("topright",bty="y", bg="transparent", adj=0.05, inset=c(0,-0.01), lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "))
})
dev.copy(png, file="plot3.png", h=480, w=480)
dev.off()