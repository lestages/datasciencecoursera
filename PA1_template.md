
## Read in activity data from local directory

```r
step_dat_raw <- read.csv("activity.csv")

##Sum up steps per day and plot in a histogram
library(dplyr)
grouped_step_dat <- group_by(step_dat_raw, date)
step_dat_days <- summarise(grouped_step_dat, steps_day=sum(steps))

hist(step_dat_days$steps_day, 
	col = "red",
	main="Histogram of Steps Taken per Day",
	xlab="Steps Taken"
	)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-1.png)

```r
## Calculate mean and median steps per day
mean(step_dat_days$steps_day, na.rm = TRUE)
```

```
## [1] 10766.19
```

```r
median(step_dat_days$steps_day, na.rm = TRUE)
```

```
## [1] 10765
```

```r
##Sum up average steps per interval and plot over time
grouped_step_dat_int <- group_by(step_dat_raw, interval)
step_dat_int <- summarise(grouped_step_dat_int, steps_int=mean(steps, na.rm = TRUE))
plot(step_dat_int$interval, step_dat_int$steps_int
	,type="l"
	,xlab="Interval"
	,ylab="Average Steps"
	,main= "Average Steps taken in 5 minute intervals")
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-2.png)

```r
## Calculate number of missing data entries 
sum(is.na(step_dat_raw$steps))
```

```
## [1] 2304
```

```r
## Find mean number of steps taken (~37) and use that to fill in missing values
step_dat_raw_nona <- step_dat_raw
mean(step_dat_raw_nona$steps, na.rm = TRUE)
```

```
## [1] 37.3826
```

```r
step_dat_raw_nona$steps[is.na(step_dat_raw_nona$steps)] <- 37

## Now with new dataset with filled in missing entries, recalculate number steps per day
library(dplyr)
grouped_step_dat <- group_by(step_dat_raw_nona, date)
step_dat_raw_nona_days <- summarise(grouped_step_dat, steps_day=sum(steps))

hist(step_dat_raw_nona_days$steps_day, 
	col = "red",
	main="Histogram of Steps Taken per Day",
	xlab="Steps Taken"
	)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-3.png)

```r
## and recalculate the mean and median number to compare to original dataset
mean(step_dat_raw_nona_days$steps_day, na.rm = TRUE)
```

```
## [1] 10751.74
```

```r
median(step_dat_raw_nona_days$steps_day, na.rm = TRUE)
```

```
## [1] 10656
```

```r
## Find what days are weekdays and weekends
step_dat_raw_nona$day <- weekdays(as.Date(step_dat_raw_nona$date))
weekdays1 <- c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
weekends1 <- c('Saturday', 'Sunday')

step_dat_raw_nona$wewd[step_dat_raw_nona$day %in% weekdays1] <- 'Weekday'
step_dat_raw_nona$wewd[step_dat_raw_nona$day %in% weekends1] <- 'Weekend'
library(dplyr)

## Sum up steps by interval and weekday vs weekend and plot in two panel line chart
grouped_step_wewd <- group_by(step_dat_raw_nona, interval, wewd)
step_dat_wewd <- summarise(grouped_step_wewd, steps_day=sum(steps))
library(ggplot2)
qplot(interval, steps_day, data=step_dat_wewd )+facet_wrap(~wewd, nrow=2)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-4.png)
