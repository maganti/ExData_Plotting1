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
#initiating a new png graphical device with width and height set to 480 pixels and directly
#writing the plot to the png device
png(filename="plot3.png", width=480, height=480, units="px")
#using the base plot function to create the plot and then annotating using the  points
#function to add the other two sub_metering plots, along with a legend
#at the top right corner, with the appropriate colors and indicators
with(febdata, {
        plot(datetime, Sub_metering_1, xlab="", 
                ylab="Energy sub metering", col="black",type="l")
        points(datetime, Sub_metering_2, xlab="", 
                ylab="Energy sub metering", col="red",type="s")
        points(datetime, Sub_metering_3, xlab="", 
                ylab="Energy sub metering", col="blue",type="s")
        legend("topright", col=c("black", "red", "blue"),
                legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
                lwd=1,pch=NA)
})
dev.off()
