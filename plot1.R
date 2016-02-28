###########################################################################################
# Code to import household power consumption and create plot1, as defined in assignment 1 of
# the exploratory analysis course in Coursera.
###########################################################################################

library(dplyr) # Package for easy dataset manipulation
library(lubridate) # Package for easy date/time conversion

# Move to the folder containing the txt file (path = ""), alternatively specify path.
path <- "~/Desktop/Coursera DS 2/"
household_power_consumption <- read.csv(paste0(path,"household_power_consumption.txt"), 
                                        sep=";", stringsAsFactors=FALSE)

# Convert variables for plot 1 into the right format
household_power_consumption$Date <- dmy(household_power_consumption$Date)
household_power_consumption$Global_active_power <- as.numeric(household_power_consumption$Global_active_power)

# Select the necessary variables for plot 1, in the time range from
df_selection <- household_power_consumption %>%
                select(Date, Global_active_power) %>%
                filter(Date >= "2007-02-01" & Date <= "2007-02-02")

# Create plot on screen to check correctness
hist(df_selection$Global_active_power, 
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

# Save plot on png file
png(filename = "plot1.png")
hist(df_selection$Global_active_power, 
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()








        
        

        