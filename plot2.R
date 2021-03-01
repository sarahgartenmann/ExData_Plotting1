# Exploratory Data Analysis
# Course Project, Week 1
# Coursera
# Sarah Gartenmann
# February 2021

################################################################################
# Setting working directory and creating a new directory for the files
setwd("C:/Users/gartens1/Downloads")
  if (!file.exists("./coursera_exploratorydataanalysis_courseproject1")) {
    dir.create("./coursera_exploratorydataanalysis_courseproject1")
  }

# downloading the file 
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,
              destfile = "./coursera_exploratorydataanalysis_courseproject1/dataset.zip")

# Unuipping the zip file
unzip(zipfile = "./coursera_exploratorydataanalysis_courseproject1/dataset.zip", 
      exdir = "./coursera_exploratorydataanalysis_courseproject1")

# reading in dataset 
data <- read.table("./coursera_exploratorydataanalysis_courseproject1/household_power_consumption.txt", 
                   header = TRUE, sep = ";") 

# subsetting the data to only show data from 2007-02-01 and 2007-02-02 
# ("1/2/2007" and "2/2/2007", respectively)
names(data) 
datasub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
names(datasub) 

################################################################################
# Plot 2

# change "Global_active_power" from factor to numeric 
# (2880obs, 9 variables)
# datasub[,3] <- sapply(datasub[,3], as.numeric)

# create a date-time column with strptime() from Date and Time columns in datasub
# (POSIXlt[1:2880])
datetime <- strptime(paste(datasub[,1], datasub[,2], sep=" "), "%d/%m/%Y %H:%M:%S") 

# cbind "datetime" and "datsub" together to create a new dataframe
# (2880obs, 10 variables)
datasub2 <- as.data.frame(cbind(datetime, datasub))

# remove uncessary columns from datasub2 
# (2880obs, 2 variables)
datasub2 <- datasub2[,-c(2,3,5:10)]

# creating and saving the plot as a PNG file
png(file = "./coursera_exploratorydataanalysis_courseproject1/plot2.png",
    width = 480, height = 480)

# plot graph
with(datasub2, 
     plot(datetime, as.numeric(as.character(Global_active_power)), 
          type = "l", 
          xlab = "Day", 
          ylab = "Global Active Power (kilowatts)"))

# dev.off() to create the file
dev.off()
