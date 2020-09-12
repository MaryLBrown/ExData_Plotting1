## Exploratory Data Analysis - Programming Assignment 1
## This script creates Plot 1 of the assignment

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
## Create plot 1 
png("plot1.png", width = 480, height = 480)
with(cons, hist(Global_active_power, main = "Global Active Power", 
                col = "red", xlab = "Global Active Power (kilowatts)"))
dev.off()
