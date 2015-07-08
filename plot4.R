library(dplyr)
library(lubridate)

setwd("C:/Users/kilading/Documents/RLearning/Exploratory_Data_Analysis_P1")
full_data <- read.table(file = "household_power_consumption.txt", sep = ";", header =TRUE, na.strings="?")
full_data <- tbl_df(full_data)

full_data$Date <- dmy(full_data$Date)


# filter data
select_data <- filter(full_data, Date == ymd(20070201) | Date == ymd(20070202))

# create a new column Timestamp which combines Date and Time
select_data <- mutate(select_data, Timestamp = parse_date_time(paste(select_data$Date, select_data$Time), order="ymd hms"))

# plotting
par(mfrow=c(2,2))

# 1st plot
plot(select_data$Timestamp,select_data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# 2nd plot
plot(select_data$Timestamp,select_data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# 3rd plot
plot(select_data$Timestamp,select_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")

lines(select_data$Timestamp,select_data$Sub_metering_2,col="red")

lines(select_data$Timestamp,select_data$Sub_metering_3,col="blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5,  col=c("black", "red", "blue"), bty="n", cex=.5)

# 4th plot
plot(select_data$Timestamp,select_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")


#saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

#clear all objects
rm(list = setdiff(ls(), lsf.str()))