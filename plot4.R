#Course: Exploratory Data Analysis (Coursera / John Hopkins)
#Course Project #1 - PLOT #4
#--------------------------------------------------------------
#
#Set working directory to the location that contains the file needing to be read and where to store the outcome.
#
#Instructions said the plots were only using data from dates 2007-02-01 and 2007-02-02
#By looking at the file in a text editor first (that has line numbering), looked for data that read 01/02/2007 and
#02/02/2007, as the dates were in the format of dd/mm/yyyy.
#The needed data starts on line 66638 and ends on line 69517, which is a total of 2880 rows.

#Read data, extracting only the rows needed.
DataSet <- read.table("household_power_consumption.txt", sep = ";",skip=66637, nrows = 2880, stringsAsFactors = FALSE)

#read the dataset again, this time just getting the first line, which is the column headers.
HeaderInfo <- read.table("household_power_consumption.txt", sep = ";", nrows = 1, stringsAsFactors = FALSE)

#modify the header information so it can be brought into the dataset as column headers
HeaderInfo2 <- as.data.frame(t(HeaderInfo), row.names = NULL)

#rename the column headers in the dataset
colnames(DataSet) <- HeaderInfo2[,1]

#create a new column that combines date and time, and changes the data type to be a date/time format
DataSet$DateTime <- strptime(paste(DataSet$Date,DataSet$Time), "%d/%m/%Y %H:%M:%S")

#remove unneeded objects
rm(HeaderInfo, HeaderInfo2)

#This code has that the graphs will be plotted to the wanted output format (e.g. png file), 
#and will not appear on the screen. This is being done because the legend in the thrid graph truncates 
#when outputting the file after it has been 'printed' on-screen

#set the file name for the plot output.
#the default of png graphs is 480 x 480 pixels
png('plot4.png')

#create a multi-panel layout for four plots
par(mfrow = c(2,2))

#modify margins to veiw all axis and labels, but also reduce white spcae
par(mar=c(4.1,4.1,1.1,1.1))

#create the each plot, which will be placed in the multi-panel layout
with(DataSet, {
          plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l", lwd = 1 )
          plot(DateTime, Voltage, type = "l", lwd = 1)
          {plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
               with(subset(DataSet), points(DateTime, Sub_metering_1, type = "l"))
               with(subset(DataSet), points(DateTime, Sub_metering_2, type = "l", col = "red"))
               with(subset(DataSet), points(DateTime, Sub_metering_3, type = "l", col = "blue"))
               legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n",
               col = c("black", "red", "blue"), lty = 1, lwd = 1)}
          plot(DateTime, Global_reactive_power, type = "l", lwd = 1)     
          })

#finsih saving the plots to the output by using the dev.off command
dev.off()

#clear global environment
rm(DataSet)