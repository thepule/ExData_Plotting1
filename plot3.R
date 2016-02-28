###########################################################################################
# Code to import household power consumption and create plot3, as defined in assignment 1 of
# the exploratory analysis course in Coursera.
###########################################################################################

library(dplyr) # Package for easy dataset manipulation
library(lubridate) # Package for easy date/time conversion

# Move to the folder containing the txt file (path = ""), alternatively specify path.
path <- "~/Desktop/Coursera DS 2/"
household_power_consumption <- read.csv(paste0(path,"household_power_consumption.txt"), 
                                        sep=";", stringsAsFactors=FALSE)

# Convert variables for plot 1 into the right format
## Create unified variable for date and time
household_power_consumption$fulldate <- paste(household_power_consumption$Date,
                                              household_power_consumption$Time)
## Convert to date type using lubridate function dmy_hms
household_power_consumption$fulldate <- dmy_hms(household_power_consumption$fulldate)
household_power_consumption$Sub_metering_1 <- as.numeric(household_power_consumption$Sub_metering_1)
household_power_consumption$Sub_metering_2 <- as.numeric(household_power_consumption$Sub_metering_2)
household_power_consumption$Sub_metering_3 <- as.numeric(household_power_consumption$Sub_metering_3)

# Select the necessary variables for plot 1, in the time range requested for the excersise
# %>% is the piping operator imported with the library dplyr
df_selection <- household_power_consumption %>%
        select(fulldate, Sub_metering_1, Sub_metering_2, Sub_metering_3) %>%
        filter(fulldate >= "2007-02-01 00:00:00" & fulldate <= "2007-02-03 00:00:00")

# Create plot on screen to check correctness
attach(df_selection) #Attaching dataframe to keep notation compact
plot(x = fulldate,
     y = Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(fulldate, Sub_metering_2, col = "red")
lines(fulldate, Sub_metering_3, col = "blue")
legend(x = "topright", legend = names(df_selection)[2:4],
       lty = c(1,1,1), col = c("black", "red", "blue"))
detach(df_selection)

# Save plot on png file
png(filename = "plot3.png")
attach(df_selection) #Attaching dataframe to keep notation compact
plot(x = fulldate,
     y = Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(fulldate, Sub_metering_2, col = "red")
lines(fulldate, Sub_metering_3, col = "blue")
legend(x = "topright", legend = names(df_selection)[2:4],
       lty = c(1,1,1), col = c("black", "red", "blue"))
detach(df_selection)
dev.off()











