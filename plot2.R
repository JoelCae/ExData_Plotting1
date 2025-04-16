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
data_power <- data_power %>% filter(Date >= "2007-02-01 00:00:00" & Date <= "2007-02-03 00:00:00" )

# manage class of variables           
data_power[,3:6] <-  lapply(data_power[,3:6], as.numeric)
data_power[,7:9] <- lapply(data_power[,7:9], as.integer)

date_label <- filter(data_power, Time == "00:00:00")

##### PLOT 2 #####
Sys.setlocale("LC_TIME", "C") # chage local languague
plot(data_power$Date, data_power$Global_active_power, type = "line", xlab = "", ylab = "Global Active Power (kilowatts)" , xaxt = "n")
axis(1, at = date_label$Date, labels = substr(weekdays(date_label$Date),1,3))

dev.copy(png, filename = "plot2.png", width = 480, height = 480, res = 72)
dev.off()