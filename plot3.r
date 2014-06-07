#read file
electroData <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
#if you are using Winsows and your default locale not English uncomment this:
#Sys.setlocale("LC_TIME", "English") 

electroData <- subset(electroData,as.Date(electroData$Date,format="%d/%m/%Y")>="2007-02-01" & as.Date(electroData$Date,format="%d/%m/%Y")<="2007-02-02")
#subset required dates
electroData <- transform(electroData,WeekDay=strftime(strptime(paste(Date,Time),format="%d/%m/%Y %H:%M:%S"),format="%w"),fulltime=strptime(paste(Date,Time),format="%d/%m/%Y %H:%M:%S"))
#set plot params
par(mfrow=c(1,1),cex.lab=0.7, cex.axis=0.7, cex.main=1, cex.sub=0.7,mar=c(5,4,4,1))
#plotting
with(electroData,{
  plot(fulltime,as.numeric(as.vector(Sub_metering_1)),type="l",ylab="Energy Sub Metering",xlab="")
  lines(fulltime,as.numeric(as.vector(Sub_metering_2)),type="l",col="red",xlab="")
  lines(fulltime,as.numeric(as.vector(Sub_metering_3)),type="l",col="blue",xlab="")
  legend("topright",
         lty=c(1,1),
         col=c("black","blue","red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         cex=0.7, y.intersp=0.5
         )
})
#write to file
dev.copy(png,"plot3.png")
dev.off()