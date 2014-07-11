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
#not performing any date/time conversions, since not required for this plot. This is
#done subsequently for all the other plots
febdata<-hhdata[(hhdata$Date == "1/2/2007" | hhdata$Date == "2/2/2007"),]
#using the base hist function to create the histogram
hist(febdata$Global_active_power, col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
#copying the plot to a png file, setting the width and height to 490 pixels
#each and the units as pixels
dev.copy(png, file="plot1.png", width=480, height=480, units="px", color="red")
dev.off()
