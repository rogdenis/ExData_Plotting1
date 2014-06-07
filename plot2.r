#if you are using Winsows and your default locale not English uncomment this:
#Sys.setlocale("LC_TIME", "English") 

#read file
electroData <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
#subset required dates
electroData <- subset(electroData,as.Date(electroData$Date,format="%d/%m/%Y")>="2007-02-01" & as.Date(electroData$Date,format="%d/%m/%Y")<="2007-02-02")
electroData <- transform(electroData,WeekDay=strftime(strptime(paste(Date,Time),format="%d/%m/%Y %H:%M:%S"),format="%w"),fulltime=strptime(paste(Date,Time),format="%d/%m/%Y %H:%M:%S"))
#set plot params
par(mfrow=c(1,1),cex.lab=0.7, cex.axis=0.7, cex.main=1, cex.sub=0.7,mar=c(5,4,4,1))
#plotting
with(electroData,plot(fulltime,as.numeric(as.vector(Global_active_power)),type="l",ylab="Global active power (kilowatts)",xlab=""))
#write to file
dev.copy(png,"plot2.png")
dev.off()