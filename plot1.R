fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="data.zip")
unzip("data.zip",list=TRUE)
data<-read.csv2(unz("data.zip","household_power_consumption.txt"),
        header=TRUE,colClasses=c("character"))

options(warn=-1)
for(i in 3:9){
        class(data[,i])<-"numeric"
}
options(warn=0)

library("dplyr")
names(data)
data[,1]<-as.Date(data[,1],"%d/%m/%Y")
library(chron)
data[,2]<-chron(times=data[,2])
fil_data<-filter(data,Date=="2007-02-01" | Date=="2007-02-02")


with(fil_data,hist(Global_active_power,col="red2",
               xlab="Global Active Power (kilowatts)",ylab="Frequency",
               main="Global Active Power",xlim=c(0,6)))
dev.copy(png,"plot1.png")
dev.off()







