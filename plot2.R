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
plot(select_data$Timestamp, select_data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

#clear all objects
rm(list = setdiff(ls(), lsf.str()))
