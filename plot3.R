#Program for Plot2-Project1 in Exp_Data_Analysis

# Get the data: downloaded data is in Current Working Directory

KM_plot1.file = "exdata_data_household_power_consumption.zip"
if (!file.exists(KM_plot1.file))
{
  retval = download.file("https://d396qusza40orc.cloudfront.net/exdata_data_household_power_consumption.zip",
                         destfile = KM_plot1.file,
                         method = "curl")
}

## Reading the data from the contents of the zipped file
df.power = read.csv(unz(KM_plot1.file, "household_power_consumption.txt"), header=T,
                    sep=";", stringsAsFactors=F, na.strings="?",
                    colClasses=c("character", "character", "numeric",
                                 "numeric", "numeric", "numeric",
                                 "numeric", "numeric", "numeric"))

## Formatting the date and subseting the data only between 2007-02-01 and 2007-02-02
df.power$timestamp = strptime(paste(df.power$Date, df.power$Time),
                              format="%d/%m/%Y %H:%M:%S", tz="UTC")
startDate = strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="UTC")
endDate = strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="UTC")
df.power = df.power[df.power$timestamp >= startDate & df.power$timestamp <= endDate, ]

## Creating the plot
png(filename="plot3.png", width=480, height=480)
plot(df.power$timestamp, df.power$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering", main="Sub Metering and Power")
lines(df.power$timestamp, df.power$Sub_metering_2, col="red")
lines(df.power$timestamp, df.power$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=par("lwd"))
dev.off()