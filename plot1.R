#Program for Plot1-Project1 in Exp_Data_Analysis

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
df.power$Date = as.Date(df.power$Date, format="%d/%m/%Y")
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")
df.power = df.power[df.power$Date >= startDate & df.power$Date <= endDate, ]

## Creating the plot and save it as a .png
png(filename="plot1.png", width=480, height=480)
hist(df.power$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")
dev.off()