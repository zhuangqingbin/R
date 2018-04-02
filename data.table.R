library(data.table)
DT <- data.table(A=1:6,B=c("a","b","c"),C=rnorm(6),D=TRUE)
DF <- data.frame(A=1:6,B=c("a","b","c"),C=rnorm(6),D=TRUE)

#Selecting columns in j
DT[,.(B,C)]
#Computing on columns
DT[,.(Total=sum(A),Mean=mean(C))]
#Recycling in j
DT[,.(B,C=sum(C))]
#Throw anything into j
DT[,plot(A,C )]
DT[,{print(A)
    hist(C)
    NULL
  }]

#Doing j by group



#prefilter by key
DT[,E:=c("c","d")]
setkey(DT,B,E)
DT[list(c("a","b"),"c"),]

#sort
setorder(DT,-E)
DT

#sum groupby
DT[,.(mean=mean(A)),by=.(B,E)]

DT[,.(sum(C,na.rm = T),sd(C,na.rm = T))]
DT[,list(Mysum=sum(C),
         Mymin=min(C),
         Mymax=max(C)),by=.(B)]

#data merge
DT = data.table(x=rep(c("a","b","c"),each=3), y=c(1,3,6), v=1:9)  
X = data.table(c("b","c"),foo=c(4,2))
#based on DT
setkey(DT,x)
DT[X]   
#based on X
setkey(X,V1)  
X[DT]  

#merge
setkey(DT,x)
setkey(X,V1)
merge(DT,X)



####################
mydata = fread("https://github.com/arunsrinivasan/satrdays-workshop/raw/master/flights_2014.csv")
head(mydata[,c(2:6)])
#!!! 
dat1 = mydata[ , carrier] # 返回一组向量

dat1 = mydata[ , .(carrier)] #返回一个data.table

dat1 = mydata[, c("carrier"), with=FALSE] #返回一组数据框
#delete one column
mydata[, !c("origin"), with=FALSE]

mydata[,names(mydata) %like% "dep", with=FALSE]

#rename
setnames(mydata, c("dest","origin"), c("Destination", "origin.of.flight"))


