# Assumptions are that the hhpowerconsumption zipfile has been copied into the working directory
# in R and the household_power_consumption.txt file extracted and copied into it.

#reading in only the desired subset of data from the file, by looking for the pattern matching
# 1/2/2007 or 2/2/2007, using grep, within a pipe call, the output of which is being sent to
#read.table. na.strings is set to ? to replace all ? to NAs, stringsAsFactors is set to F to 
#not convert columns variable classes to factors.
#The second read.table call reads only the first line of the text file and sets the names of the 
#columns in the dataset just created to the columns names in the header read in

febdata <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),
                header=F, sep=';', na.strings="?",stringsAsFactors=F)
colnames(febdata) <-names(read.table('household_power_consumption.txt', 
                header=TRUE,sep=";",nrows=1))

#creating one combined Data and Time variable by pasting both the Date and Time variables 
d<-paste(febdata$Date,febdata$Time)

#now converting the combined character vector into a Date class with the appropriate format
datetime<-strptime(d, "%d/%m/%Y %H:%M:%S")

#initiating a new png graphical device with width and height set to 480 pixels and directly
#writing the plot to the png device
png(filename="plot4.png", width=480, height=480, units="px")

#setting the options in par for drawing the plots in 2X2 format, with 2 rows and 2 columns
# and the margin adjustments for proper display of the four plots
par(mfrow=c(2,2), mar=c(5,4,2,2))

#using the base plot function to create the plot and then annotating using the  points
#function to add the other plots, along with a legend at the top right corner, 
# with the appropriate colors and indicators. The border option for the legend, bty has
# been set to n to not have any box around it
with(febdata, {
        plot(datetime, Global_active_power, xlab="",
             ylab="Global Active Power", type="l")
        plot(datetime, Voltage, ylab="Voltage", col="black",type="l")
        plot(datetime, Sub_metering_1, xlab="", 
                ylab="Energy Sub Metering", col="black",type="l")
        points(datetime, Sub_metering_2, xlab="", 
                ylab="Energy Sub Metering", col="red",type="s")
        points(datetime, Sub_metering_3, xlab="", 
                ylab="Energy Sub Metering", col="blue",type="s")
        legend("topright", col=c("black", "red", "blue"),
                legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
                lwd=1,pch=NA, bty="n")
        plot(datetime, Global_reactive_power, ylab="Global_reactive_power", type="l")
})
dev.off()

