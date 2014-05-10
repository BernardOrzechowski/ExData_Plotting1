## load the data
data <- read.table(file = "household_power_consumption.txt", 
                   colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                   header = TRUE,
                   sep = ";",
                   row.names = NULL,
                   na.strings = "?"
) 

## Convert date and time values to Date/Time in R and 
## subset the data set to 2007-02-01 and 2007-02-02

#convert
dateAndTime <- paste(data[,"Date"], data[,"Time"])
data$dateAndTime <- strptime(dateAndTime, "%d/%m/%Y %H:%M:%S")

#subset the 2 days
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007", select=Date:dateAndTime)


# german environemnt -> localize the messages to en (Thursday instead of Donnerstag)
Sys.setlocale("LC_ALL", "English")


## Create the plot directly in png file.
#  default size is 480 pixels x 480 pixels hence no additional arguments
png(filename="plot4.png")

#set the number of plots to be draw
par(mfrow = c(2,2))

#first (top left) plot
with (data, 
      plot( dateAndTime, 
            Global_active_power, 
            type="l", 
            ylab = "Global Active  Power",
            xlab = "",
            cex.lab = 0.9,
            cex.axis=0.9
      )
)
#second (top right) plot
with (data, 
      plot( dateAndTime, 
            Voltage, 
            type="l", 
            ylab = "Voltage",
            xlab = "datetime",
            cex.lab = 0.9,
            cex.axis=0.9
      )
)

#third (bottom left) plot
plot( range(data$dateAndTime),
      range(append(data$Sub_metering_1,append(data$Sub_metering_2,data$Sub_metering_3))) ,
      ylab = "Energy sub metering",
      xlab = "",
      cex.lab = 0.75,
      cex.axis=0.8,
      type = "n"
)

#Sub_metering_1
with (data, 
      lines( dateAndTime, 
             Sub_metering_1, 
             type="l", 
             col = "black"
      )
)
#Sub_metering_2
with (data, 
      lines( dateAndTime, 
             Sub_metering_2, 
             type="l", 
             col = "orangered"
      )
)

#Sub_metering_3
with (data, 
      lines( dateAndTime, 
             Sub_metering_3, 
             type="l", 
             col = "blue"
      )
)

#add the legend informaiton
legend("topright", 
       col = c("black","orangered","blue"), 
       lty = 1,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       cex=0.8
)

#fourth (bottom right) plot
with (data, 
      plot( dateAndTime, 
            Global_reactive_power, 
            type="l", 
            ylab = "Global_reactive_power",
            xlab = "datetime",
            cex.lab = 0.9,
            cex.axis=0.9
      )
)

#save the file
dev.off() 