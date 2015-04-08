#Course: Exploratory Data Analysis (Coursera / John Hopkins)
#Course Project #1 - PLOT #1
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

#This code has that the histogram will be plotted to the screen first, then saved to the wanted output format (e.g. png file)

#Just in case, set the layout to be for one plot only
par(mfrow = c(1,1))

#modify margins so that the left side text isn't squished to the edge and remove some of the extra space on the right side
par(mar=c(5.1,5.1,4.1,2.1))

#create the histogram (on-screen)
with(data, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "blue"))

#copy the on-screen plot and give it a file name for saving
#the default of png graphs is 480 x 480 pixels
dev.copy(png,'plot1.png')

#finsih saving the plots to the output by using the dev.off command
dev.off()

#clear the on-screen plot, and clear global environment
dev.off()
rm(DataSet)
