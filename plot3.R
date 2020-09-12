## Exploratory Data Analysis - Programming Assignment 1
## This script creates Plot 3 of the assignment

## ---------------------------------------------------------------------------
## Set up needed libraries
library(readr)
library(lubridate)
library(dplyr)

## ---------------------------------------------------------------------------
## Get the data file if it doesn't already exist
dataFile <- "exdata_data_household_power_consumption.zip"
dataFileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists(dataFile)) {
        download.file(dataFileURL, dataFile)
}

## ---------------------------------------------------------------------------
## read in the data file: format date column, filter for dates of interest and
## create a date-time column
cons <- read_delim(dataFile,  delim = ";", col_names = TRUE, 
                   col_types = NULL, na = "?") %>%
        mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
        filter(Date > as.Date("2007-01-31") & Date < as.Date("2007-02-03")) %>%
        mutate(DateTime = as.POSIXct(paste(Date, Time),
                                     format="%Y-%m-%d %H:%M:%S"))

## ---------------------------------------------------------------------------
## Create plot 3
png("plot3.png", width = 480, height = 480)
plot(cons$Sub_metering_1 ~ cons$DateTime, 
     type = "l",
     main = "", ylab = "Energy Sub Metering", xlab = "")
lines(cons$Sub_metering_2 ~ cons$DateTime, col = "red")
lines(cons$Sub_metering_3 ~ cons$DateTime, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_Metering_1"
                  , "Sub_Metering_2", "Sub_Metering_3"))
dev.off()

