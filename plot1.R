# Assumptions are that the hhpowerconsumption zipfile has been copied into the working directory
# in R and the household_power_consumption.txt file extracted and copied into it.

#reading in only the desired subset of data from the file, by looking for the pattern matching
# 1/2/2007 or 2/2/2007, using grep, within a pipe call, the output of which is being sent to
#read.table. na.strings is set to ? to replace all ? to NAs, stringsAsFactors is set to F to 
#not convert columns variable c lassesto factors
#The second read.table call reads only the first line of the text file and sets the names of the 
#columns in the dataset just created to the columns names in the header read in

febdata <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),
                      header=F, sep=';', na.strings="?",stringsAsFactors=F)
colnames(febdata) <-names(read.table('household_power_consumption.txt', 
                                     header=TRUE,sep=";",nrows=1))

#using the base hist function to create the histogram
hist(febdata$Global_active_power, col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

#copying the plot to a png file, setting the width and height to 490 pixels
#each and the units as pixels
dev.copy(png, file="plot1.png", width=480, height=480, units="px", color="red")
dev.off()
