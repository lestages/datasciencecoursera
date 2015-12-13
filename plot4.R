
## Demo of multiple charts per view. Showing 2 rows and 2 columns
## of various measurements
## Again, I didn't get the date quite right and the submetering one isn't quite
## Plot 4...................................

raw_data_sql2 <- read.csv.sql("household_power_consumption.txt", 
	sql = "select * from file WHERE Date in ('1/2/2007', '2/2/2007') ", 
	header = TRUE, sep = ";")
raw_data_sql2_nona<-raw_data_sql2[!(raw_data_sql2$Time=="?" & raw_data_sql2$Global_active_power=="?"),]
raw_data_sql2_nona$new_time <- strptime(raw_data_sql2_nona$Time, "%R")
raw_data_sql2_nona$new_day <- strptime(raw_data_sql2_nona$Date, "%u")


par(mfrow = c(2, 2))
plot(raw_data_sql2_nona$new_time, raw_data_sql2_nona$Global_active_power,
	xlab = "Time", ylab = "Global Active Power")

plot(raw_data_sql2_nona$new_time, raw_data_sql2_nona$Voltage,
	xlab = "Time", ylab = "Voltage")

plot(raw_data_sql3_nona$new_time, raw_data_sql3_nona$Sub_metering_1,
	ylab = "Energy Sub Metering", xlab = "" )
points(raw_data_sql3_nona$new_time, raw_data_sql3_nona$Sub_metering_2, col="red")
points(raw_data_sql3_nona$new_time, raw_data_sql3_nona$Sub_metering_3, col="blue")
legend("topright", pch = 1, col = c("black", "red", "blue"), 
	legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3" ))

plot(raw_data_sql2_nona$new_time, raw_data_sql2_nona$Global_reactive_power,
	xlab = "Time", ylab = "Global Reactive Power")

dev.copy(png, file = "plot4.png")  ## Copy my plot to a PNG file
dev.off()