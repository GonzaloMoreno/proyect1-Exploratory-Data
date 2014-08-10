## load library
library(sqldf)

##exploratory analysis proyect 1

specdata<-setwd ("C:/Users/GMORENO/Documents/R/Exploratory Data analysis/")

if(!file.exists("proyecto1")){
  
  dir.create("proyecto1")  
  
}

url_dir<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url_dir, destfile="./proyecto1/household_power_consumption.zip")
file<- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"))
specdata<-setwd ("C:/Users/GMORENO/Documents/R/Exploratory Data analysis/proyecto1/")


dir_file<-"C:/Users/GMORENO/Documents/R/Exploratory Data analysis/proyecto1/household_power_consumption.txt"
file1 <- read.csv.sql(dir_file, sep=";",sql = 'select * from file where Date = "1/2/2007"')

on.exit(close(file1))

file2<- read.csv.sql(dir_file, sep=";",sql = 'select * from file where Date = "2/2/2007"')

on.exit(close(file2))
file_total<-rbind(file1,file2)
file_total$Time <- strptime(paste(file_total$Date,file_total$Time), "%d/%m/%Y %H:%M:%S")
file_total$Date<-as.Date(file_total$Date, "%d/%m/%Y")


## Esto sirve para el sistema horario al americano

Sys.setlocale("LC_TIME", "English")



## plot 3
png("plot3.png")
plot(file_total$Time, file_total$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(file_total$Time, file_total$Sub_metering_2, col="red")
lines(file_total$Time, file_total$Sub_metering_3, col="blue")
 ## uso lty en vez de pch porque la leyenda es una linea y uso bty="n" para borrar el borde de la caja de legend

legend("topright", col=c("black", "red", "blue"), lty=1,bty="n", legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()
