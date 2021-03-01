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
# Plot 4

datasub4 <- datasub

# create a date-time column with strptime() from "Date" and "Time" columns in datasub
# (POSIXlt[1:2880])
datetime <- strptime(paste(datasub[,1], datasub[,2], sep=" "), "%d/%m/%Y %H:%M:%S") 

# cbind "datetime" and "datsub4" together to create a new dataframe
# (2880obs, 10 variables)
datasub5 <- as.data.frame(cbind(datetime, datasub4))

# creating and saving the plot as a PNG file
png(file = "./coursera_exploratorydataanalysis_courseproject1/plot4.png",
    width = 480, height = 480)

par(mfrow = c(2,2), mar = c(4,4,2,1), om = c(0,0,2,0))
with(datasub5, {
  # plot top left
  plot(datetime, Global_active_power, 
      type = "l", 
      xlab = "", 
      ylab = "Global Active Power (kilowatts)")
  
  # plot top right 
  plot(datetime, as.numeric(as.character(Voltage)), 
       type = "l", 
       xlab = "datetime", 
       ylab = "Voltage")
  
    # plot bottom left
  plot(datetime, Sub_metering_1, 
      type = "l",
      xlab = "", 
      ylab = "Energy sub metering")
    # Add line for Sub_metering_2
    lines(datasub5$datetime, as.numeric(as.character(datasub3$Sub_metering_2)),
        type = "l",
        col = "red")
    # Add line for Sub_metering_2
    lines(datasub5$datetime, datasub3$Sub_metering_3,
        type = "l",
        col = "blue")
    # Add legend
    legend(c("topright"), 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lty=1, 
         bty = "n",
         col = c("black", "red", "blue"))
  
  # plot bottom right
  plot(datetime, as.numeric(as.character(Global_reactive_power)),
       type = "l",
       xlab = "datetime", 
       ylab = "Global_reactive_power")
})

# dev.off() to create the plot
dev.off()