###########################################################################################
# Code to import household power consumption and create plot2, as defined in assignment 1 of
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
household_power_consumption$Global_active_power <- as.numeric(household_power_consumption$Global_active_power)

# Select the necessary variables for plot 1, in the time range requested for the excersise
# %>% is the piping operator imported with the library dplyr
df_selection <- household_power_consumption %>%
        select(fulldate, Global_active_power) %>%
        filter(fulldate >= "2007-02-01 00:00:00" & fulldate <= "2007-02-03 00:00:00")

# Create plot on screen to check correctness
with(df_selection, plot(x = fulldate,
                        y = Global_active_power,
                        type = "l",
                        xlab = "",
                        ylab = "Global Active Power (kilowatts)")
     )

# Save plot on png file
png(filename = "plot2.png")
with(df_selection, plot(x = fulldate,
                        y = Global_active_power,
                        type = "l",
                        xlab = "",
                        ylab = "Global Active Power (kilowatts)")
)
dev.off()











