#### Install packages I want to use
install.packages("dplyr")
library(dplyr)

#### Download data set and load it up
download.file(
              url="https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip",
              destfile="movementdata.zip"
              )

unzip(zipfile="movementdata.zip")

data <- read.csv(file="activity.csv")


#### Make histogram of total number of steps taken each day
## group data by date and sum number of steps
# remove NA rows for days with no data
dailysteps <- data %>%
  group_by(date) %>%
  summarize(total_steps=sum(steps)) %>%
  filter(!is.na(total_steps))

hist(dailysteps$total_steps, 
     main="Steps walked daily in October-November 2012",
     xlab="Number of Steps",
     col="lightblue")


#### Mean and median steps taken each day
# mean
mean(dailysteps$total_steps)
meanDailySteps <- mean(dailysteps$total_steps)

# median
median(dailysteps$total_steps)
medianDailySteps <- median(dailysteps$total_steps)


#### Time series plot of number/steps taken
dailysteps$date <- as.Date(dailysteps$date, format = "%Y-%m-%d")

plot(dailysteps$date, dailysteps$total_steps, 
     type="l", 
     col="darkblue", 
     lwd=3,
     main="Daily steps taken in October-November 2012",
     xlab="Date",
     ylab="Total number of steps")
grid()

# turn total_steps to numeric
dailysteps$total_steps <- as.numeric(dailysteps$total_steps)

# 5-day rolling average
fiveDay <- rep(1/5, 5)
### we need the base stats filter func here
fiveDayAve <- stats::filter(dailysteps$total_steps, fiveDay, sides=2)

lines(dailysteps$date, fiveDayAve, col="red", lwd=3)


#### 5 min interval that on average contains max number of steps













