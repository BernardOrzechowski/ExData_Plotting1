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
# default size is 480 pixels x 480 pixels hence no additional arguments
png(filename="plot2.png")
#plot
with (data, 
      plot( dateAndTime, 
            Global_active_power, 
            type="l", 
            ylab = "Global Active  Power (kilowatts)",
            xlab = "",
            cex.lab = 0.9,
            cex.axis=0.9
      )
)


#save the file
dev.off() 