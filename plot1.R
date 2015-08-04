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
data$Time<-strptime(data$Time,format="%H:%M:%S",tz="UCT")

library("dplyr")
names(data)
data[,1]<-as.Date(data[,1],"%d/%m/%Y")
fil_data<-filter(data,Date=="2007-02-01"|Date=="2007-02-02")

summary(fil_data)
str(fil_data)




with(fil_data,hist(Global_active_power,col="red2",
               xlab="Global Active Power (kilowatts)",ylab="Frequency",
               main="Global Active Power",xlim=c(0,6)))
dev.copy(png,"plot1.png")
dev.off()







