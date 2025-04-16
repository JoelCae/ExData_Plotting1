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
data_power <- data_power %>% filter(Date >= "2007-02-01 00:00:00" & Date <= "2007-02-03 00:00:00")

# manage class of variables           
data_power[,3:6] <-  lapply(data_power[,3:6], as.numeric)
data_power[,7:9] <- lapply(data_power[,7:9], as.integer)

date_label <- filter(data_power, Time == "00:00:00")

##### PLOT 3 #####
plot(data_power$Date, data_power$Sub_metering_1, type = "line", xlab = "", ylab = "Energy sub metering", xaxt = "n") 
lines(data_power$Date, data_power$Sub_metering_2, col = "red")
lines(data_power$Date, data_power$Sub_metering_3, col = "blue")
legend("topright", legend = c(paste("Sub_metering", 1:3, sep = "_")), 
       col = c("black", "red", "blue"), lty = 1,cex = 0.95)
axis(1, at = date_label$Date, labels = substr(weekdays(date_label$Date),1,3))

dev.copy(png, filename = "plot3.png", width = 480, height = 480, res = 72)
dev.off()
