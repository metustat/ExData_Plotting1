fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="data.zip")
unzip("data.zip",list=TRUE)
data<-read.csv2(unz("data.zip","household_power_consumption.txt"),
                header=TRUE,colClasses=c("character"))

str(data)
for(i in 3:9){
        class(data[,i])<-"numeric"
}
sapply(data,class)
summary(data)

object.size(data)

library("lubridate")
temp<-data[,1]
dtemp<-dmy(temp)

library("dplyr")
names(data)
data[,1]<-as.Date(data[,1],"%d/%m/%Y")
fil_data<-filter(data,Date=="2007-02-01"|Date=="2007-02-02")

summary(fil_data)
str(fil_data)

data$Time<-strptime(data$Time,format="%H:%M:%S",tz="UCT")

with(fil_data,plot(Global_active_power,xaxt="n",type="l",xlab="",ylab=""))
axis(1,c(0,1440,2880),labels=c("Thu","Fri","Sat"))
title(ylab="Global Active Power (kilowatts)")
dev.copy(png,"plot2.png")
dev.off()
