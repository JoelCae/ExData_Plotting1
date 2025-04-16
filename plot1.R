##### LIBRARIES ##### 
library(dplyr)

##### GENERAL ##### 
remove(list = ls())

##### DATA ##### 
# read data
data_power <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# manage dates 
data_power$Date <- as.POSIXct(paste(data_power$Date, data_power$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

# filter by date
data_power <- data_power %>% filter(Date >= "2007-02-01 00:00:00" & Date <= "2007-02-02 23:59:59" )

# manage class of variables           
data_power[,3:6] <-  lapply(data_power[,3:6], as.numeric)
data_power[,7:9] <- lapply(data_power[,7:9], as.integer)

##### PLOT 1 #####
hist(data_power$Global_active_power, freq = TRUE, col = "red" , main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.copy(png, filename = "plot1.png", width = 480, height = 480, res = 72)
dev.off()
