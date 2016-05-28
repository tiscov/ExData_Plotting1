%%The text file "household_power_consumption.txt" containing the data 
%%has been downloaded and saved in the directory ".\\data" 
%%(to be set as the working directory).

%%Preliminaries: 
%% Load necessary package(s)
library(dplyr)

%% Read the data file (first two columns (Date and Time) read as "character", 
%% the rest read as "numeric" values)
data <- read.table(file=".\\household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric"))

%% and retain only the relevant data for the project 
%% (i.e. only data corresponding to the dates "01/02/2007" and "02/02/2007")
data <- filter(data, Date=="1/2/2007" | Date=="2/2/2007")

%% Prepare the data for manipulations: change the Date class/format 
%% and set a "Datetime" variable combinig the "Date" and "Time" variables, 
%% and coerce it to object of class 'POSIXlt'.
data$Date<- as.Date(data$Date, "%d/%m/%Y")
data<- mutate(data, Datetime=paste(Date,Time,sep=" "))
data$Datetime<- strptime(data$Datetime, format="%Y-%m-%d %H:%M:%S")


%% Making the 4 line charts (plot4 of assignement)

png(filename="plot4.png", width=480, height=480, units="px")

par(mfrow=c(2,2))


%%Draw the first plot (topleft), which coincide with plot2 of the assignement 
%%(see details of the code in "plot2.R")

plot(x=data$Datetime, y=data$Global_active_power, type="l", xlab="", ylab="Globa Active Power (kilowatts)")

%%Draw the second plot (topright)

plot(x=data$Datetime, y=data$Voltage, xlab="datetime", ylab="Voltage", type="l")


%%Draw the third plot (bottom left), which coincide with plot3 of the assignement 
%%(see details of the code in "plot3.R")

plot(x=data$Datetime, y=data$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n") 
points(x=data$Datetime, y=data$Sub_metering_1, col="black", type="l") 
points(x=data$Datetime, y=data$Sub_metering_2, col="red", type="l")   
points(x=data$Datetime, y=data$Sub_metering_3, col="blue", type="l")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1))

%%Draw the last plot (bottomright)

with(data, plot(x=Datetime, y=Global_reactive_power, xlab="datetime", type="l"))


dev.off()