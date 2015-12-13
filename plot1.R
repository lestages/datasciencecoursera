### Histogram in red of the Global Active Power over dates Feb 1, 2007 - Feb 2, 2007
## Title and Xaxis label given as well

raw_data_sql <- read.csv.sql("household_power_consumption.txt", 
	sql = "select * from file WHERE Date in ('1/2/2007', '2/2/2007') ", 
	header = TRUE, sep = ";")
global_active_power_df <- data.frame()
global_active_power_df <- (raw_data_sql['Global_active_power'])
hist(global_active_power_df$Global_active_power, 
	col = "red",
	main="Global Active Power",
	xlab="Global Active Power (kilowatts)"
	)


dev.copy(png, file = "plot1.png")  ## Copy my plot to a PNG file
dev.off()  
