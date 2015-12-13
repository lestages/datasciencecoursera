## Scatter plots of all three submetering measurements over time
## 
## PLOT3..........................................................

raw_data_sql3 <- read.csv.sql("household_power_consumption.txt", 
	sql = "select * from file WHERE Date in ('1/2/2007', '2/2/2007') ", 
	header = TRUE, sep = ";")
raw_data_sql3_nona<-raw_data_sql3[!(raw_data_sql3$Time=="?" & raw_data_sql3$Global_active_power=="?"),]
raw_data_sql3_nona$new_time <- strptime(raw_data_sql3_nona$Time, "%R")
raw_data_sql3_nona$new_day <- strptime(raw_data_sql3_nona$Date, "%u")

plot(raw_data_sql3_nona$new_time, raw_data_sql3_nona$Sub_metering_1,
	ylab = "Energy Sub Metering", xlab = "" )
points(raw_data_sql3_nona$new_time, raw_data_sql3_nona$Sub_metering_2, col="red")
points(raw_data_sql3_nona$new_time, raw_data_sql3_nona$Sub_metering_3, col="blue")
legend("topright", pch = 1, col = c("black", "red", "blue"), 
	legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3" ))

dev.copy(png, file = "plot3.png")  ## Copy my plot to a PNG file
dev.off()