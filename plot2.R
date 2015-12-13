## Scatter plot of Global Active power from Feb 1, 2007 - Feb.2 2007
## I had some trouble getting the day and time combined
## and getting the line to connect with the package I had
## PLOT2..........................................................

raw_data_sql2 <- read.csv.sql("household_power_consumption.txt", 
	sql = "select * from file WHERE Date in ('1/2/2007', '2/2/2007') ", 
	header = TRUE, sep = ";")
raw_data_sql2_nona<-raw_data_sql2[!(raw_data_sql2$Time=="?" & raw_data_sql2$Global_active_power=="?"),]
raw_data_sql2_nona$new_time <- strptime(raw_data_sql2_nona$Time, "%R")
raw_data_sql2_nona$new_day <- as.Date(raw_data_sql2_nona$Date, "%u")

plot(raw_data_sql2_nona$new_time, raw_data_sql2_nona$Global_active_power,
	ylab= "Global Active Power (kilowatts)",
	xlab= "Time",
	lty = 1,
	pch = '*')

dev.copy(png, file = "plot2.png")  ## Copy my plot to a PNG file
dev.off()