##Uygulama 1 #Correlation-Regression##
setwd("C:/Users/ol/Desktop")
getwd()
list.files()
data<-read.csv("dataset_tufe_vs_index.csv",header = T,sep = ",")
head(data,2)
cor(data[,2:4])

##p-value için Hmisc kütüphanesini yüklüyoruz ve çaðýrýyoruz.##
require(Hmisc)

colnames(data)
rcorr(cbind(data[,2],data[,3],data[,4]))

plot(data$tcmb_istanbul_2el,data$tufe)

#regresyon modelini kuruyoruz.
model<-lm(data$tcmb_istanbul_2el~data$tufe)
r<-resid(model)

plot(r,data$tcmb_istanbul_2el)



model2<-lm(log(data$tcmb_istanbul_2el)~data$tufe)

r<-resid(model2)
summary(model2)
r<-resid(model2)

plot(r,log)
     
#lmtest paketi yükleniyor ve paket çaðýrýlýyor. Durbin watson için.#
require(lmtest)


#nlme paketini yüklüyoruz ve paketi çaðýrýyoruz.
require(nlme)

#gls kullanýyoruz
tcmb_istanbul<-data$tcmb_istanbul_2el
tufe<-data$tufe

model3<-gls(tcmb_istanbul~tufe,correlation = corAR1(form=~1))


#Timeseries

#Timeseries formatý oluþturuyoruz.
tstufe<-ts(reidin,frequency = 12,start = c(2007,1))

#unit root için fUnitRoots paketini yüklüyoruz ve kütüphaneyi çaðýrýyoruz.
require(fUnitRoots)

#adf testi yapýyoruz
adfTest(tsreidin)

#fark alýp duraðan yapýyoruz.
adfTest(diff(tsreidin,1))
diffreidin<-diff(tsreidin,1)
tsarima<-arima(diffreidin,order=c(2,0,0)
               
#tahmin yapýyoruz 
require(forecast)
forecast.Arima(tsarima,h=1)





