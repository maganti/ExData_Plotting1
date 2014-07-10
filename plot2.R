# Assumptions are that the hhpowerconsumption zipfile has been copied into the working directory
# in R and the household_power_consumption.txt file extracted and copied into it.

#Inspecting or exploring the given data file shows that the desired
# subset of data is within the first 70000 rows or lines of the file.
# Therefore just reading the first 70000 lines, setting the separator to
# a colon, setting na.strings to a ?, to omit NAs later, if necessary 
# and setting stringAsFactors to false, to prevent the classes of all 
#  variables from being converted into factor variables
hhdata<-read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                   nrows=70000, na.strings=c("?"), stringsAsFactors=F)
#subsetting the desired data via indexing all the rows for Feb.1 and Feb.2 2007
febdata<-hhdata[(hhdata$Date == "1/2/2007" | hhdata$Date == "2/2/2007"),]
#creating one combined Data and Time variable by pasting both the Date and Time variables 
d<-paste(febdata$Date,febdata$Time)
#now converting the combined character vector into a Date class with the 
# appropriate format
datetime<-strptime(d, "%d/%m/%Y %H:%M:%S")
#using the base plot function to plot the datetime and Global_active_power variables
#and then copying the plot to a png file
plot(datetime, febdata$Global_active_power, xlab="",
        ylab="Global Active Power (kilowatts)", type="l")
dev.copy(png, file="plot2.png", width=480, height=480, 
         units="px")
dev.off()
