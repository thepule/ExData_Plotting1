###########################################################################################
# Code to import household power consumption and create plot4, as defined in assignment 1 of
# the exploratory analysis course in Coursera.
###########################################################################################

library(dplyr) # Package for easy dataset manipulation
library(lubridate) # Package for easy date/time conversion

# Move to the folder containing the txt file (path = ""), alternatively specify path.
path <- "~/Desktop/Coursera DS 2/"
household_power_consumption <- read.csv(paste0(path,"household_power_consumption.txt"), 
                                        sep=";", stringsAsFactors=FALSE)

# Create unified date field and conversion to date type in one command
# %>% is the piping operator imported with the library dplyr
household_power_consumption$fulldate <- paste(household_power_consumption$Date,
                                              household_power_consumption$Time) %>% 
                                              dmy_hms()
# Select only the time iterval needed. In this case the selection
# is done before type convertion in order to speed up the latter
df_selection <- household_power_consumption %>%
           select(-c(Date, Time, Global_intensity)) %>% #Remove unnecessary columns                
           filter(fulldate >= "2007-02-01 00:00:00" & fulldate <= "2007-02-03 00:00:00")

# Batch convertion of the selection
## Create a data frame with the converted variables (everything but fulldate)
## The conversion generates warnings because some of the variables contain "?" which 
## indicates missing values. Wrapping the function in suppressWarnings() suppress the 
## warnings. It's done more for aesthetic reasons in this case and can be skipped. 
num_variables <- suppressWarnings(
                        as.data.frame(sapply(df_selection[,1:6], as.numeric), stringsAsFactors = F)
                        )
## Create final dataframe binding num variables and fulldate
df_final <- cbind(fulldate = df_selection$fulldate, num_variables)

# Create the final plot

## Open device
png(filename = "plot4.png")
## Set layout of the plot
par(mfrow = c(2,2))

attach(df_final) #Attaching dataframe to keep notation compact
## Plot 1
plot(x = fulldate,
     y = Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

## Plot 2
plot(x = fulldate,
     y = Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

## Plot 3
plot(x = fulldate,
     y = Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(fulldate, Sub_metering_2, col = "red")
lines(fulldate, Sub_metering_3, col = "blue")
legend(x = "topright", legend = names(df_final)[5:7],
       lty = c(1,1,1), col = c("black", "red", "blue"),
       bty = "n")

## Plot 4
plot(x = fulldate,
     y = Global_reactive_power,
     type = "l",
     xlab = "datetime"
     )

detach(df_final)

## Close device
dev.off() 
