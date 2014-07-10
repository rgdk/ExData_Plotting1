#Plot4

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
par(mfrow=c(2,2),  mar=c(4.1,4.1,3.1,1.0), cex.lab=0.8, cex.axis=0.75, family="sans")
with(hpc_subset, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(hpc_subset, plot(datetime, Voltage, type="l", ylab="Voltage"))
with(hpc_subset, {
  plot(datetime, Sub_metering_1, col="black", type="l", ylim=c(0, 38), xlab="", ylab="Energy sub metering")
  lines(datetime, Sub_metering_2, col="red", type="l")
  lines(datetime, Sub_metering_3, col="blue", type="l")
  legend("topright",bty="n", bg="transparent",cex=0.7, inset=c(0.15,0.05), lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
})
with(hpc_subset, plot(datetime, Global_reactive_power, type="l", fin=c(2.40,2.40)), las=)
dev.copy(png, file="plot4.png", h=480, w=480)
dev.off()